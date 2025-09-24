class StudentEvaluationListInput {
  int classId;
  int sectionId;
  int evaluationTypeId;
  int evaluationId;
  String examDate;
  int ucSchoolId;

  StudentEvaluationListInput({
    required this.classId,
    required this.sectionId,
    required this.evaluationTypeId,
    required this.evaluationId,
    required this.examDate,
    required this.ucSchoolId,
  });

  StudentEvaluationListInput copyWith({
    int? classId,
    int? sectionId,
    int? evaluationTypeId,
    int? evaluationId,
    String? examDate,
    int? ucSchoolId,
  }) =>
      StudentEvaluationListInput(
        classId: classId ?? this.classId,
        sectionId: sectionId ?? this.sectionId,
        evaluationTypeId: evaluationTypeId ?? this.evaluationTypeId,
        evaluationId: evaluationId ?? this.evaluationId,
        examDate: examDate ?? this.examDate,
        ucSchoolId: ucSchoolId ?? this.ucSchoolId,
      );

  Map<String, dynamic> toJson() => {
        "ClassId": classId,
        "SectionId": sectionId,
        "EvaluationTypeId": evaluationTypeId,
        "EvaluationId": evaluationId,
        "ExamDate": examDate,
        "Option": 3,
        "UC_SchoolId": ucSchoolId,
      };
}
