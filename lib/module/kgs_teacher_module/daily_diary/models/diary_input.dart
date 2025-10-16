import 'dart:convert';

String diaryInputToJson(DiaryInput data) => json.encode(data.toJson());

class DiaryInput {
  String dateFrom;
  String dateTo;
  int sectionIdFk;
  int classIdFk;
  int subjectIdFk;
  String text;
  int ucSchoolId;
  int ucLoginUserId;

  DiaryInput({
    required this.dateFrom,
    required this.dateTo,
    required this.sectionIdFk,
    required this.classIdFk,
    required this.subjectIdFk,
    required this.text,
    required this.ucSchoolId,
    required this.ucLoginUserId,
  });

  DiaryInput copyWith({
    String? dateFrom,
    String? dateTo,
    int? sectionIdFk,
    int? classIdFk,
    int? subjectIdFk,
    String? text,
    int? ucSchoolId,
    int? ucLoginUserId,
  }) => DiaryInput(
    dateFrom: dateFrom ?? this.dateFrom,
    dateTo: dateTo ?? this.dateTo,
    sectionIdFk: sectionIdFk ?? this.sectionIdFk,
    classIdFk: classIdFk ?? this.classIdFk,
    subjectIdFk: subjectIdFk ?? this.subjectIdFk,
    text: text ?? this.text,
    ucSchoolId: ucSchoolId ?? this.ucSchoolId,
    ucLoginUserId: ucLoginUserId ?? this.ucLoginUserId,
  );

  Map<String, dynamic> toJson() => {
    "DateFrom": dateFrom,
    "DateTo": dateTo,
    "SectionIdFk": sectionIdFk,
    "ClassIdFk": classIdFk,
    "SubjectIdFk": subjectIdFk,
    "Text": text,
    "UC_SchoolId": ucSchoolId,
    "UC_LoginUserId": ucLoginUserId,
  };
}
