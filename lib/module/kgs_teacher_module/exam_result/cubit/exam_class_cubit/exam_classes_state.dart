import 'package:rts/module/kgs_teacher_module/exam_result/models/exam_class_response.dart';

import '../../../../../core/failures/base_failures/base_failure.dart';
//exam result wali get student ki api hi dairy ma use karni ha for get students
enum ExamClassesStatus {
  none,
  loading,
  success,
  failure,
}

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

