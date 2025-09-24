import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/base_scaffold.dart';
import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../utils/display/display_utils.dart';
import '../cubit/marking_student/marking_student_cubit.dart';
import '../cubit/marking_student/marking_student_state.dart';
import '../models/create_update_award_input.dart';
import '../models/student_list_input.dart';
import '../models/student_list_response.dart';
import '../models/student_marking_object.dart';
import '../widgets/student_evaluation_widget.dart';

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
      create:
          (context) =>
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

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      hMargin: 0,
      appBar: CustomAppbar("Evaluate Students", centerTitle: true),
      backgroundColor: AppColors.primary,
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
        child: BlocBuilder<MarkingStudentCubit, MarkingStudentState>(
          builder: (context, state) {
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
