import 'package:bloc/bloc.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../../../../core/failures/high_priority_failure.dart';
import '../../../../../utils/display/display_utils.dart';
import '../../../base_resposne_model.dart';
import '../../../kgs_teacher_auth/repo/auth_repository.dart';
import '../../models/create_update_award_input.dart';
import '../../models/student_list_input.dart';
import '../../models/student_list_response.dart';
import '../../repo/student_result_repo.dart';
import 'marking_student_state.dart';

class MarkingStudentCubit extends Cubit<MarkingStudentState> {
  MarkingStudentCubit(this._repository) : super(MarkingStudentState.initial());
  StudentResultRepository _repository;
  final AuthRepository _authRepository = sl<AuthRepository>();

  Future init({
    required StudentListResponse response,
    required StudentListInput input,
  }) async {
    DisplayUtils.showLoader();
    emit(state.copyWith(markingStudentStatus: MarkingStudentStatus.loading));

    try {
      emit(
        state.copyWith(
          markingStudentStatus: MarkingStudentStatus.success,
          awardListStatusList: response.data.awardListStatusList,
          examDetailList: response.data.examDetailList,
          examMaster: input,
        ),
      );
      DisplayUtils.removeLoader();
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future createUpdateAward(CreateUpdateAwardInput input) async {
    DisplayUtils.showLoader();
    emit(state.copyWith(markingStudentStatus: MarkingStudentStatus.loading));

    try {
      BaseResponseModel response = await StudentResultRepository()
          .createUpdateAwardList(input: input);
      emit(state.copyWith(markingStudentStatus: MarkingStudentStatus.success));

      DisplayUtils.removeLoader();
      if (response.result == "success") {
        return true;
      }
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(
        state.copyWith(
          markingStudentStatus: MarkingStudentStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }
}
