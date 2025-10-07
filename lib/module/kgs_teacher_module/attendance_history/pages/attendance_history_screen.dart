import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rts/components/base_scaffold.dart';
import 'package:rts/components/custom_appbar.dart';
import 'package:rts/components/custom_button.dart';
import 'package:rts/module/kgs_teacher_module/attendance_history/cubit/attendance_history_cubit.dart';
import 'package:rts/utils/utils.dart';

import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../cubit/attendance_history_state.dart';
import '../models/attendance_history_input.dart';
import '../widgets/attendance_card.dart';
import '../widgets/attendance_history_card.dart';
import '../widgets/date_picker.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Yesterday Date: ${getYesterdayDate()}");
    print("Month before Date: ${getDate30DaysBefore()}");
    return BlocProvider(
      create: (context) => AttendanceHistoryCubit(sl())
        ..fetchAttendanceHistoryList(
            input: AttendanceHistoryInput(
                startDate: getDate30DaysBefore(),
                endDate: getYesterdayDate(),
                offset: 0,
                next: 10)),
      child: AttendanceHistoryScreenView(),
    );
  }

  String getYesterdayDate() {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));
    String formattedDate = DateFormat('yyyy-MM-dd').format(yesterday);
    return formattedDate;
  }

  String getDate30DaysBefore() {
    DateTime today = DateTime.now();
    DateTime date30DaysBefore = today.subtract(Duration(days: 30));
    String formattedDate = DateFormat('yyyy-MM-dd').format(date30DaysBefore);
    return formattedDate;
  }
}

class AttendanceHistoryScreenView extends StatefulWidget {
  const AttendanceHistoryScreenView({super.key});

  @override
  State<AttendanceHistoryScreenView> createState() =>
      _AttendanceHistoryScreenViewState();
}

class _AttendanceHistoryScreenViewState
    extends State<AttendanceHistoryScreenView> {
  String startDate = "";
  String endDate = "";
  final int _next = 10;
  int offset = 0;

  returnOffset() {
    offset += _next;
    return offset;
  }

  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        AttendanceHistoryInput input = AttendanceHistoryInput(
            startDate: startDate,
            endDate: endDate,
            offset: returnOffset(),
            next: _next);
        Future.wait([
          context
              .read<AttendanceHistoryCubit>()
              .fetchAttendanceHistoryList(input: input, loadMore: true)
        ]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      hMargin: 0,
      backgroundColor: AppColors.primaryGreen,
      appBar: CustomAppbar(
        "Attendance History",
        centerTitle: true,
      ),
      body: BlocConsumer<AttendanceHistoryCubit, AttendanceHistoryState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20) +
                const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: AttendanceCard(
                      cardName: 'Presents',
                      value:
                          "${state.attendanceHistoryList.isNotEmpty ? state.attendanceHistoryList.first.presents : 0}",
                      // value: "",
                    )),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                        child: AttendanceCard(
                      cardName: 'Absents',
                      value:
                          "${state.attendanceHistoryList.isNotEmpty ? state.attendanceHistoryList.first.absents : 0}",
                      // value: "${state.attendanceHistoryList.length}",
                    )),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Text("Duration",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AttendanceDatePicker(
                        stringFunction: (v) {
                          setState(() {
                            startDate = v;
                          });
                        },
                      ),
                    ),
                    Text(
                      "  to  ",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: AttendanceDatePicker(
                        stringFunction: (v) {
                          setState(() {
                            endDate = v;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text("Attendance History",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 12.0,
                ),
                Expanded(
                  child: state.attendanceHistoryList.isNotEmpty
                      ? ListView.separated(
                          controller: _scrollController,
                          itemCount: state.attendanceHistoryList.length,
                          itemBuilder: (context, index) {
                            var model = state.attendanceHistoryList[index];
                            return AttendanceHistoryCard(
                              model: model,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 14.0,
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "No Attendance History Found",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                CustomButton(
                  onPressed: () {
                    offset = 0;
                    if (startDate.isNotEmpty || endDate.isNotEmpty) {
                      context
                          .read<AttendanceHistoryCubit>()
                          .fetchAttendanceHistoryList(
                              input: AttendanceHistoryInput(
                                  startDate: startDate,
                                  endDate: endDate,
                                  offset: offset,
                                  next: _next));
                    } else {
                      DisplayUtils.showToast(
                          context, "Please Select Start and End Date");
                    }
                  },
                  title: "Get Attendance History",
                )
              ],
            ),
          );
        },
        listener: (BuildContext context, AttendanceHistoryState state) {},
      ),
    );
  }
}
