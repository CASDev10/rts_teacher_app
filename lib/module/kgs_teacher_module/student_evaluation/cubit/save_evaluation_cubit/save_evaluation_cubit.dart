import 'package:bloc/bloc.dart';
import 'package:rts/module/kgs_teacher_module/student_evaluation/cubit/save_evaluation_cubit/save_evaluation_state.dart';

import '../../../../../core/api_result.dart';
import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../../../../core/failures/high_priority_failure.dart';
import '../../../../../utils/display/display_utils.dart';
import '../../../base_resposne_model.dart';
import '../../models/save_evaluation_input.dart';
import '../../models/student_evaluation_list_input.dart';
import '../../repo/student_evaluation_repository.dart';

class SaveEvaluationCubit extends Cubit<SaveEvaluationState> {
  SaveEvaluationCubit(this._repository) : super(SaveEvaluationState.initial());
  StudentEvaluationRepository _repository;

  StudentEvaluationListInput? input;

  Future saveEvaluationResult(SaveEvaluationInput input) async {
    DisplayUtils.showLoader();
    emit(state.copyWith(studentEvaluationStatus: SaveEvaluationStatus.loading));

    try {
      BaseResponseModel baseResponseModel = await _repository
          .saveOutcomeResults(input: input);

      if (baseResponseModel.result == ApiResult.success) {
        emit(
          state.copyWith(
            studentEvaluationStatus: SaveEvaluationStatus.success,
            result: baseResponseModel.result,
          ),
        );
      } else {
        emit(
          state.copyWith(
            studentEvaluationStatus: SaveEvaluationStatus.failure,
            failure: HighPriorityException(baseResponseModel.message),
          ),
        );
      }
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          studentEvaluationStatus: SaveEvaluationStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
      DisplayUtils.removeLoader();
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }
}
