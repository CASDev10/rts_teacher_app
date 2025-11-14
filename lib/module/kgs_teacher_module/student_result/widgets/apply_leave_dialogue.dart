import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rts/components/custom_textfield.dart';
import 'package:rts/config/config.dart';
import 'package:rts/module/kgs_teacher_module/leaves/model/add_update_leave_input.dart';
import 'package:rts/module/kgs_teacher_module/student_result/widgets/student_result_date_picker.dart';
import 'package:rts/utils/display/display_utils.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/custom_dropdown.dart';
import '../../../../constants/app_colors.dart';
import '../../../../utils/display/dialogs/dialog_utils.dart';
import '../../../../widgets/helper_function.dart';
import '../../leaves/model/employee_leaves_response.dart';
import '../../leaves/model/leave_balance_response.dart';

class ApplyLeaveDialogue extends StatefulWidget {
  const ApplyLeaveDialogue({
    super.key,
    required this.leaveBalance,
    this.onSave,
    this.model,
  });

  final List<LeaveModel> leaveBalance;
  final Function(AddUpdateLeaveInput)? onSave;
  final EmployeeLeaveModel? model;

  @override
  State<ApplyLeaveDialogue> createState() => _ApplyLeaveDialogueState();
}

class _ApplyLeaveDialogueState extends State<ApplyLeaveDialogue> {
  late int id;
  String? fromDate, toDate;
  LeaveModel? selectedLeaveType;
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController fileNameController = TextEditingController();
  FilePickerResult? result;
  File? file;

  Future<MultipartFile> changeMulti(File file) async {
    MultipartFile multipartFile =
        await MultipartFile.fromFile(file.path, filename: file.path);
    return multipartFile;
  }

  int calculateDaysBetweenDates() {
    if (fromDate == null || toDate == null) {
      DisplayUtils.showToast(context, "Select Date");
      return 0;
    }
    DateTime from = DateTime.parse(fromDate!);
    DateTime to = DateTime.parse(toDate!);

    // Calculate the difference
    Duration difference = to.difference(from);

    // Return the number of days as an integer
    return difference.inDays;
  }

  @override
  void initState() {
    setState(() {
      if (widget.model != null) {
        id = widget.model!.id;
        toDate = widget.model!.toDateString;
        fromDate = widget.model!.fromDateString;
        _reasonController.text = widget.model!.reason;
      } else {
        id = 0;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Apply Leave",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              GeneralCustomDropDown<LeaveModel>(
                allPadding: 0,
                horizontalPadding: 15,
                isOutline: true,
                hintColor: AppColors.primaryGreen,
                iconColor: AppColors.primaryGreen,
                suffixIconPath: '',
                displayField: (item) => item.leaveTypeName,
                hint: 'Select Leave Type',
                items: widget.leaveBalance,
                onSelect: (value) {
                  setState(() {
                    setState(() {
                      selectedLeaveType = value;
                    });
                  });
                },
              ),
              SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: AddResultDatePicker(
                      isOutline: true,
                      stringFunction: (v) {
                        setState(() {
                          fromDate = v;
                        });
                      },
                      hintText: 'From',
                    ),
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Expanded(
                    child: AddResultDatePicker(
                      isOutline: true,
                      stringFunction: (v) {
                        setState(() {
                          toDate = v;
                        });
                      },
                      hintText: 'To',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: AppColors.primaryGreen)),
                child: CustomTextField(
                  fillColor: AppColors.lightGreyColor,
                  hintText: "Enter Reason",
                  bottomMargin: 0,
                  maxLines: 4,
                  controller: _reasonController,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    border: Border.all(color: AppColors.primaryGreen),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          hintText: 'Upload Attachment',
                          height: 50,
                          readOnly: true,
                          bottomMargin: 0,
                          fontSize: 12,
                          controller: fileNameController,
                          fontWeight: FontWeight.normal,
                          inputType: TextInputType.text,
                          fillColor: AppColors.lightGreyColor,
                          hintColor: AppColors.primaryGreen,
                          onTap: () async {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: Wrap(
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.camera_alt),
                                        title: Text('Take Photo'),
                                        onTap: () async {
                                          Navigator.pop(context);
                                          await checkCameraPermission(); // Close the bottom sheet
                                          final pickedFile =
                                              await ImagePicker().pickImage(
                                            source: ImageSource.camera,
                                          );
                                          if (pickedFile != null) {
                                            file = File(pickedFile.path);

                                            // Format current date/time
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd-hh-mm-a')
                                                    .format(DateTime.now());

                                            // Get extension from the original file
                                            String extension =
                                                pickedFile.path.split('.').last;

                                            // Combine formatted date with extension
                                            fileNameController.text =
                                                '$formattedDate.$extension';

                                            setState(() {});
                                          } else {
                                            DisplayUtils.showToast(
                                                context, "No photo taken");
                                          }
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.insert_drive_file),
                                        title: Text('Pick File'),
                                        onTap: () async {
                                          Navigator.pop(
                                              context); // Close the bottom sheet
                                          result = await FilePicker.platform
                                              .pickFiles(
                                            type: FileType.custom,
                                            allowMultiple: false,
                                            allowedExtensions: [
                                              'pdf',
                                              'doc',
                                              'docx',
                                              'txt',
                                              'jpg',
                                              'jpeg',
                                              'png',
                                              'xlsx',
                                              'xlsm',
                                              'xlsb',
                                              'xltx',
                                              'ppt',
                                              'pptx'
                                            ],
                                          );
                                          if (result == null) {
                                            DisplayUtils.showToast(
                                                context, "No file selected");
                                          } else {
                                            file = File(result!
                                                .files.single.path
                                                .toString());
                                            fileNameController.text =
                                                result!.files.single.name;
                                            setState(() {});
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                    ),
                    CustomButton(
                      height: 52,
                      width: 90,
                      borderRadius: 10,
                      onPressed: () {
                        if (result != null) {
                          DialogUtils.confirmationDialog(
                              context: context,
                              title: 'Confirmation!',
                              content:
                                  'Are you sure you want to remove the file?',
                              onPressYes: () {
                                fileNameController.clear();
                                result = null;
                                setState(() {});
                                NavRouter.pop(context);
                              });
                        }
                      },
                      title: 'Remove',
                      isEnabled: true,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    onPressed: () async {
                      if (selectedLeaveType == null ||
                          fromDate == null ||
                          toDate == null ||
                          _reasonController.text.isEmpty) {
                        print(id);
                        DisplayUtils.showToast(
                            context, "All Fields are Required");
                      } else {
                        int days = calculateDaysBetweenDates();
                        AddUpdateLeaveInput input = AddUpdateLeaveInput(
                            id: id,
                            entityLeaveTypeId:
                                selectedLeaveType?.leaveTypeId ?? 0,
                            fromDate: fromDate!,
                            toDate: toDate!,
                            reason: _reasonController.text,
                            days: days);
                        input.file = await changeMulti(file!);
                        widget.onSave!(input);
                      }
                    },
                    title: "Save",
                    fontSize: 14.0,
                  )),
                  SizedBox(width: 8.0),
                  Expanded(
                      child: CustomButton(
                    fontSize: 14.0,
                    onPressed: () {
                      NavRouter.pop(context);
                    },
                    title: "Cancel ",
                    backgroundColor: Colors.transparent,
                    textColor: AppColors.primaryGreen,
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
