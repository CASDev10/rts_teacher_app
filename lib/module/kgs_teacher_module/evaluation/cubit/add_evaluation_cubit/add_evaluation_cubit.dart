import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api_result.dart';
import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../../../../core/failures/high_priority_failure.dart';
import '../../../base_resposne_model.dart';
import '../../models/add_evaluation_input.dart';
import '../../repo/evaluation_repo.dart';
import 'add_evaluation_state.dart';

class AddEvaluationCubit extends Cubit<AddEvaluationState> {
  AddEvaluationCubit(this.evaluationRepository)
    : super(AddEvaluationState.initial());

  EvaluationRepository evaluationRepository;

  Future addEvaluation(AddEvaluationInput addEvaluationInput) async {
    emit(state.copyWith(addEvaluationStatus: AddEvaluationStatus.loading));

    try {
      BaseResponseModel responseModel = await evaluationRepository
          .addEvaluationLogBook(addEvaluationInput);

      if (responseModel.result == ApiResult.success) {
        emit(state.copyWith(addEvaluationStatus: AddEvaluationStatus.success));
      } else {
        emit(
          state.copyWith(
            addEvaluationStatus: AddEvaluationStatus.failure,
            failure: HighPriorityException(responseModel.message),
          ),
        );
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          addEvaluationStatus: AddEvaluationStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {}
  }
}
