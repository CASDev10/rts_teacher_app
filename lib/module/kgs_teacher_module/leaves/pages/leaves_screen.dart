import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/base_scaffold.dart';
import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../attendance_history/widgets/attendance_card.dart';
import '../../student_result/widgets/apply_leave_dialogue.dart';
import '../cubit/leaves_cubit.dart';
import '../cubit/leaves_state.dart';
import '../model/employee_leaves_response.dart';
import '../widgets/leave_tile.dart';

class LeavesScreen extends StatelessWidget {
  const LeavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              TeacherLeaveCubit(sl())
                ..fetchEmployeeLeaves()
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
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Container(
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
        child: BlocBuilder<TeacherLeaveCubit, TeacherLeaveState>(
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
                      ),
                    );
                  }),
                ),
                SizedBox(height: 6),
                Text(
                  "Leaves",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
                state.employeeLeaves.isNotEmpty
                    ? Expanded(
                      child: ListView.separated(
                        itemCount: state.employeeLeaves.length,
                        itemBuilder: (context, index) {
                          EmployeeLeaveModel employeeLeave =
                              state.employeeLeaves[index];
                          return LeaveTile(detail: employeeLeave);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 12.0);
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
                      ),
                    ),
                SizedBox(height: 12.0),
                CustomButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ApplyLeaveDialogue(
                          onSave: (value) async {
                            await context
                                .read<TeacherLeaveCubit>()
                                .addUpdateEmployeeLeave(input: value);
                            NavRouter.pop(context, true);
                          },
                          leaveBalance: state.leaveBalance,
                        );
                      },
                    ).then((v) async {
                      if (v) {
                        await context
                            .read<TeacherLeaveCubit>()
                            .fetchEmployeeLeaves();
                      }
                    });
                  },
                  title: "Apply Leave",
                  height: 40.0,
                ),
              ],
            );
          },
        ),
      ),
      hMargin: 0,
      appBar: CustomAppbar("Apply Leaves", centerTitle: true),
      backgroundColor: AppColors.primary,
    );
  }
}
