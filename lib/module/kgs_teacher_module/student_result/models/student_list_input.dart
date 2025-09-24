import '../../../../core/di/service_locator.dart';
import '../../kgs_teacher_auth/repo/auth_repository.dart';

class StudentListInput {
  String examDate;

  int classIdFk;
  int sectionIdFk;
  int subjectIdFk;
  int evaluationIdFk;
  int evaluationGroupId;
  double? totalMarks;
  String? submissionDate;

  final AuthRepository _repository = sl<AuthRepository>();

  StudentListInput({
    required this.examDate,
    required this.classIdFk,
    required this.sectionIdFk,
    required this.subjectIdFk,
    required this.evaluationIdFk,
    required this.evaluationGroupId,
    this.submissionDate,
    this.totalMarks,
  });

  StudentListInput copyWith({
    String? examDate,
    int? classIdFk,
    int? sectionIdFk,
    int? subjectIdFk,
    int? evaluationIdFk,
    int? evaluationGroupId,
    double? totalMarks,
    String? submissionDate,
  }) => StudentListInput(
    examDate: examDate ?? this.examDate,
    classIdFk: classIdFk ?? this.classIdFk,
    sectionIdFk: sectionIdFk ?? this.sectionIdFk,
    subjectIdFk: subjectIdFk ?? this.subjectIdFk,
    evaluationIdFk: evaluationIdFk ?? this.evaluationIdFk,
    evaluationGroupId: evaluationGroupId ?? this.evaluationGroupId,
    totalMarks: totalMarks ?? this.totalMarks,
    submissionDate: submissionDate ?? this.submissionDate,
  );

  StudentListInput empty() => StudentListInput(
    examDate: "",
    classIdFk: -1,
    sectionIdFk: -1,
    subjectIdFk: -1,
    evaluationIdFk: -1,
    evaluationGroupId: -1,
    totalMarks: -1,
    submissionDate: "",
  );

  Map<String, dynamic> toJson() => {
    "ExamDate": examDate,
    "SchoolIdFk": _repository.user.schoolId,
    "ClassIdFk": classIdFk,
    "SectionIdFk": sectionIdFk,
    "SubjectIdFK": subjectIdFk,
    "EvaluationIdFk": evaluationIdFk,
    "EvaluationGroupId": evaluationGroupId,
    "UC_EntityId": _repository.user.entityId,
  };
  Map<String, dynamic> toResultSubmission() => {
    "ExamDate": examDate,
    "SchoolIdFk": _repository.user.schoolId,
    "ClassIdFk": classIdFk,
    "SectionIdFk": sectionIdFk,
    "SubjectIdFk": subjectIdFk,
    "EvaluationIdFk": evaluationIdFk,
    "EvaluationGroupId": evaluationGroupId,
    "UC_EntityId": _repository.user.entityId,
    "TotalMarks": totalMarks?.toInt(),
    "SubmissionDate": submissionDate,
  };
}
