import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/components/base_scaffold.dart';
import 'package:rts/module/kgs_teacher_module/student_evaluation/models/evaluation_by_student_id_response.dart';
import 'package:rts/module/kgs_teacher_module/student_evaluation/models/process_result_input.dart';
import 'package:rts/module/kgs_teacher_module/student_evaluation/models/student_evaluation_list_input.dart';
import 'package:rts/module/kgs_teacher_module/student_evaluation/models/student_outcomes_input.dart';
import 'package:rts/module/kgs_teacher_module/student_evaluation/models/unProcess_result_input.dart';
import 'package:rts/module/kgs_teacher_module/student_evaluation/widgets/student_evaluation_list_tile.dart';
import 'package:rts/utils/display/display_utils.dart';

import '../../../../components/custom_appbar.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../cubit/student_evaluation_cubit.dart';
import '../cubit/student_evaluation_state.dart';
import '../models/student_evaluation_list_response.dart';
import 'evaluation_form_screen.dart';

class StudentsEvaluationListScreen extends StatelessWidget {
  const StudentsEvaluationListScreen(
      {super.key, required this.input, required this.studentList});

  final StudentEvaluationListInput input;
  final List<StudentEvaluationDataModel> studentList;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentsEvaluationCubit(sl())
        ..init(
          input: input,
          studentList: studentList,
        ),
      child: StudentsEvaluationListScreenView(),
    );
  }
}

class StudentsEvaluationListScreenView extends StatefulWidget {
  const StudentsEvaluationListScreenView({
    super.key,
  });

  @override
  State<StudentsEvaluationListScreenView> createState() =>
      _StudentsEvaluationListScreenViewState();
}

class _StudentsEvaluationListScreenViewState
    extends State<StudentsEvaluationListScreenView> {
  bool? isProcessed;

  @override
  Widget build(BuildContext context) {
    var stdContext = context.read<StudentsEvaluationCubit>();
    return BaseScaffold(
      hMargin: 0,
      backgroundColor: AppColors.primaryGreen,
      appBar: CustomAppbar(
        "${stdContext.state.studentList.first.className} - ${stdContext.state.studentList.first.sectionName}",
        centerTitle: true,
      ),
      body: BlocBuilder<StudentsEvaluationCubit, StudentsEvaluationState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              await stdContext.fetchStudentsList(stdContext.input!,
                  showLoading: false);
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20) +
                  const EdgeInsets.symmetric(vertical: 30),
              child: ListView.separated(
                itemCount: state.studentList.length,
                itemBuilder: (context, index) {
                  var student = state.studentList[index];
                  return StudentEvaluationListTile(
                    student: student,
                    onProcessClick: () {
                      if (student.isProcessed == true) {
                        UnProcessResultInput input =
                            UnProcessResultInput(examId: student.examId);
                        stdContext.unProcessResult(input).then((v) async {
                          await stdContext.fetchStudentsList(stdContext.input!);
                        });
                      } else {
                        isProcessed = student.isProcessed;
                        ProcessResultInput input = ProcessResultInput(
                            examIds: student.examId.toString(),
                            examDate: stdContext.input!.examDate,
                            ucSchoolId: stdContext.input!.ucSchoolId);
                        stdContext.processResult(input).then((v) async {
                          await stdContext.fetchStudentsList(stdContext.input!);
                          if (student.isProcessed == isProcessed) {
                            DisplayUtils.showToast(
                                context, "Please Submit Evaluation Form First");
                          }
                        });
                      }
                    },
                    onTap: () async {
                      if (student.isProcessed == true) {
                        DisplayUtils.showToast(
                            context, "Un Process Result to make Changes");
                        return;
                      }
                      StudentOutcomesInput input = StudentOutcomesInput(
                          classId: stdContext.input!.classId,
                          sectionId: stdContext.input!.sectionId,
                          evaluationTypeId: stdContext.input!.evaluationTypeId,
                          evaluationId: stdContext.input!.evaluationId,
                          examDate: stdContext.input!.examDate,
                          studentId: student.studentId,
                          ucSchoolId: stdContext.input!.ucSchoolId);

                      StudentOutcomesListResponse? response =
                          await stdContext.fetchStudentOutcomes(input);
                      if (response != null) {
                        if (response.outcomeParents.isEmpty &&
                            response.outcomeChilds.isEmpty) {
                          DisplayUtils.showSnackBar(context,
                              "No Outcomes Available for this Student");
                        } else {
                          NavRouter.push(
                              context,
                              EvaluationFormScreen(
                                parents: response.outcomeParents,
                                student: student,
                                evalInput: stdContext.input!,
                                children: response.outcomeChilds,
                              )).then((v) async {
                            if (v == true) {
                              await stdContext
                                  .fetchStudentsList(stdContext.input!);
                            }
                          });
                        }
                      } else {
                        DisplayUtils.showSnackBar(
                            context, "Something Went Wrong");
                      }
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 12.0,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
