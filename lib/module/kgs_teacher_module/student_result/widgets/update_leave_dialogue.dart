import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rts/module/kgs_teacher_module/student_result/widgets/student_result_date_picker.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/custom_dropdown.dart';
import '../../../../components/custom_textfield.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
import '../../../../utils/display/display_utils.dart';
import '../../leaves/model/employee_leaves_response.dart';
import '../../leaves/model/leave_balance_response.dart';

class UpdateLeaveDialogue extends StatefulWidget {
  const UpdateLeaveDialogue({
    super.key,
    required this.leaveBalance,
    required this.model,
  });
  final List<LeaveModel> leaveBalance;
  final EmployeeLeaveModel model;
  // final int id;
  @override
  State<UpdateLeaveDialogue> createState() => _UpdateLeaveDialogueState();
}

class _UpdateLeaveDialogueState extends State<UpdateLeaveDialogue> {
  String? fromDate, toDate;

  LeaveModel? selectedLeaveType;
  void selectLeaveTypeById(int id) {
    selectedLeaveType = widget.leaveBalance.firstWhere(
      (leave) => leave.leaveTypeId == id,
    );
  }

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

  String formatDate(String inputDate) {
    try {
      // Define input and output date formats
      DateFormat inputFormat = DateFormat('dd MMMM yyyy');
      DateFormat outputFormat = DateFormat('yyyy-MM-dd');

      // Parse and format
      DateTime dateTime = inputFormat.parse(inputDate);
      return outputFormat.format(dateTime);
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }
  }

  @override
  void initState() {
    setState(() {
      fromDate = widget.model.fromDateString;
      toDate = widget.model.toDateString;
      _reasonController.text = widget.model.reason;
      selectLeaveTypeById(widget.model.entityLeaveTypeId);
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
              "Update Leave",
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
                    selectedDate: formatDate(widget.model.fromDateString),
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
                    selectedDate: formatDate(widget.model.toDateString),
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
                      print(widget.model.id);
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
