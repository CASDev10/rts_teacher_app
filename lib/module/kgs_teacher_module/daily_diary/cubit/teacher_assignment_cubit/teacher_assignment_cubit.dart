import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/cubit/teacher_assignment_cubit/teacher_assignment_state.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/assignment_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/punishment_assignment_repsonse.dart';

import '../../../../../core/api_result.dart';
import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../../../../core/failures/high_priority_failure.dart';
import '../../../../../utils/display/display_utils.dart';
import '../../repo/diary_repo.dart';

class TeacherAssignmentsCubit extends Cubit<TeacherAssignmentsState> {
  TeacherAssignmentsCubit(this._repository)
      : super(TeacherAssignmentsState.initial());
  DiaryRepository _repository;
  List<AssignmentModel> assignments = [];

  Future fetchTeacherAssignments(AssignmentInput input,
      {bool loadMore = false}) async {
    emit(state.copyWith(
        teacherAssignmentStatus: loadMore
            ? TeacherAssignmentsStatus.loadMore
            : TeacherAssignmentsStatus.loading));

    if (loadMore) {
      DisplayUtils.showLoader();
    } else {
      assignments.clear();
    }
    try {
      PunishmentAssignmentResponse responseModel =
          await _repository.getAssignmentPunishment(input);

      if (responseModel.result == ApiResult.success) {
        assignments.addAll(responseModel.parentsFileList);

        emit(state.copyWith(
          teacherAssignmentStatus: TeacherAssignmentsStatus.success,
          assignments: assignments,
        ));
      } else {
        emit(state.copyWith(
            teacherAssignmentStatus: TeacherAssignmentsStatus.success,
            failure: HighPriorityException(responseModel.message)));
      }
    } on BaseFailure catch (e) {
      emit(state.copyWith(
          teacherAssignmentStatus: TeacherAssignmentsStatus.success,
          failure: HighPriorityException(e.message)));
    } catch (_) {}
    if (loadMore) {
      DisplayUtils.removeLoader();
    }
  }
}
