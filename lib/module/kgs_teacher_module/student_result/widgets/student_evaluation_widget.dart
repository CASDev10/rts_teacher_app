import 'package:flutter/material.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/custom_dropdown.dart';
import '../../../../components/custom_textfield.dart';
import '../../../../constants/app_colors.dart';
import '../../../../utils/display/display_utils.dart';
import '../models/student_list_response.dart';
import '../models/student_marking_object.dart';

class StudentEvaluationWidget extends StatefulWidget {
  const StudentEvaluationWidget({
    super.key,
    required this.awardList,
    required this.detail,
    this.onSave,
    this.onCancel,
    required this.totalMarks,
  });
  final List<AwardListStatusList> awardList;
  final ExamDetailList detail;
  final Function(StudentMarkingObject)? onSave;
  final Function(bool)? onCancel;
  final double totalMarks;
  @override
  State<StudentEvaluationWidget> createState() =>
      _StudentEvaluationWidgetState();
}

class _StudentEvaluationWidgetState extends State<StudentEvaluationWidget> {
  AwardListStatusList? selectedAward;
  ExamDetailList? detail;
  final TextEditingController _obtainedMarksController =
      TextEditingController();

  getGrades(double marks) {
    if (marks >= 89.5) {
      return "A+";
    } else if (marks >= 80) {
      return "A";
    } else if (marks >= 70) {
      return "B+";
    } else if (marks >= 60) {
      return "B";
    } else if (marks >= 50) {
      return "C";
    } else if (marks >= 40) {
      return "D";
    } else {
      return "F";
    }
  }

  getPercentage(double marks) {
    if (widget.totalMarks <= 0) {
      return 0;
    }

    return (marks / widget.totalMarks) * 100;
  }

  setDetails() {
    double marks = double.parse(
      _obtainedMarksController.text.isEmpty
          ? "0"
          : _obtainedMarksController.text,
    );
    double percentage = getPercentage(marks);
    String grade = getGrades(marks);

    detail?.obtainedMarks = marks;
    detail?.obtainedGrade = grade;
    detail?.obtainedPercentage = percentage;
    detail?.awardListStatusId = selectedAward!.awardListStatusId;
  }

  setZero() {
    double marks = 0;
    double percentage = getPercentage(marks);
    String grade = getGrades(marks);
    detail?.obtainedMarks = marks;
    detail?.obtainedGrade = grade;
    detail?.obtainedPercentage = percentage;
    detail?.awardListStatusId = selectedAward!.awardListStatusId;
  }

  bool isMarked = false;
  @override
  void initState() {
    detail = widget.detail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: AppColors.primary),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _detailRow("Roll # : ", detail!.rollNumber),
          _spacer(),
          _detailRow("Student Name : ", detail!.studentName),
          _spacer(),
          _detailRow(
            "Percentage : ",
            "${detail!.obtainedPercentage.toStringAsFixed(2)} %",
          ),
          _spacer(),
          _detailRow(
            "Grade : ",
            detail!.obtainedGrade.isNotEmpty ? detail!.obtainedGrade : "F",
          ),
          _spacer(),
          _detailRow(
            "Obtained Marks : ",
            _obtainedMarksController.text.isEmpty
                ? detail!.obtainedMarks.toStringAsFixed(2)
                : double.parse(
                  _obtainedMarksController.text,
                ).toStringAsFixed(2),
          ),
          if (isMarked == true) ...[
            _spacer(),
            _detailRow(
              "Evaluation Status : ",
              detail!.awardListStatusId.toString(),
            ),
          ],
          _spacer(height: 2.0),
          Divider(),
          _spacer(height: 2.0),
          if (isMarked == false) ...[
            GeneralCustomDropDown(
              displayField: (item) => item.value,
              hint: "Select Evaluation",
              selectedValue: selectedAward,
              items: widget.awardList,
              allPadding: 0,
              horizontalPadding: 15,
              height: 50.0,
              isOutline: false,
              hintColor: AppColors.primary,
              iconColor: AppColors.primary,
              suffixIconPath: '',
              onSelect: (v) {
                setState(() {
                  selectedAward = v;
                  if (selectedAward?.awardListStatusId == 2 ||
                      selectedAward?.awardListStatusId == 5 ||
                      selectedAward?.awardListStatusId == 6) {
                    _obtainedMarksController.text = "";
                    setState(() {
                      setZero();
                    });
                  }
                  if (selectedAward?.awardListStatusId == 6) {
                    widget.onCancel!(true);
                  }
                });
              },
            ),
            _spacer(height: 6.0),
            if (selectedAward != null &&
                selectedAward?.awardListStatusId != 2 &&
                selectedAward?.awardListStatusId != 5 &&
                selectedAward?.awardListStatusId != 6)
              CustomTextField(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                onValidate: (value) {
                  // Check if the value is empty
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }

                  // Check if the value is a valid number
                  final number = double.tryParse(value);
                  if (number == null) {
                    return 'Please enter a valid number';
                  }

                  // Check if the number is less than 0 or greater than totalMarks
                  if (number < 0) {
                    return 'Value cannot be less than 0';
                  } else if (number > widget.totalMarks) {
                    return 'Value cannot be more than $widget.totalMarks';
                  }

                  // Check if there is more than one decimal point
                  int decimalCount = value.split('.').length - 1;
                  if (decimalCount > 1) {
                    return 'Only one decimal point is allowed';
                  }

                  return null; // Return null if validation is successful
                },
                onChange: (v) {
                  setState(() {
                    setDetails();
                  });
                },
                height: 40.0,
                hintText: 'Obtained Marks',
                hintColor: AppColors.primary,
                inputType: TextInputType.number,
                controller: _obtainedMarksController,
                fillColor: AppColors.lightGreyColor,
              ),
            _spacer(height: 6.0),
            if (selectedAward != null && selectedAward?.awardListStatusId != 6)
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          selectedAward = null;
                        });
                        widget.onCancel!(true);
                      },
                      title: "Cancel",
                      backgroundColor: Colors.transparent,
                      textColor: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (selectedAward != null) {
                          StudentMarkingObject object = StudentMarkingObject(
                            examDetailId: detail!.examDetailId,
                            studentId: detail!.studentId,
                            obtainedMarks: detail!.obtainedMarks,
                            obtainedPercentage: detail!.obtainedPercentage,
                            obtainedGrade: detail!.obtainedGrade,
                            attendanceStatusId: 2,
                            awardListStatusId:
                                selectedAward != null
                                    ? selectedAward!.awardListStatusId
                                    : 6,
                          );
                          if (selectedAward?.awardListStatusId != 6) {
                            setState(() {
                              isMarked = true;
                            });
                            widget.onSave!(
                              object,
                            ); // Call the callback function
                          } else {
                            DisplayUtils.showToast(
                              context,
                              "Please Enter Obtained Marks",
                            );
                          }
                        }
                      },
                      title: "Save",
                    ),
                  ),
                ],
              ),
          ],
          if (isMarked == true)
            CustomButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  selectedAward = null;
                  isMarked = false;
                  _obtainedMarksController.text = "";
                  detail?.obtainedMarks = 0;
                  detail?.obtainedPercentage = 0;
                  detail?.obtainedGrade = "F";
                });
                widget.onCancel!(true);
              },
              title: "UnMark",
              backgroundColor: Colors.transparent,
              textColor: AppColors.primary,
            ),
        ],
      ),
    );
  }

  Widget _detailRow(String key, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            key,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        SizedBox(width: 8.0), // Space between the key and the value
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _spacer({double? height}) {
    return SizedBox(height: height ?? 6.0);
  }
}
