import 'dart:convert';

String diaryInputToJson(DiaryInput data) => json.encode(data.toJson());

class DiaryInput {
  String dateFrom;
  String dateTo;
  int sectionIdFk;
  int classIdFk;
  int subjectIdFk;
  String studentIds; // 👈 NEW FIELD
  String text;
  int ucSchoolId;
  int ucLoginUserId;

  DiaryInput({
    required this.dateFrom,
    required this.dateTo,
    required this.sectionIdFk,
    required this.classIdFk,
    required this.subjectIdFk,
    required this.studentIds, // 👈 added
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
    String? studentIds, // 👈 added
    String? text,
    int? ucSchoolId,
    int? ucLoginUserId,
  }) => DiaryInput(
    dateFrom: dateFrom ?? this.dateFrom,
    dateTo: dateTo ?? this.dateTo,
    sectionIdFk: sectionIdFk ?? this.sectionIdFk,
    classIdFk: classIdFk ?? this.classIdFk,
    subjectIdFk: subjectIdFk ?? this.subjectIdFk,
    studentIds: studentIds ?? this.studentIds,
    text: text ?? this.text,
    ucSchoolId: ucSchoolId ?? this.ucSchoolId,
    ucLoginUserId: ucLoginUserId ?? this.ucLoginUserId,
  );

  Map<String, dynamic> toJson() => {
    "DateFrom": dateFrom,
    "DateTo": dateTo,
    "SectionIdFk": sectionIdFk,
    "ClassIdFk": classIdFk,
    "SubjectidFk": subjectIdFk, // 👈 matches your endpoint exactly
    "StudentIds": studentIds, // 👈 new field
    "Text": text,
    "UC_Schoolid": ucSchoolId, // 👈 lowercase "id" as per your sample JSON
    "UC_LoginUserId": ucLoginUserId,
  };
}
