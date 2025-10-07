import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/components/base_scaffold.dart';
import 'package:rts/components/custom_button.dart';
import 'package:rts/config/config.dart';
import 'package:rts/module/kgs_teacher_module/student_result/cubit/student_result/student_result_cubit.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/class_name_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/evaluation_type_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/grade_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/sections_name_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_input.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/subjects_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/pages/result_marking_screen.dart';
import 'package:rts/module/kgs_teacher_module/student_result/widgets/student_result_date_picker.dart';
import 'package:rts/utils/display/display_utils.dart';

import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_dropdown.dart';
import '../../../../components/custom_textfield.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../cubit/student_result/student_result_state.dart';
import '../models/evaluation_response.dart';
import '../widgets/dropdown_place_holder.dart';

class StudentResultScreen extends StatelessWidget {
  const StudentResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentResultCubit(sl())
        ..fetchGradesList()
        ..fetchEvaluationType(),
      child: StudentResultScreenView(),
    );
  }
}

class StudentResultScreenView extends StatefulWidget {
  const StudentResultScreenView({super.key});

  @override
  State<StudentResultScreenView> createState() =>
      _StudentResultScreenViewState();
}

class _StudentResultScreenViewState extends State<StudentResultScreenView> {
  String examDate = "";
  String submissionDate = "";
  GradeModel? selectedGrade;
  ClassNameModel? selectedClassName;
  SectionsList? selectedSection;
  SubjectsListExam? selectedSubject;

