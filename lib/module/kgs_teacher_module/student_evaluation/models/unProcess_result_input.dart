class UnProcessResultInput {
  int examId;

  UnProcessResultInput({
    required this.examId,
  });

  UnProcessResultInput copyWith({
    int? examId,
  }) =>
      UnProcessResultInput(
        examId: examId ?? this.examId,
      );

  Map<String, dynamic> toJson() => {
        "ExamId": examId,
        "Option": 5,
      };
}
