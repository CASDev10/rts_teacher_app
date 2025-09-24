import '../../../../../../core/failures/base_failures/base_failure.dart';

enum SaveEvaluationStatus {
  none,
  loading,
  success,
  failure,
}

class SaveEvaluationState {
  final SaveEvaluationStatus studentEvaluationStatus;
  final BaseFailure failure;
  final String result;

  SaveEvaluationState({
    required this.studentEvaluationStatus,
    required this.failure,
    required this.result,
  });

  factory SaveEvaluationState.initial() {
    return SaveEvaluationState(
      studentEvaluationStatus: SaveEvaluationStatus.none,
      failure: const BaseFailure(),
      result: '',
    );
  }

  SaveEvaluationState copyWith(
      {SaveEvaluationStatus? studentEvaluationStatus,
      BaseFailure? failure,
      String? result}) {
    return SaveEvaluationState(
        studentEvaluationStatus:
            studentEvaluationStatus ?? this.studentEvaluationStatus,
        failure: failure ?? this.failure,
        result: result ?? this.result);
  }
}
