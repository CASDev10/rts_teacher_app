import 'package:rts/module/kgs_teacher_module/student_result/models/class_name_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/evaluation_type_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/grade_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/sections_name_response.dart';

import '../../../../../../core/failures/base_failures/base_failure.dart';
import '../../models/evaluation_response.dart';
import '../../models/subjects_response.dart';

enum StudentResultStatus {
  none,
  loading,
  success,
  failure,
}

class StudentResultState {
  final StudentResultStatus studentAttendanceStatus;
  final BaseFailure failure;

  final List<GradeModel> grades;
  final List<ClassNameModel> classNames;
  final List<SectionsList> sectionsNames;
  final List<SubjectsListExam> subjectsName;
  final List<EvaluationTypeModel> evaluationTypes;
  final List<EvaluationModel> evaluations;
  StudentResultState({
    required this.studentAttendanceStatus,
    required this.failure,
    required this.grades,
    required this.classNames,
    required this.sectionsNames,
    required this.subjectsName,
    required this.evaluationTypes,
    required this.evaluations,
  });

  factory StudentResultState.initial() {
    return StudentResultState(
      studentAttendanceStatus: StudentResultStatus.none,
      failure: const BaseFailure(),
      grades: [],
      classNames: [],
      sectionsNames: [],
      subjectsName: [],
      evaluationTypes: [],
      evaluations: [],
    );
  }

  StudentResultState copyWith({
    StudentResultStatus? studentAttendanceStatus,
    BaseFailure? failure,
    List<GradeModel>? grades,
    List<ClassNameModel>? classNames,
    List<SectionsList>? sectionsNames,
    List<SubjectsListExam>? subjectsName,
    List<EvaluationTypeModel>? evaluationTypes,
    List<EvaluationModel>? evaluations,
  }) {
    return StudentResultState(
      studentAttendanceStatus:
          studentAttendanceStatus ?? this.studentAttendanceStatus,
      failure: failure ?? this.failure,
      grades: grades ?? this.grades,
      classNames: classNames ?? this.classNames,
      sectionsNames: sectionsNames ?? this.sectionsNames,
      subjectsName: subjectsName ?? this.subjectsName,
      evaluationTypes: evaluationTypes ?? this.evaluationTypes,
      evaluations: evaluations ?? this.evaluations,
    );
  }
}
