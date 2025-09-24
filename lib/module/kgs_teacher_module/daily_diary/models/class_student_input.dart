class ClassStudentInput {
  int classId;
  int sectionId;

  int ucSchoolId;

  ClassStudentInput({
    required this.classId,
    required this.sectionId,
    required this.ucSchoolId,
  });

  ClassStudentInput copyWith({
    int? classId,
    int? sectionId,
    int? ucSchoolId,
  }) =>
      ClassStudentInput(
        classId: classId ?? this.classId,
        sectionId: sectionId ?? this.sectionId,
        ucSchoolId: ucSchoolId ?? this.ucSchoolId,
      );

  Map<String, dynamic> toJson() => {
        "ClassId": classId,
        "SectionId": sectionId,
        "Option": 3,
        "UC_SchoolId": ucSchoolId,
      };
}
