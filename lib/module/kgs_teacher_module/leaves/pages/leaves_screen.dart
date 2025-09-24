import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/components/base_scaffold.dart';
import 'package:rts/components/custom_button.dart';
import 'package:rts/config/config.dart';
import 'package:rts/constants/app_colors.dart';
import 'package:rts/module/kgs_teacher_module/leaves/cubit/leaves_cubit.dart';
import 'package:rts/module/kgs_teacher_module/leaves/model/employee_leaves_response.dart';
import 'package:rts/module/kgs_teacher_module/leaves/widgets/leave_tile.dart';
import 'package:rts/module/kgs_teacher_module/student_result/widgets/apply_leave_dialogue.dart';
import 'package:rts/utils/display/display_utils.dart';

import '../../../../components/custom_appbar.dart';
import '../../../../core/di/service_locator.dart';
import '../../attendance_history/widgets/attendance_card.dart';
import '../cubit/leaves_state.dart';

class LeavesScreen extends StatelessWidget {
  const LeavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeacherLeaveCubit(sl())
        ..fetchEmployeeLeaves(offSet: 0, next: 10)
        ..fetchLeaveBalance(),
      child: LeavesScreenView(),
    );
  }
}

class LeavesScreenView extends StatefulWidget {
  const LeavesScreenView({super.key});

  @override
  State<LeavesScreenView> createState() => _LeavesScreenViewState();
}

class _LeavesScreenViewState extends State<LeavesScreenView> {
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
        Future.wait([
          context.read<TeacherLeaveCubit>().fetchEmployeeLeaves(
              loadMore: true, offSet: returnOffset(), next: _next)
        ]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20) +
            const EdgeInsets.symmetric(vertical: 30),
        child: BlocConsumer<TeacherLeaveCubit, TeacherLeaveState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(state.leaveBalance.length, (index) {
                    var item = state.leaveBalance[index];
                    return Expanded(
                        child: AttendanceCard(
                      aspectRatio:
                          state.leaveBalance.length == 1 ? 3.0 : 14 / 9,
                      cardName: item.leaveTypeName,
                      value: item.balance.toString(),
                    ));
                  }),
                ),
                SizedBox(
                  height: 6,
                ),
                Text("Leaves",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 6,
                ),
                state.employeeLeaves.isNotEmpty
                    ? Expanded(
                        child: ListView.separated(
                          controller: _scrollController,
                          itemCount: state.employeeLeaves.length,
                          itemBuilder: (context, index) {
                            EmployeeLeaveModel employeeLeave =
                                state.employeeLeaves[index];
                            return LeaveTile(
                              detail: employeeLeave,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 12.0,
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                        child: Text(
                          "No Leaves Applied",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      )),
                SizedBox(
                  height: 12.0,
                ),
                CustomButton(
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return ApplyLeaveDialogue(
                              onSave: (value) async {
                                // value.file = file;
                                await context
                                    .read<TeacherLeaveCubit>()
                                    .addUpdateEmployeeLeave(input: value);
                                NavRouter.pop(context, true);
                              },
                              leaveBalance: state.leaveBalance);
                        }).then((v) async {
                      if (v) {
                        offset = 0;
                        Future.wait([
                          context.read<TeacherLeaveCubit>().fetchLeaveBalance(),
                          context
                              .read<TeacherLeaveCubit>()
                              .fetchEmployeeLeaves(offSet: offset, next: _next)
                        ]);
                      }
                    });
                  },
                  title: "Apply Leave",
                  height: 40.0,
                )
              ],
            );
          },
          listener: (BuildContext context, TeacherLeaveState state) {
            if (state.studentAttendanceStatus == TeacherLeaveStatus.failure) {
              DisplayUtils.showSnackBar(context, state.failure.message);
            }
          },
        ),
      ),
      hMargin: 0,
      appBar: CustomAppbar(
        "Apply Leaves",
        centerTitle: true,
      ),
      backgroundColor: AppColors.primaryGreen,
    );
  }
}
