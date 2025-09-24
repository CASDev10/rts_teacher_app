import 'package:flutter/material.dart';
import 'package:rts/constants/app_colors.dart';
import 'package:rts/module/kgs_teacher_module/student_evaluation/widgets/process_un_button.dart';
import 'package:rts/utils/display/display_utils.dart';

import '../models/student_evaluation_list_response.dart';

class StudentEvaluationListTile extends StatelessWidget {
  const StudentEvaluationListTile(
      {super.key, required this.student, this.onProcessClick, this.onTap});

  final StudentEvaluationDataModel student;
  final VoidCallback? onProcessClick;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          12.0,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12.0,
            ),
            border: Border.all(
              color: AppColors.primaryGreen,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                        child: Text(
                      student.studentName[0],
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.studentName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        student.rollNumber,
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ProcessUnButton(
              isProcessed: student.isProcessed,
              onClick: onProcessClick ??
                  () {
                    if (student.isProcessed) {
                      DisplayUtils.showToast(context, "Un Processing Result");
                    } else {
                      DisplayUtils.showToast(context, "Processing Result");
                    }
                  },
            )
          ],
        ),
      ),
    );
  }
}
