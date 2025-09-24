import '../../../../../core/failures/base_failures/base_failure.dart';
import '../models/attendance_history_model.dart';

enum AttendanceHistoryStatus {
  none,
  loading,
  loadMore,
  success,
  failure,
}

class AttendanceHistoryState {
  final AttendanceHistoryStatus studentAttendanceStatus;
  final BaseFailure failure;
  final List<AttendanceHistoryModel> attendanceHistoryList;

  AttendanceHistoryState({
    required this.studentAttendanceStatus,
    required this.failure,
    required this.attendanceHistoryList,
  });

  factory AttendanceHistoryState.initial() {
    return AttendanceHistoryState(
      studentAttendanceStatus: AttendanceHistoryStatus.none,
      failure: const BaseFailure(),
      attendanceHistoryList: [],
    );
  }

  AttendanceHistoryState copyWith({
    AttendanceHistoryStatus? studentAttendanceStatus,
    BaseFailure? failure,
    List<AttendanceHistoryModel>? attendanceHistoryList,
  }) {
    return AttendanceHistoryState(
      studentAttendanceStatus:
          studentAttendanceStatus ?? this.studentAttendanceStatus,
      failure: failure ?? this.failure,
      attendanceHistoryList:
          attendanceHistoryList ?? this.attendanceHistoryList,
    );
  }
}