  EvaluationTypeModel? selectedEvaluatedType;
  EvaluationModel? selectedEvaluated;
  final TextEditingController _totalMarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      hMargin: 0,
      appBar: CustomAppbar("Student Result", centerTitle: true),
      backgroundColor: AppColors.primaryGreen,
      body: BlocBuilder<StudentResultCubit, StudentResultState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20) +
                const EdgeInsets.symmetric(vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  state.studentAttendanceStatus == StudentResultStatus.loading
                      ? DropdownPlaceHolder(
                          name: selectedGrade != null
                              ? selectedGrade!.gradeName
                              : "Select Grade",
                        )
                      : GeneralCustomDropDown<GradeModel>(
                          allPadding: 0,
                          horizontalPadding: 15,
                          selectedValue: selectedGrade,
                          isOutline: false,
                          hintColor: AppColors.primaryGreen,
                          iconColor: AppColors.primaryGreen,
                          suffixIconPath: '',
                          displayField: (item) => item.gradeName,
                          hint: 'Select Grade',
                          items: state.grades,
                          onSelect: (value) {
                            setState(() {
                              selectedGrade = value;
                              selectedClassName = null;
                              selectedSection = null;
                              selectedSubject = null;
                            });
                            context.read<StudentResultCubit>().fetchClassNames(
                              gradeId: value.gradeId,
                            );
                          },
                        ),
                  SizedBox(height: 12.0),
                  state.studentAttendanceStatus == StudentResultStatus.loading
                      ? DropdownPlaceHolder(
                          name: selectedClassName != null
                              ? selectedClassName!.className
                              : "Select Class",
                        )
                      : GeneralCustomDropDown<ClassNameModel>(
                          allPadding: 0,
                          selectedValue: selectedClassName,
                          horizontalPadding: 15,
                          isOutline: false,
                          hintColor: AppColors.primaryGreen,
                          iconColor: AppColors.primaryGreen,
                          suffixIconPath: '',
                          displayField: (item) => item.className,
                          hint: 'Select Class',
                          items: state.classNames,
                          onSelect: (value) {
                            setState(() {
                              setState(() {
                                selectedClassName = value;
                                selectedSection = null;

                                selectedSubject = null;
                              });
                              context
                                  .read<StudentResultCubit>()
                                  .fetchSectionsAndSubjects(
                                    classId: value.classId,
                                  );
                            });
                          },
                        ),
                  SizedBox(height: 12.0),
                  state.studentAttendanceStatus == StudentResultStatus.loading
                      ? DropdownPlaceHolder(
                          name: selectedSection != null
                              ? selectedSection!.sectionName
                              : "Select Section",
                        )
                      : GeneralCustomDropDown<SectionsList>(
                          allPadding: 0,
                          selectedValue: selectedSection,
                          horizontalPadding: 15,
                          isOutline: false,
                          hintColor: AppColors.primaryGreen,
                          iconColor: AppColors.primaryGreen,
                          suffixIconPath: '',
                          displayField: (item) => item.sectionName,
                          hint: 'Select Section',
                          items: state.sectionsNames,
                          onSelect: (value) {
                            setState(() {
                              setState(() {
                                selectedSection = value;
                              });
                            });
                          },
                        ),
                  SizedBox(height: 12.0),
                  state.studentAttendanceStatus == StudentResultStatus.loading
                      ? DropdownPlaceHolder(
                          name: selectedSubject != null
                              ? selectedSubject!.subjectName
                              : "Select Subject",
                        )
                      : GeneralCustomDropDown<SubjectsListExam>(
                          allPadding: 0,
                          selectedValue: selectedSubject,
                          horizontalPadding: 15,
                          isOutline: false,
                          hintColor: AppColors.primaryGreen,
                          iconColor: AppColors.primaryGreen,
                          suffixIconPath: '',
                          displayField: (item) => item.subjectName,
                          hint: 'Select Subject',
                          items: state.subjectsName,
                          onSelect: (value) {
                            setState(() {
                              setState(() {
                                selectedSubject = value;
                              });
                            });
                          },
                        ),
                  SizedBox(height: 12.0),
                  state.studentAttendanceStatus == StudentResultStatus.loading
                      ? DropdownPlaceHolder(
                          name: selectedEvaluatedType != null
                              ? selectedEvaluatedType!.name
                              : "Select Evaluation Type",
                        )
                      : GeneralCustomDropDown<EvaluationTypeModel>(
                          allPadding: 0,
                          selectedValue: selectedEvaluatedType,
                          horizontalPadding: 15,
                          isOutline: false,
                          hintColor: AppColors.primaryGreen,
                          iconColor: AppColors.primaryGreen,
                          suffixIconPath: '',
                          displayField: (item) => item.name,
                          hint: 'Select Evaluation Type',
                          items: state.evaluationTypes,
                          onSelect: (value) {
                            setState(() {
                              setState(() {
                                selectedEvaluatedType = value;
                              });
                              context
                                  .read<StudentResultCubit>()
                                  .fetchEvaluation(
                                    evaluationTypeId: value.evaluationTypeId,
                                  );
                            });
                          },
                        ),
                  SizedBox(height: 12.0),
                  state.studentAttendanceStatus == StudentResultStatus.loading
                      ? DropdownPlaceHolder(
                          name: selectedEvaluated != null
                              ? selectedEvaluated!.name
                              : "Select Evaluation",
                        )
                      : GeneralCustomDropDown<EvaluationModel>(
                          allPadding: 0,
                          selectedValue: selectedEvaluated,
                          horizontalPadding: 15,
                          isOutline: false,
                          hintColor: AppColors.primaryGreen,
                          iconColor: AppColors.primaryGreen,
                          suffixIconPath: '',
                          displayField: (item) => item.name,
                          hint: 'Select Evaluation',
                          items: state.evaluations,
                          onSelect: (value) {
                            setState(() {
                              setState(() {
                                selectedEvaluated = value;
                              });
                            });
                          },
                        ),
                  SizedBox(height: 12.0),
                  AddResultDatePicker(
                    stringFunction: (v) {
                      setState(() {
                        examDate = v;
                      });
                    },
                    hintText: 'Select Exam Date',
                  ),
                  SizedBox(height: 12.0),
                  AddResultDatePicker(
                    stringFunction: (v) {
                      setState(() {
                        submissionDate = v;
                      });
                    },
                    hintText: 'Select Submission Date',
                  ),
                  SizedBox(height: 12.0),
                  CustomTextField(
                    hintText: 'Total Marks',
                    hintColor: AppColors.primaryGreen,
                    inputType: TextInputType.number,
                    controller: _totalMarksController,
                    fillColor: AppColors.lightGreyColor,
                  ),
                  SizedBox(height: 24.0),
                  CustomButton(
                    onPressed: () async {
                      if (selectedGrade != null &&
                          selectedClassName != null &&
                          selectedSection != null &&
                          selectedSubject != null &&
                          selectedEvaluatedType != null &&
                          selectedEvaluated != null &&
                          _totalMarksController.text.isNotEmpty &&
                          examDate.isNotEmpty &&
                          submissionDate.isNotEmpty) {
                        StudentListInput input = StudentListInput(
                          examDate: examDate,
                          classIdFk: selectedClassName!.classId,
                          sectionIdFk: selectedSection!.sectionId,
                          subjectIdFk: selectedSubject!.subjectId,
                          evaluationIdFk: selectedEvaluated!.evaluationId,
                          evaluationGroupId:
                              selectedEvaluatedType!.evaluationTypeId,
                          submissionDate: submissionDate,
                          totalMarks: double.parse(_totalMarksController.text),
                        );

                        StudentListResponse? response = await context
                            .read<StudentResultCubit>()
                            .fetchStudentList(input: input);

                        if (response != null) {
                          NavRouter.push(
                            context,
                            ResultMarkingScreen(
                              input: input,
                              response: response,
                            ),
                          );
                        } else {
                          DisplayUtils.showSnackBar(
                            context,
                            "Something Went Wrong",
                          );
                        }
                      } else {
                        DisplayUtils.showSnackBar(
                          context,
                          "All Fields are Required",
                        );
                      }
                    },
                    title: "Get Students List",
                    height: 50.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
