import 'package:flutter/material.dart';

import '../../../../components/text_view.dart';
import '../../../../constants/app_colors.dart';
import '../models/attendance_reponse.dart';

class AttendanceTile extends StatefulWidget {
  const AttendanceTile({
    super.key,
    required this.attendanceModel,
    required this.index,
    this.onSelect,
  });

  final AttendanceModel attendanceModel;
  final int index;
  final Function(int status, int studentId)? onSelect;

  @override
  State<AttendanceTile> createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: FractionalOffset.centerLeft,
          // width: 30.0,
          padding: const EdgeInsets.only(right: 3.0, left: 5.0),
          child: TextView(
            widget.index < 10 ? "0${widget.index}" : "${widget.index}",
            color: AppColors.primary,
            fontSize: 13,
          ),
        ),
        Container(
          alignment: FractionalOffset.centerLeft,
          width: 95.0,
          padding: const EdgeInsets.only(right: 3.0, left: 5),
          child: Text(
            widget.attendanceModel.studentName.toString(),
            style: TextStyle(color: Colors.grey[800], fontSize: 13),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.attendanceModel.attendanceStatusIdFk = 2;
                    if (widget.onSelect != null) {
                      widget.onSelect!(
                        widget.attendanceModel.attendanceStatusIdFk,
                        widget.attendanceModel.studentId,
                      );
                    }
                  });
                },
                child: Container(
                  alignment: FractionalOffset.center,
                  width: 24.0,
                  height: 24.0,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          widget.attendanceModel.attendanceStatusIdFk == 2
                              ? AppColors.primary
                              : AppColors.greyColor,
                    ),
                    color:
                        widget.attendanceModel.attendanceStatusIdFk == 2
                            ? AppColors.primary
                            : AppColors.transparent,
                  ),
                  child: Visibility(
                    visible: widget.attendanceModel.attendanceStatusIdFk == 2,
                    child: Icon(
                      Icons.done,
                      size: 16,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.attendanceModel.attendanceStatusIdFk = 1;
                    if (widget.onSelect != null) {
                      widget.onSelect!(
                        widget.attendanceModel.attendanceStatusIdFk,
                        widget.attendanceModel.studentId,
                      );
                    }
                  });
                },
                child: Container(
                  alignment: FractionalOffset.center,
                  width: 24.0,
                  height: 24.0,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          widget.attendanceModel.attendanceStatusIdFk == 1
                              ? AppColors.primary
                              : AppColors.greyColor,
                    ),
                    color:
                        widget.attendanceModel.attendanceStatusIdFk == 1
                            ? AppColors.primary
                            : AppColors.transparent,
                  ),
                  child: Visibility(
                    visible: widget.attendanceModel.attendanceStatusIdFk == 1,
                    child: Icon(
                      Icons.done,
                      size: 16,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.attendanceModel.attendanceStatusIdFk = 3;
                    if (widget.onSelect != null) {
                      widget.onSelect!(
                        widget.attendanceModel.attendanceStatusIdFk,
                        widget.attendanceModel.studentId,
                      );
                    }
                  });
                },
                child: Container(
                  alignment: FractionalOffset.center,
                  width: 24.0,
                  height: 24.0,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          widget.attendanceModel.attendanceStatusIdFk == 3
                              ? AppColors.primary
                              : AppColors.greyColor,
                    ),
                    color:
                        widget.attendanceModel.attendanceStatusIdFk == 3
                            ? AppColors.primary
                            : AppColors.transparent,
                  ),
                  child: Visibility(
                    visible: widget.attendanceModel.attendanceStatusIdFk == 3,
                    child: Icon(
                      Icons.done,
                      size: 16,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
