import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../models/exam_class_response.dart';

enum ExamClassesStatus { none, loading, success, failure }

class ExamClassesState {
  final ExamClassesStatus examClassesStatus;
  final BaseFailure failure;
  final List<ExamClassModel> classes;

  ExamClassesState({
    required this.examClassesStatus,
    required this.failure,
    required this.classes,
  });

  factory ExamClassesState.initial() {
    return ExamClassesState(
      examClassesStatus: ExamClassesStatus.none,
      failure: const BaseFailure(),
      classes: [],
    );
  }

  ExamClassesState copyWith({
    ExamClassesStatus? examClassesStatus,
    BaseFailure? failure,
    List<ExamClassModel>? classes,
  }) {
    return ExamClassesState(
      examClassesStatus: examClassesStatus ?? this.examClassesStatus,
      failure: failure ?? this.failure,
      classes: classes ?? this.classes,
    );
  }
}
