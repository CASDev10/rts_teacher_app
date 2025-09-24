class ProcessResultInput {
  String examIds;
  String examDate;
  int ucSchoolId;

  ProcessResultInput({
    required this.examIds,
    required this.examDate,
    required this.ucSchoolId,
  });

  ProcessResultInput copyWith({
    String? examIds,
    String? examDate,
    int? ucSchoolId,
  }) =>
      ProcessResultInput(
        examIds: examIds ?? this.examIds,
        examDate: examDate ?? this.examDate,
        ucSchoolId: ucSchoolId ?? this.ucSchoolId,
      );

  Map<String, dynamic> toJson() => {
        "ExamIds": examIds,
        "ExamDate": examDate,
        "Option": 4,
        "UC_SchoolId": ucSchoolId,
      };
}
