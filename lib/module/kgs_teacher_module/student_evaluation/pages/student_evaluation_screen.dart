import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/module/kgs_teacher_module/student_evaluation/pages/students_evaluation_list_screen.dart';

import '../../../../components/base_scaffold.dart';
import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_dropdown.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../utils/display/display_utils.dart';
import '../../../../widgets/helper_function.dart';
import '../../class_section/model/classes_model.dart';
import '../../class_section/model/sections_model.dart';
import '../../student_result/models/evaluation_response.dart';
import '../../student_result/models/evaluation_type_response.dart';
import '../../student_result/widgets/dropdown_place_holder.dart';
import '../../student_result/widgets/student_result_date_picker.dart';
import '../cubit/student_evaluation_cubit.dart';
import '../cubit/student_evaluation_state.dart';
import '../models/student_evaluation_list_input.dart';

class StudentEvaluationPage extends StatelessWidget {
  const StudentEvaluationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              StudentsEvaluationCubit(sl())
                ..fetchClasses()
                ..fetchEvaluationType(),
      child: StudentEvaluationPageView(),
    );
  }
}

class StudentEvaluationPageView extends StatefulWidget {
  const StudentEvaluationPageView({super.key});

  @override
  State<StudentEvaluationPageView> createState() =>
      _StudentEvaluationPageViewState();
}

class _StudentEvaluationPageViewState extends State<StudentEvaluationPageView> {
  EvaluationTypeModel? selectedEvaluatedType;
  EvaluationModel? selectedEvaluated;
  String examDate = "";
  Class? selectedClass;
  Section? selectedSection;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      hMargin: 0,
      backgroundColor: AppColors.primary,
      appBar: CustomAppbar("Student Evaluation", centerTitle: true),
      body: Container(
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
        child: BlocBuilder<StudentsEvaluationCubit, StudentsEvaluationState>(
          builder: (context, state) {
            return Column(
              children: [
                state.studentEvaluationStatus ==
                        StudentsEvaluationStatus.loading
                    ? DropdownPlaceHolder(
                      name:
                          selectedClass != null
                              ? selectedClass!.className
                              : "Select Class",
                    )
                    : GeneralCustomDropDown<Class>(
                      allPadding: 0,
                      horizontalPadding: 15,
                      selectedValue: selectedClass,
                      isOutline: false,
                      hintColor: AppColors.primary,
                      iconColor: AppColors.primary,
                      suffixIconPath: '',
                      displayField: (item) => item.className,
                      hint: 'Select Class',
                      items: state.classes,
                      onSelect: (value) {
                        setState(() {
                          selectedClass = value;
                          selectedSection = null;
                        });
                        context.read<StudentsEvaluationCubit>().fetchSections(
                          value.classId.toString(),
                        );
                      },
                    ),
                SizedBox(height: 12.0),
                state.studentEvaluationStatus ==
                        StudentsEvaluationStatus.loading
                    ? DropdownPlaceHolder(
                      name:
                          selectedSection != null
                              ? selectedSection!.sectionName
                              : "Select Section ",
                    )
                    : GeneralCustomDropDown<Section>(
                      allPadding: 0,
                      horizontalPadding: 15,
                      selectedValue: selectedSection,
                      isOutline: false,
                      hintColor: AppColors.primary,
                      iconColor: AppColors.primary,
                      suffixIconPath: '',
                      displayField: (item) => item.sectionName,
                      hint: 'Select Section',
                      items: state.sections,
                      onSelect: (value) {
                        setState(() {
                          selectedSection = value;
                        });
                      },
                    ),
                SizedBox(height: 12.0),
                state.studentEvaluationStatus ==
                        StudentsEvaluationStatus.loading
                    ? DropdownPlaceHolder(
                      name:
                          selectedEvaluatedType != null
                              ? selectedEvaluatedType!.name
                              : "Select Evaluation Type ",
                    )
                    : GeneralCustomDropDown<EvaluationTypeModel>(
                      allPadding: 0,
                      horizontalPadding: 15,
                      selectedValue: selectedEvaluatedType,
                      isOutline: false,
                      hintColor: AppColors.primary,
                      iconColor: AppColors.primary,
                      suffixIconPath: '',
                      displayField: (item) => item.name,
                      hint: 'Select Evaluation Type',
                      items: state.evaluationTypes,
                      onSelect: (value) {
                        setState(() {
                          selectedEvaluatedType = value;
                          selectedEvaluated = null;
                        });
                        context.read<StudentsEvaluationCubit>().fetchEvaluation(
                          evaluationTypeId: value.evaluationTypeId,
                        );
                      },
                    ),
                SizedBox(height: 12.0),
                state.studentEvaluationStatus ==
                        StudentsEvaluationStatus.loading
                    ? DropdownPlaceHolder(
                      name:
                          selectedEvaluated != null
                              ? selectedEvaluated!.name
                              : "Select Evaluation",
                    )
                    : GeneralCustomDropDown<EvaluationModel>(
                      allPadding: 0,
                      horizontalPadding: 15,
                      selectedValue: selectedEvaluated,
                      isOutline: false,
                      hintColor: AppColors.primary,
                      iconColor: AppColors.primary,
                      suffixIconPath: '',
                      displayField: (item) => item.name,
                      hint: 'Select Evaluation',
                      items: state.evaluations,
                      onSelect: (value) {
                        setState(() {
                          selectedEvaluated = value;
                        });
                      },
                    ),
                SizedBox(height: 12.0),
                AddResultDatePicker(
                  stringFunction: (v) {
                    setState(() {
                      examDate = v;
                    });
                  },
                  hintText: 'Select Exam Date',
                ),
                SizedBox(height: 12.0),
                CustomButton(
                  onPressed: () async {
                    StudentEvaluationListInput input =
                        StudentEvaluationListInput(
                          classId: selectedClass!.classId,
                          sectionId: selectedSection!.sectionId,
                          evaluationTypeId:
                              selectedEvaluatedType!.evaluationTypeId,
                          evaluationId: selectedEvaluated!.evaluationId,
                          examDate: examDate,
                          ucSchoolId: returnSchoolId(),
                        );
                    await context
                        .read<StudentsEvaluationCubit>()
                        .fetchStudentsList(input);

                    if (state.studentList.isNotEmpty) {
                      NavRouter.push(
                        context,
                        StudentsEvaluationListScreen(
                          input: input,
                          studentList: state.studentList,
                        ),
                      ).then((v) async {
                        selectedEvaluated = null;
                        selectedEvaluatedType = null;
                        selectedSection = null;
                        selectedClass = null;
                        await Future.wait([
                          context
                              .read<StudentsEvaluationCubit>()
                              .clearStudentList(),
                          context
                              .read<StudentsEvaluationCubit>()
                              .fetchEvaluationType(),
                          context
                              .read<StudentsEvaluationCubit>()
                              .fetchClasses(),
                        ]);
                      });
                    } else {
                      DisplayUtils.showToast(
                        context,
                        "No Student Enrolled in this class",
                      );
                    }
                  },
                  title: "Get Students List",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
