class StudentOutcomesInput {
  int classId;
  int sectionId;
  int evaluationTypeId;
  int evaluationId;
  String examDate;
  int studentId;

  int ucSchoolId;

  StudentOutcomesInput({
    required this.classId,
    required this.sectionId,
    required this.evaluationTypeId,
    required this.evaluationId,
    required this.examDate,
    required this.studentId,
    required this.ucSchoolId,
  });

  StudentOutcomesInput copyWith({
    int? classId,
    int? sectionId,
    int? evaluationTypeId,
    int? evaluationId,
    String? examDate,
    int? studentId,
    int? ucSchoolId,
  }) =>
      StudentOutcomesInput(
        classId: classId ?? this.classId,
        sectionId: sectionId ?? this.sectionId,
        evaluationTypeId: evaluationTypeId ?? this.evaluationTypeId,
        evaluationId: evaluationId ?? this.evaluationId,
        examDate: examDate ?? this.examDate,
        studentId: studentId ?? this.studentId,
        ucSchoolId: ucSchoolId ?? this.ucSchoolId,
      );

  Map<String, dynamic> toJson() => {
        "ClassId": classId,
        "SectionId": sectionId,
        "EvaluationTypeId": evaluationTypeId,
        "EvaluationId": evaluationId,
        "ExamDate": examDate,
        "StudentId": studentId,
        "Option": 2,
        "UC_SchoolId": ucSchoolId,
      };
}
