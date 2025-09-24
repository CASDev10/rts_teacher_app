import 'package:bloc/bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/failures/high_priority_failure.dart';
import '../../../../utils/display/display_utils.dart';
import '../../kgs_teacher_auth/repo/auth_repository.dart';
import '../models/attendance_history_input.dart';
import '../models/attendance_history_model.dart';
import '../repo/attendance_history_repo.dart';
import 'attendance_history_state.dart';

class AttendanceHistoryCubit extends Cubit<AttendanceHistoryState> {
  AttendanceHistoryCubit(this._repository)
    : super(AttendanceHistoryState.initial());
  AttendanceHistoryRepository _repository;
  final AuthRepository _authRepository = sl<AuthRepository>();

  Future fetchAttendanceHistoryList({
    required String startDate,
    required String endDate,
  }) async {
    DisplayUtils.showLoader();
    final AttendanceHistoryInput input = AttendanceHistoryInput(
      startDate: startDate,
      endDate: endDate,
      empId: _authRepository.user.userId,
      ucEntityId: _authRepository.user.entityId,
      ucSchoolId: _authRepository.user.schoolId ?? -1,
    );

    emit(
      state.copyWith(studentAttendanceStatus: AttendanceHistoryStatus.loading),
    );
    try {
      AttendanceHistoryResponse attendanceHistoryResponse = await _repository
          .getEmployeeAttendance(input: input);

      emit(
        state.copyWith(
          studentAttendanceStatus: AttendanceHistoryStatus.success,
          attendanceHistoryList: attendanceHistoryResponse.data,
        ),
      );
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(
        state.copyWith(
          studentAttendanceStatus: AttendanceHistoryStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }
}
