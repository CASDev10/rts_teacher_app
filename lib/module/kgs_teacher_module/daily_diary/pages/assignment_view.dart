import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/components/base_scaffold.dart';
import 'package:rts/components/custom_button.dart';
import 'package:rts/components/custom_dropdown.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/cubit/teacher_assignment_cubit/teacher_assignment_cubit.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/assignment_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/punishment_assignment_repsonse.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/work_type.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/widgets/assignment_expansion_tile.dart';

import '../../../../components/custom_appbar.dart';
import '../../../../components/loading_indicator.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../cubit/teacher_assignment_cubit/teacher_assignment_state.dart';

class TeacherAssignment extends StatelessWidget {
  const TeacherAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeacherAssignmentsCubit(sl()),
      child: TeacherAssignmentView(),
    );
  }
}

class TeacherAssignmentView extends StatefulWidget {
  const TeacherAssignmentView({super.key});

  @override
  State<TeacherAssignmentView> createState() => _TeacherAssignmentViewState();
}

class _TeacherAssignmentViewState extends State<TeacherAssignmentView> {
  WorkType? selectedWorkType;
  final int _next = 10;
  int offset = 0;

  returnOffset() {
    offset += _next;
    return offset;
  }

  List<WorkType> types = [
    WorkType(type: "All", id: 0),
    WorkType(type: "Assignemnt", id: 2),
    WorkType(type: "Punishment", id: 1),
  ];

  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    AssignmentInput input = AssignmentInput(
      offSet: returnOffset(),
      next: _next,
      type: selectedWorkType != null ? selectedWorkType?.id : 0,
    );
    context.read<TeacherAssignmentsCubit>().fetchTeacherAssignments(input);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        AssignmentInput input = AssignmentInput(
          offSet: returnOffset(),
          next: _next,
          type: selectedWorkType != null ? selectedWorkType?.id : 0,
        );
        Future.wait([
          context
              .read<TeacherAssignmentsCubit>()
              .fetchTeacherAssignments(input, loadMore: true)
        ]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: const CustomAppbar(
          'Assignments',
          centerTitle: true,
        ),
        backgroundColor: AppColors.primaryGreen,
        hMargin: 0,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20) +
              const EdgeInsets.symmetric(vertical: 30),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          ),
          child: Column(
            children: [
              GeneralCustomDropDown<WorkType>(
                hint: "Select Work Type",
                items: types,
                allPadding: 0,
                horizontalPadding: 15,
                isOutline: false,
                hintColor: AppColors.primaryGreen,
                iconColor: AppColors.primaryGreen,
                suffixIconPath: '',
                displayField: (v) => v.type,
                onSelect: (v) {
                  setState(() {
                    selectedWorkType = v;
                  });
                },
              ),
              SizedBox(
                height: 12.0,
              ),
              BlocBuilder<TeacherAssignmentsCubit, TeacherAssignmentsState>(
                  builder: (context, state) {
                if (state.teacherAssignmentStatus ==
                    TeacherAssignmentsStatus.loading) {
                  return Expanded(
                    child: Center(
                      child: LoadingIndicator(),
                    ),
                  );
                }
                if (state.teacherAssignmentStatus ==
                        TeacherAssignmentsStatus.success ||
                    state.teacherAssignmentStatus ==
                        TeacherAssignmentsStatus.loadMore) {
                  return Expanded(
                      child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.assignments.length,
                    itemBuilder: (context, index) {
                      AssignmentModel model = state.assignments[index];
                      return AssignmentExpansionTile(model: model);
                    },
                  ));
                }
                if (state.teacherAssignmentStatus ==
                    TeacherAssignmentsStatus.failure) {
                  return Center(
                    child: Text(state.failure.message),
                  );
                }
                return Expanded(child: SizedBox());
              }),
              SizedBox(
                height: 12.0,
              ),
              CustomButton(
                  onPressed: () {
                    offset = 0;
                    AssignmentInput input = AssignmentInput(
                        offSet: offset,
                        next: _next,
                        type: selectedWorkType != null
                            ? selectedWorkType?.id
                            : 0);
                    context
                        .read<TeacherAssignmentsCubit>()
                        .fetchTeacherAssignments(input);
                  },
                  title: "Get Assignments")
            ],
          ),
        ));
  }
}
