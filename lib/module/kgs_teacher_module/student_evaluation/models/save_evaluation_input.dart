class SaveEvaluationInput {
  int examId;
  int classId;
  int sectionId;
  int evaluationTypeId;
  int evaluationId;
  String examDate;
  int studentId;
  String teachersGeneralComments;
  List<KinderGartenTermOneResultDetail> kinderGartenTermOneResultDetail;
  int ucSchoolId;

  SaveEvaluationInput({
    required this.examId,
    required this.classId,
    required this.sectionId,
    required this.evaluationTypeId,
    required this.evaluationId,
    required this.examDate,
    required this.studentId,
    required this.teachersGeneralComments,
    required this.kinderGartenTermOneResultDetail,
    required this.ucSchoolId,
  });

  SaveEvaluationInput copyWith({
    int? examId,
    int? classId,
    int? sectionId,
    int? evaluationTypeId,
    int? evaluationId,
    String? examDate,
    int? studentId,
    String? teachersGeneralComments,
    List<KinderGartenTermOneResultDetail>? kinderGartenTermOneResultDetail,
    int? ucSchoolId,
  }) =>
      SaveEvaluationInput(
        examId: examId ?? this.examId,
        classId: classId ?? this.classId,
        sectionId: sectionId ?? this.sectionId,
        evaluationTypeId: evaluationTypeId ?? this.evaluationTypeId,
        evaluationId: evaluationId ?? this.evaluationId,
        examDate: examDate ?? this.examDate,
        studentId: studentId ?? this.studentId,
        teachersGeneralComments:
            teachersGeneralComments ?? this.teachersGeneralComments,
        kinderGartenTermOneResultDetail: kinderGartenTermOneResultDetail ??
            this.kinderGartenTermOneResultDetail,
        ucSchoolId: ucSchoolId ?? this.ucSchoolId,
      );

  factory SaveEvaluationInput.fromJson(Map<String, dynamic> json) =>
      SaveEvaluationInput(
        examId: json["ExamId"],
        classId: json["ClassId"],
        sectionId: json["SectionId"],
        evaluationTypeId: json["EvaluationTypeId"],
        evaluationId: json["EvaluationId"],
        examDate: json["ExamDate"],
        studentId: json["StudentId"],
        teachersGeneralComments: json["TeachersGeneralComments"],
        kinderGartenTermOneResultDetail:
            List<KinderGartenTermOneResultDetail>.from(
                json["KinderGartenTermOneResultDetail"]
                    .map((x) => KinderGartenTermOneResultDetail.fromJson(x))),
        ucSchoolId: json["UC_SchoolId"],
      );

  Map<String, dynamic> toJson() => {
        "ExamId": examId,
        "ClassId": classId,
        "SectionId": sectionId,
        "EvaluationTypeId": evaluationTypeId,
        "EvaluationId": evaluationId,
        "ExamDate": examDate,
        "StudentId": studentId,
        "TeachersGeneralComments": teachersGeneralComments,
        "KinderGartenTermOneResultDetail": List<dynamic>.from(
            kinderGartenTermOneResultDetail.map((x) => x.toJson())),
        "Option": 1,
        "UC_SchoolId": ucSchoolId,
      };
}

class KinderGartenTermOneResultDetail {
  int gradeId;
  int subGradeId;
  bool isWorkingTowards;
  bool isWorkingWithin;
  bool isWorkingBeyond;

  KinderGartenTermOneResultDetail({
    required this.gradeId,
    required this.subGradeId,
    required this.isWorkingTowards,
    required this.isWorkingWithin,
    required this.isWorkingBeyond,
  });

  KinderGartenTermOneResultDetail copyWith({
    int? gradeId,
    int? subGradeId,
    bool? isWorkingTowards,
    bool? isWorkingWithin,
    bool? isWorkingBeyond,
  }) =>
      KinderGartenTermOneResultDetail(
        gradeId: gradeId ?? this.gradeId,
        subGradeId: subGradeId ?? this.subGradeId,
        isWorkingTowards: isWorkingTowards ?? this.isWorkingTowards,
        isWorkingWithin: isWorkingWithin ?? this.isWorkingWithin,
        isWorkingBeyond: isWorkingBeyond ?? this.isWorkingBeyond,
      );

  factory KinderGartenTermOneResultDetail.fromJson(Map<String, dynamic> json) =>
      KinderGartenTermOneResultDetail(
        gradeId: json["GradeId"],
        subGradeId: json["SubGradeId"],
        isWorkingTowards: json["IsWorkingTowards"],
        isWorkingWithin: json["IsWorkingWithin"],
        isWorkingBeyond: json["IsWorkingBeyond"],
      );

  Map<String, dynamic> toJson() => {
        "GradeId": gradeId,
        "SubGradeId": subGradeId,
        "IsWorkingTowards": isWorkingTowards,
        "IsWorkingWithin": isWorkingWithin,
        "IsWorkingBeyond": isWorkingBeyond,
      };
}
