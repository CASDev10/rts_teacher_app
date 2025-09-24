import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/module/kgs_teacher_module/leaves/cubit/leaves_cubit.dart';
import 'package:rts/module/kgs_teacher_module/student_result/widgets/leave_detail_dialoge.dart';

import '../model/employee_leaves_response.dart';

class LeaveTile extends StatelessWidget {
  const LeaveTile({super.key, required this.detail});

  final EmployeeLeaveModel detail;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return LeaveDetailDialogue(
                model: detail,
              );
            }).then((v) async {
          if (v) {
            Future.wait([
              context
                  .read<TeacherLeaveCubit>()
                  .fetchEmployeeLeaves(offSet: 0, next: 10),
              context.read<TeacherLeaveCubit>().fetchLeaveBalance()
            ]);
            // await context.read<TeacherLeaveCubit>().fetchEmployeeLeaves();
          }
        });
      },
      child: AspectRatio(
        aspectRatio: 20 / 9,
        child: Card(
          color: Colors.white,
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _detailsColumn(
                            name: 'Date',
                            value:
                                "${detail.fromDateString} - ${detail.toDateString}"),
                        returnStatus(
                          isApproved: detail.approved,
                          approval: detail.waitingForApproval,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.5,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _detailsColumn(
                            name: 'Apply Days', value: "${detail.days} Days"),
                        _detailsColumn(
                            name: 'Leave Balance', value: "${detail.approved}"),
                        _detailsColumn(
                          name: 'Leave Type',
                          value: detail.entityLeaveType,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _detailsColumn({required String name, required String value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  returnStatus({required bool isApproved, required int approval}) {
    if (approval == 1 && isApproved == true) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0,
        ),
        decoration: BoxDecoration(
            // color: Colors.green,
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(
              4.0,
            )),
        child: Text(
          "Approved",
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.green,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    } else if (approval == 1 && isApproved == false) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0,
        ),
        decoration: BoxDecoration(
            // color: Colors.green,
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(
              4.0,
            )),
        child: Text(
          "Rejected",
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.red,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0,
        ),
        decoration: BoxDecoration(
            // color: Colors.green,
            border: Border.all(color: Colors.orange),
            borderRadius: BorderRadius.circular(
              4.0,
            )),
        child: Text(
          "Pending",
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.orange,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    }
  }
}
