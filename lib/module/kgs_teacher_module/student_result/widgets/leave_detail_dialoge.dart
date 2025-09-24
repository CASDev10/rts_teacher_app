import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/components/custom_button.dart';
import 'package:rts/constants/app_colors.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/repo/auth_repository.dart';
import 'package:rts/module/kgs_teacher_module/leaves/cubit/leaves_cubit.dart';
import 'package:rts/module/kgs_teacher_module/leaves/model/employee_leaves_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/widgets/update_leave_dialogue.dart';

import '../../../../config/routes/nav_router.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../widgets/helper_function.dart';

class LeaveDetailDialogue extends StatelessWidget {
  LeaveDetailDialogue({super.key, required this.model});

  final EmployeeLeaveModel model;
  final AuthRepository _authRepository = sl<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${_authRepository.user.fullName} on ${model.entityLeaveType} : ${model.days} days",
              style: TextStyle(
                // fontSize: 12.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            Divider(),
            _detailRow("Leave Type", model.entityLeaveType),
            _spacer(),
            _detailRow(
                "From", "${model.fromDateString} to ${model.toDateString}"),
            _spacer(),
            _detailRow("Duration", "${model.days} days"),
            _spacer(),
            _detailRow("Applied On", model.fromDateString),
            _spacer(),
            _detailRow(
                "Status",
                returnStatus(
                    isApproved: model.approved,
                    approval: model.waitingForApproval)),
            _spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Attachment",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: InkWell(
                    child: Text(
                      "Download File",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.blue),
                    ),
                    onTap: () {
                      openUrlInBrowser(model.fileDownloadLink);
                    },
                  ),
                ),
              ],
            ),
            _spacer(),
            _detailRow("Description", model.reason),
            _spacer(height: 4),
            Divider(),
            _spacer(height: 4),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  onPressed: () async {
                    print(model.id);
                    await context.read<TeacherLeaveCubit>().fetchLeaveBalance();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return UpdateLeaveDialogue(
                          leaveBalance: context
                              .read<TeacherLeaveCubit>()
                              .state
                              .leaveBalance,
                          model: model,
                        );
                      },
                    );
                  },
                  title: "Edit",
                  fontSize: 14.0,
                )),
                SizedBox(width: 8.0),
                Expanded(
                    child: CustomButton(
                  fontSize: 14.0,
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: Text("Cancel Leave"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    "Are you sure you want to cancel the leave ?"),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomButton(
                                      onPressed: () async {
                                        await context
                                            .read<TeacherLeaveCubit>()
                                            .deleteLeave(id: model.id);
                                        NavRouter.pop(context, true);
                                      },
                                      title: "Yes",
                                      height: 35.0,
                                    )),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Expanded(
                                        child: CustomButton(
                                      onPressed: () {
                                        NavRouter.pop(context, false);
                                      },
                                      backgroundColor: Colors.transparent,
                                      textColor: AppColors.primaryGreen,
                                      title: "No",
                                      height: 35.0,
                                    )),
                                  ],
                                )
                              ],
                            ))).then((v) {
                      NavRouter.pop(context, v);
                    });

                    // await context
                    //     .read<TeacherLeaveCubit>()
                    //     .deleteLeave(id: model.id);
                  },
                  title: "Cancel Leave",
                  backgroundColor: Colors.transparent,
                  textColor: AppColors.primaryGreen,
                )),
              ],
            )
          ],
        ),
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
                fontSize: 12.0),
          ),
        ),
        SizedBox(width: 8.0), // Space between the key and the value
        Expanded(
          child: Text(
            value,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 12.0),
          ),
        ),
      ],
    );
  }

  Widget _spacer({double? height}) {
    return SizedBox(
      height: height ?? 6.0,
    );
  }

  returnStatus({required bool isApproved, required int approval}) {
    if (approval == 1 && isApproved == true) {
      return "Approved";
    } else if (approval == 1 && isApproved == false) {
      return "Rejected";
    } else {
      return "Pending";
    }
  }
}
