import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/base_scaffold.dart';
import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_textfield.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../utils/display/display_utils.dart';
import '../cubit/save_evaluation_cubit/save_evaluation_cubit.dart';
import '../cubit/save_evaluation_cubit/save_evaluation_state.dart';
import '../models/evaluation_by_student_id_response.dart';
import '../models/save_evaluation_input.dart';
import '../models/student_evaluation_list_input.dart';
import '../models/student_evaluation_list_response.dart';
import '../widgets/evaluation_form_widget.dart';

class EvaluationFormScreen extends StatelessWidget {
  const EvaluationFormScreen({
    super.key,
    required this.parents,
    required this.children,
    required this.student,
    required this.evalInput,
  });

  final List<OutcomeParent> parents;
  final List<OutcomeChild> children;
  final StudentEvaluationListInput evalInput;
  final StudentEvaluationDataModel student;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SaveEvaluationCubit(sl()),
      child: EvaluationFormScreenView(
        parents: parents,
        student: student,
        evalInput: evalInput,
        children: children,
      ),
    );
  }
}

class EvaluationFormScreenView extends StatefulWidget {
  const EvaluationFormScreenView({
    super.key,
    required this.parents,
    required this.children,
    required this.student,
    required this.evalInput,
  });

  final List<OutcomeParent> parents;
  final List<OutcomeChild> children;
  final StudentEvaluationListInput evalInput;
  final StudentEvaluationDataModel student;

  @override
  State<EvaluationFormScreenView> createState() =>
      _EvaluationFormScreenViewState();
}

class _EvaluationFormScreenViewState extends State<EvaluationFormScreenView> {
  List<KinderGartenTermOneResultDetail> resultList = [];
  final TextEditingController _descriptionController = TextEditingController();

  void addOrUpdateResult(KinderGartenTermOneResultDetail newDetail) {
    resultList.removeWhere(
      (item) =>
          item.gradeId == newDetail.gradeId &&
          item.subGradeId == newDetail.subGradeId,
    );

    resultList.add(newDetail);
  }

  void defaultListCreator() {
    for (var item in widget.children) {
      if (item.isWorkingWithin == true ||
          item.isWorkingTowards == true ||
          item.isWorkingBeyond == true) {
        KinderGartenTermOneResultDetail data = KinderGartenTermOneResultDetail(
          gradeId: item.parentId,
          subGradeId: item.outcomeId,
          isWorkingTowards: item.isWorkingTowards,
          isWorkingWithin: item.isWorkingWithin,
          isWorkingBeyond: item.isWorkingBeyond,
        );
        resultList.add(data);
      }
    }
  }

  @override
  void initState() {
    defaultListCreator();
    if (widget.children.isNotEmpty) {
      print(widget.children.first.toJson());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var parents =
        widget.parents
            .where((v) => (v.outcome ?? '').trim().isNotEmpty)
            .toList();
    return BaseScaffold(
      hMargin: 0,
      backgroundColor: AppColors.primary,
      appBar: CustomAppbar(
        "${widget.student.studentName} - Evaluation",
        centerTitle: true,
      ),
      body: BlocConsumer<SaveEvaluationCubit, SaveEvaluationState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20) +
                const EdgeInsets.symmetric(vertical: 30),
            child: ListView(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: parents.length,
                  itemBuilder: (context, index) {
                    var parent = parents[index];
                    return EvaluationFormWidget(
                      parent: parent,
                      children:
                          widget.children
                              .where((v) => v.parentId == parent.outcomeId)
                              .toList(),
                      onSelect: (v) {
                        addOrUpdateResult(v);
                        print(resultList.length);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 12.0);
                  },
                ),
                SizedBox(height: 6.0),
                Divider(),
                SizedBox(height: 6.0),
                CustomTextField(
                  hintText: "Enter Teacher Comments",
                  maxLines: 5,
                  controller: _descriptionController,
                  maxLength: 500,
                ),
                Divider(),
                SizedBox(height: 4.0),
                CustomButton(
                  onPressed: () async {
                    if (resultList.length != widget.children.length) {
                      DisplayUtils.showSnackBar(
                        context,
                        "Answer All Questions",
                      );
                    } else if (_descriptionController.text.isEmpty) {
                      DisplayUtils.showSnackBar(
                        context,
                        "Comments Can't be Empty",
                      );
                    } else {
                      SaveEvaluationInput input = SaveEvaluationInput(
                        examId: widget.student.examId,
                        classId: widget.evalInput.classId,
                        sectionId: widget.evalInput.sectionId,
                        evaluationTypeId: widget.evalInput.evaluationTypeId,
                        evaluationId: widget.evalInput.evaluationId,
                        examDate: widget.evalInput.examDate,
                        studentId: widget.student.studentId,
                        teachersGeneralComments: "",
                        kinderGartenTermOneResultDetail: resultList,
                        ucSchoolId: widget.evalInput.ucSchoolId,
                      );
                      await context
                          .read<SaveEvaluationCubit>()
                          .saveEvaluationResult(input);
                    }
                  },
                  title: "Save Outcomes",
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, SaveEvaluationState state) {
          if (state.result == "success") {
            NavRouter.pop(context, true);
          }
        },
      ),
    );
  }
}
