import '../../../../../../core/failures/base_failures/base_failure.dart';
import '../../class_section/model/classes_model.dart';
import '../../class_section/model/sections_model.dart';
import '../../student_result/models/evaluation_response.dart';
import '../../student_result/models/evaluation_type_response.dart';
import '../models/student_evaluation_list_response.dart';

enum StudentsEvaluationStatus {
  none,
  loading,
  success,
  failure,
}

class StudentsEvaluationState {
  final StudentsEvaluationStatus studentEvaluationStatus;
  final BaseFailure failure;
  final List<EvaluationTypeModel> evaluationTypes;
  final List<StudentEvaluationDataModel> studentList;
  final List<EvaluationModel> evaluations;
  final List<Class> classes;
  final List<Section> sections;

  StudentsEvaluationState({
    required this.studentEvaluationStatus,
    required this.failure,
    required this.studentList,
    required this.classes,
    required this.sections,
    required this.evaluationTypes,
    required this.evaluations,
  });

  factory StudentsEvaluationState.initial() {
    return StudentsEvaluationState(
      studentEvaluationStatus: StudentsEvaluationStatus.none,
      failure: const BaseFailure(),
      evaluationTypes: [],
      evaluations: [],
      classes: [],
      sections: [],
      studentList: [],
    );
  }

  StudentsEvaluationState copyWith({
    StudentsEvaluationStatus? studentEvaluationStatus,
    BaseFailure? failure,
    List<EvaluationTypeModel>? evaluationTypes,
    List<EvaluationModel>? evaluations,
    List<Class>? classes,
    List<StudentEvaluationDataModel>? studentList,
    List<Section>? sections,
  }) {
    return StudentsEvaluationState(
        studentEvaluationStatus:
            studentEvaluationStatus ?? this.studentEvaluationStatus,
        failure: failure ?? this.failure,
        classes: classes ?? this.classes,
        sections: sections ?? this.sections,
        evaluationTypes: evaluationTypes ?? this.evaluationTypes,
        evaluations: evaluations ?? this.evaluations,
        studentList: studentList ?? this.studentList);
  }
}
