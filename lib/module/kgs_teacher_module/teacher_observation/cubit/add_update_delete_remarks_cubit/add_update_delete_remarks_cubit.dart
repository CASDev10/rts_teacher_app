import 'package:bloc/bloc.dart';

import '../../../../../core/api_result.dart';
import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../../../../core/failures/high_priority_failure.dart';
import '../../../base_resposne_model.dart';
import '../../repo/observation_repo.dart';

part 'add_update_delete_remarks_state.dart';

class AddUpdateDeleteRemarksCubit extends Cubit<AddUpdateDeleteRemarksState> {
  AddUpdateDeleteRemarksCubit(this.repository)
    : super(AddUpdateDeleteRemarksState.initial());

  ObservationRepository repository;

  Future addObservationRemarks(String remarks, String areaId) async {
    emit(state.copyWith(remarksStatus: AddUpdateDeleteRemarksStatus.loading));
    try {
      BaseResponseModel baseResponseModel = await repository
          .addObservationRemarks(remarks, areaId);
      if (baseResponseModel.result == ApiResult.success) {
        emit(
          state.copyWith(remarksStatus: AddUpdateDeleteRemarksStatus.success),
        );
      } else {
        emit(
          state.copyWith(
            remarksStatus: AddUpdateDeleteRemarksStatus.failure,
            failure: HighPriorityException(baseResponseModel.message),
          ),
        );
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          remarksStatus: AddUpdateDeleteRemarksStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {}
  }

  Future updateObservationRemarks(
    String remarks,
    String areaId,
    String remarksId,
  ) async {
    emit(state.copyWith(remarksStatus: AddUpdateDeleteRemarksStatus.loading));
    try {
      BaseResponseModel baseResponseModel = await repository
          .updateObservationRemarks(remarksId, remarks, areaId);
      if (baseResponseModel.result == ApiResult.success) {
        emit(
          state.copyWith(remarksStatus: AddUpdateDeleteRemarksStatus.success),
        );
      } else {
        emit(
          state.copyWith(
            remarksStatus: AddUpdateDeleteRemarksStatus.failure,
            failure: HighPriorityException(baseResponseModel.message),
          ),
        );
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          remarksStatus: AddUpdateDeleteRemarksStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {}
  }

  Future deleteObservationRemarks(String remarksId) async {
    emit(state.copyWith(remarksStatus: AddUpdateDeleteRemarksStatus.loading));
    try {
      BaseResponseModel baseResponseModel = await repository
          .deleteObservationRemarks(remarksId);
      if (baseResponseModel.result == ApiResult.success) {
        emit(
          state.copyWith(remarksStatus: AddUpdateDeleteRemarksStatus.success),
        );
      } else {
        emit(
          state.copyWith(
            remarksStatus: AddUpdateDeleteRemarksStatus.failure,
            failure: HighPriorityException(baseResponseModel.message),
          ),
        );
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          remarksStatus: AddUpdateDeleteRemarksStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {}
  }
}
