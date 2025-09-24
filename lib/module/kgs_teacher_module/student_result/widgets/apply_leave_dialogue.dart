import 'package:flutter/material.dart';
import 'package:rts/module/kgs_teacher_module/student_result/widgets/student_result_date_picker.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/custom_dropdown.dart';
import '../../../../components/custom_textfield.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
import '../../../../utils/display/display_utils.dart';
import '../../leaves/model/add_update_leave_input.dart';
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
  int calculateDaysBetweenDates() {
    if (fromDate == null || toDate == null) {
      DisplayUtils.showSnackBar(context, "Select Date");
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Apply Leave",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.0),
            ),
            SizedBox(height: 12.0),
            GeneralCustomDropDown<LeaveModel>(
              allPadding: 0,
              horizontalPadding: 15,
              isOutline: true,
              hintColor: AppColors.primary,
              iconColor: AppColors.primary,
              suffixIconPath: '',
              displayField: (item) => item.leaveTypeName,
              hint: 'Select Evaluation',
              items: widget.leaveBalance,
              onSelect: (value) {
                setState(() {
                  setState(() {
                    selectedLeaveType = value;
                  });
                });
              },
            ),
            SizedBox(height: 12.0),
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
                SizedBox(width: 6.0),
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
            SizedBox(height: 12.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: AppColors.primary),
              ),
              child: CustomTextField(
                hintText: "Enter Reason",
                maxLines: 4,
                controller: _reasonController,
              ),
            ),
            SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      if (selectedLeaveType == null ||
                          fromDate == null ||
                          toDate == null ||
                          _reasonController.text.isEmpty) {
                        print(id);
                        DisplayUtils.showSnackBar(
                          context,
                          "All Fields are Required",
                        );
                      } else {
                        int days = calculateDaysBetweenDates();
                        AddUpdateLeaveInput input = AddUpdateLeaveInput(
                          id: id,
                          entityLeaveTypeId:
                              selectedLeaveType?.leaveTypeId ?? 0,
                          fromDate: fromDate!,
                          toDate: toDate!,
                          reason: _reasonController.text,
                          days: days,
                        );

                        widget.onSave!(input);
                      }
                    },
                    title: "Save",
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: CustomButton(
                    fontSize: 14.0,
                    onPressed: () {
                      NavRouter.pop(context);
                    },
                    title: "Cancel ",
                    backgroundColor: Colors.transparent,
                    textColor: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
