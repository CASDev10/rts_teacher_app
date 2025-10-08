import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/components/base_scaffold.dart';
import 'package:rts/components/custom_button.dart';
import 'package:rts/config/config.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/repo/auth_repository.dart';
import 'package:rts/module/kgs_teacher_module/student_result/cubit/marking_student/marking_student_cubit.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/create_update_award_input.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_input.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_marking_object.dart';
import 'package:rts/module/kgs_teacher_module/student_result/widgets/student_evaluation_widget.dart';
import 'package:rts/utils/display/display_utils.dart';

import '../../../../components/custom_appbar.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../cubit/marking_student/marking_student_state.dart';

class ResultMarkingScreen extends StatelessWidget {
  final StudentListInput input;
  final StudentListResponse response;

  const ResultMarkingScreen({
    super.key,
    required this.input,
    required this.response,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MarkingStudentCubit(sl())..init(response: response, input: input),
      child: ResultMarkingScreenView(),
    );
  }
}

class ResultMarkingScreenView extends StatefulWidget {
  const ResultMarkingScreenView({super.key});

  @override
  State<ResultMarkingScreenView> createState() =>
      _ResultMarkingScreenViewState();
}

class _ResultMarkingScreenViewState extends State<ResultMarkingScreenView> {
  List<StudentMarkingObject> examDetailList = [];
  void addToList(StudentMarkingObject object) {
    // Check if the list already contains an object with the same studentId
    examDetailList.removeWhere((item) => item.studentId == object.studentId);

    // Add the new object to the list
    examDetailList.add(object);
  }

  void removeByStudentId(int studentId) {
    examDetailList.removeWhere((item) => item.studentId == studentId);
  }

  AuthRepository authRepository = sl<AuthRepository>();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      hMargin: 0,
      appBar: CustomAppbar("Evaluate Students", centerTitle: true),
      backgroundColor: AppColors.primaryGreen,
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
        child: BlocConsumer<MarkingStudentCubit, MarkingStudentState>(
          listener: (context, state) {
            if (state.markingStudentStatus == MarkingStudentStatus.loading) {
              DisplayUtils.showLoader();
              // Show loading indicator
            } else if (state.markingStudentStatus ==
                MarkingStudentStatus.failure) {
              DisplayUtils.showToast(context, "Something went wrong");
            } else if (state.markingStudentStatus ==
                MarkingStudentStatus.success) {
              DisplayUtils.removeLoader();
              DisplayUtils.showToast(context, "Successfully Saved");
            }
          },
          builder: (context, state) {
            // if (state.markingStudentStatus == MarkingStudentStatus.loading) {
            //   return Center(child: CircularProgressIndicator());
            // } else if (state.markingStudentStatus ==
            //     MarkingStudentStatus.failure) {
            //   return Center(child: Text("Something went wrong"));
            // } else if (state.examDetailList.isEmpty) {
            //   return Center(child: Text("No Students Found"));
            // }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var detail = state.examDetailList[index];
                      return StudentEvaluationWidget(
                        awardList: state.awardListStatusList,
                        detail: detail,
                        onSave: (value) {
                          addToList(value);
                          print(value.awardListStatusId);
                          print(examDetailList.length);
                        },
                        onCancel: (value) {
                          removeByStudentId(detail.studentId);
                          print(examDetailList.length);
                        },
                        totalMarks: state.examMaster!.totalMarks!,
                      );
                    },
                    itemCount: state.examDetailList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 12.0);
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                CustomButton(
                  onPressed: () async {
                    if (examDetailList.isEmpty) {
                      DisplayUtils.showToast(
                        context,
                        "Atleast 1 Student must be Evaluated",
                      );
                    } else {
                      CreateUpdateAwardInput input = CreateUpdateAwardInput(
                        ucLoginUserId: authRepository.user.userId,
                        ucEntityId: authRepository.user.entityId.toInt(),
                        examMaster: state.examMaster!,
                        examDetailList: examDetailList,
                      );

                      bool flag = await context
                          .read<MarkingStudentCubit>()
                          .createUpdateAward(input);
                      if (flag == true) {
                        NavRouter.pop(context);
                        NavRouter.pop(context);
                      }
                    }
                  },
                  title: "Save Result",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
