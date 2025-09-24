class GetDiaryInput {
  int ucSchoolId;
  int ucLoginUserId;

  String dateFrom;
  String dateTo;
  int classIdFk;
  int sectionIdFk;
  int offSet;
  int next;

  GetDiaryInput({
    required this.ucSchoolId,
    required this.ucLoginUserId,
    required this.dateFrom,
    required this.dateTo,
    required this.classIdFk,
    required this.sectionIdFk,
    required this.offSet,
    required this.next,
  });

  GetDiaryInput copyWith({
    int? ucSchoolId,
    int? ucLoginUserId,
    int? option,
    String? dateFrom,
    String? dateTo,
    int? classIdFk,
    int? sectionIdFk,
    int? offSet,
    int? next,
  }) =>
      GetDiaryInput(
        ucSchoolId: ucSchoolId ?? this.ucSchoolId,
        ucLoginUserId: ucLoginUserId ?? this.ucLoginUserId,
        dateFrom: dateFrom ?? this.dateFrom,
        dateTo: dateTo ?? this.dateTo,
        classIdFk: classIdFk ?? this.classIdFk,
        sectionIdFk: sectionIdFk ?? this.sectionIdFk,
        offSet: offSet ?? this.offSet,
        next: next ?? this.next,
      );

  Map<String, dynamic> toJson() => {
        "UC_SchoolId": ucSchoolId,
        "UC_LoginUserId": ucLoginUserId,
        "Option": 2,
        "DateFrom": dateFrom,
        "DateTo": dateTo,
        "ClassIdFk": classIdFk,
        "SectionIdFk": sectionIdFk,
        "OffSet": offSet,
        "Next": next,
      };
}
