import 'dart:convert';

import 'package:dio/dio.dart';

String diaryDescriptionInputToJson(DiaryDescriptionInput data) =>
    json.encode(data.toJson());

class DiaryDescriptionInput {
  String dateFrom;
  String dateTo;
  int classIdFk;
  int subjectIdFk;
  String text;
  String ucSchoolId;
  String studentIDs;
  int sectionIdFk;
  String description;
  int schoold;
  int createdBy;
  MultipartFile? file;

  DiaryDescriptionInput(
      {required this.dateFrom,
      required this.dateTo,
      required this.classIdFk,
      required this.subjectIdFk,
      required this.text,
      required this.ucSchoolId,
      required this.studentIDs,
      required this.sectionIdFk,
      required this.description,
      required this.schoold,
      required this.createdBy,
      this.file});

  DiaryDescriptionInput copyWith(
          {String? dateFrom,
          String? dateTo,
          int? classIdFk,
          int? subjectIdFk,
          String? text,
          String? ucSchoolId,
          String? studentIDs,
          int? sectionIdFk,
          String? description,
          int? schoold,
          int? createdBy,
          MultipartFile? file}) =>
      DiaryDescriptionInput(
          dateFrom: dateFrom ?? this.dateFrom,
          dateTo: dateTo ?? this.dateTo,
          classIdFk: classIdFk ?? this.classIdFk,
          subjectIdFk: subjectIdFk ?? this.subjectIdFk,
          text: text ?? this.text,
          ucSchoolId: ucSchoolId ?? this.ucSchoolId,
          studentIDs: studentIDs ?? this.studentIDs,
          sectionIdFk: sectionIdFk ?? this.sectionIdFk,
          description: description ?? this.description,
          schoold: schoold ?? this.schoold,
          createdBy: createdBy ?? this.createdBy,
          file: file ?? this.file);

  Map<String, dynamic> toJson() => {
        "DateFrom": dateFrom,
        "DateTo": dateTo,
        "ClassIdFk": classIdFk,
        "SubjectIdFk": subjectIdFk,
        "Text": text,
        "UC_SchoolId": ucSchoolId,
        "StudentIDs": studentIDs,
        "SectionIdFk": sectionIdFk,
        "Description": description,
        "Schoold": schoold,
        "CreatedBy": createdBy,
      };
}
