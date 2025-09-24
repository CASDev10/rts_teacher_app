import 'package:bloc/bloc.dart';
import 'package:rts/core/failures/base_failures/base_failure.dart';
import 'package:rts/core/failures/high_priority_failure.dart';
import 'package:rts/module/kgs_teacher_module/attendance_history/models/attendance_history_model.dart';
import 'package:rts/utils/display/display_utils.dart';

import '../models/attendance_history_input.dart';
import '../repo/attendance_history_repo.dart';
import 'attendance_history_state.dart';

class AttendanceHistoryCubit extends Cubit<AttendanceHistoryState> {
  AttendanceHistoryCubit(this._repository)
      : super(AttendanceHistoryState.initial());
  AttendanceHistoryRepository _repository;

  List<AttendanceHistoryModel> attendanceHistoryList = [];

  Future fetchAttendanceHistoryList(
      {required AttendanceHistoryInput input, bool loadMore = false}) async {
    DisplayUtils.showLoader();

    emit(state.copyWith(
        studentAttendanceStatus: loadMore
            ? AttendanceHistoryStatus.loadMore
            : AttendanceHistoryStatus.loading));
    if (loadMore) {
      DisplayUtils.showLoader();
    } else {
      attendanceHistoryList.clear();
    }
    try {
      AttendanceHistoryResponse attendanceHistoryResponse =
          await _repository.getEmployeeAttendance(input: input);
      attendanceHistoryList.addAll(attendanceHistoryResponse.data);

      emit(state.copyWith(
        studentAttendanceStatus: AttendanceHistoryStatus.success,
        attendanceHistoryList: attendanceHistoryList,
      ));
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(state.copyWith(
          studentAttendanceStatus: AttendanceHistoryStatus.success,
          failure: HighPriorityException(e.message)));
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }
}
