import 'package:rts/module/kgs_teacher_module/daily_diary/models/punishment_assignment_repsonse.dart';

import '../../../../../core/failures/base_failures/base_failure.dart';

enum TeacherAssignmentsStatus {
  none,
  loading,
  loadMore,
  success,
  failure,
}

class TeacherAssignmentsState {
  final TeacherAssignmentsStatus teacherAssignmentStatus;
  final BaseFailure failure;
  final List<AssignmentModel> assignments;

  TeacherAssignmentsState(
      {required this.teacherAssignmentStatus,
      required this.failure,
      required this.assignments});

  factory TeacherAssignmentsState.initial() {
    return TeacherAssignmentsState(
        teacherAssignmentStatus: TeacherAssignmentsStatus.none,
        failure: const BaseFailure(),
        assignments: []);
  }

  TeacherAssignmentsState copyWith({
    TeacherAssignmentsStatus? teacherAssignmentStatus,
    BaseFailure? failure,
    List<AssignmentModel>? assignments,
  }) {
    return TeacherAssignmentsState(
      teacherAssignmentStatus:
          teacherAssignmentStatus ?? this.teacherAssignmentStatus,
      failure: failure ?? this.failure,
      assignments: assignments ?? this.assignments,
    );
  }
}
