import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/module/kgs_teacher_module/student_result/cubit/student_result_list/student_result_list_state.dart'
    show StudentResultListStatus, StudentResultListState;
import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_input.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_response.dart';
import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../../../../core/failures/high_priority_failure.dart';
import '../../../../../utils/display/display_utils.dart';
import '../../repo/student_result_repo.dart';

class StudentResultListCubit extends Cubit<StudentResultListState> {
  StudentResultListCubit(this._repository)
    : super(StudentResultListState.initial());
  final StudentResultRepository _repository;

  Future fetchStudentList({required StudentListInput input}) async {
    DisplayUtils.showLoader();
    emit(
      state.copyWith(studentAttendanceStatus: StudentResultListStatus.loading),
    );

    try {
      StudentListResponse studentListResponse = await _repository
          .getStudentList(input: input);
      emit(
        state.copyWith(
          studentAttendanceStatus: StudentResultListStatus.success,
        ),
      );
      DisplayUtils.removeLoader();
      return studentListResponse;
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(
        state.copyWith(
          studentAttendanceStatus: StudentResultListStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }
}
