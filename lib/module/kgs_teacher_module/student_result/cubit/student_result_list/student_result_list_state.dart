import '../../../../../../core/failures/base_failures/base_failure.dart';

enum StudentResultListStatus { none, loading, success, failure }

class StudentResultListState {
  final StudentResultListStatus studentAttendanceStatus;
  final BaseFailure failure;
  StudentResultListState({
    required this.studentAttendanceStatus,
    required this.failure,
  });

  factory StudentResultListState.initial() {
    return StudentResultListState(
      studentAttendanceStatus: StudentResultListStatus.none,
      failure: const BaseFailure(),
    );
  }

  StudentResultListState copyWith({
    StudentResultListStatus? studentAttendanceStatus,
    BaseFailure? failure,
  }) {
    return StudentResultListState(
      studentAttendanceStatus:
          studentAttendanceStatus ?? this.studentAttendanceStatus,
      failure: failure ?? this.failure,
    );
  }
}
