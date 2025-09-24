import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api_result.dart';
import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../../../../core/failures/high_priority_failure.dart';
import '../../models/observation_remarks_response.dart';
import '../../repo/observation_repo.dart';
import 'fetch_observation_remarks_state.dart';

class FetchObservationRemarksCubit extends Cubit<FetchObservationRemarksState> {
  FetchObservationRemarksCubit(this.repository)
    : super(FetchObservationRemarksState.initial());
  ObservationRepository repository;

  Future getObservationRemarks() async {
    emit(
      state.copyWith(
        fetchObservationRemarksStatus: FetchObservationRemarksStatus.loading,
      ),
    );
    try {
      ObservationRemarksResponse observationRemarksResponse =
          await repository.getObservationRemarks();
      observationRemarksResponse.data.sort(
        (a, b) => b.createdDate.compareTo(a.createdDate),
      );
      if (observationRemarksResponse.result == ApiResult.success) {
        emit(
          state.copyWith(
            fetchObservationRemarksStatus:
                FetchObservationRemarksStatus.success,
            remarks: observationRemarksResponse.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            fetchObservationRemarksStatus:
                FetchObservationRemarksStatus.failure,
            failure: HighPriorityException(observationRemarksResponse.message),
          ),
        );
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          fetchObservationRemarksStatus: FetchObservationRemarksStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {}
  }
}
