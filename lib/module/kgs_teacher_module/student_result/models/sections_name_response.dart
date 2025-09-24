// To parse this JSON data, do
//
//     final sectionsListResponse = sectionsListResponseFromJson(jsonString);

import 'dart:convert';

SectionsListResponse sectionsListResponseFromJson(dynamic json) =>
    SectionsListResponse.fromJson(json);

String sectionsListResponseToJson(SectionsListResponse data) =>
    json.encode(data.toJson());

class SectionsListResponse {
  String result;
  String message;
  Data data;

  SectionsListResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  SectionsListResponse copyWith({
    String? result,
    String? message,
    Data? data,
  }) =>
      SectionsListResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SectionsListResponse.fromJson(Map<String, dynamic> json) =>
      SectionsListResponse(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  List<SectionsList> sectionsList;

  Data({
    required this.sectionsList,
  });

  Data copyWith({
    List<SectionsList>? sectionsList,
  }) =>
      Data(
        sectionsList: sectionsList ?? this.sectionsList,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sectionsList: List<SectionsList>.from(
            json["SectionsList"].map((x) => SectionsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "SectionsList": List<dynamic>.from(sectionsList.map((x) => x.toJson())),
      };
}

class SectionsList {
  int sectionId;
  int sessionId;
  String sessionName;
  String sectionName;
  String sectionCode;
  int sessionIdFk;

  SectionsList({
    required this.sectionId,
    required this.sessionId,
    required this.sessionName,
    required this.sectionName,
    required this.sectionCode,
    required this.sessionIdFk,
  });

  SectionsList copyWith({
    int? sectionId,
    int? sessionId,
    String? sessionName,
    String? sectionName,
    String? sectionCode,
    int? sessionIdFk,
  }) =>
      SectionsList(
        sectionId: sectionId ?? this.sectionId,
        sessionId: sessionId ?? this.sessionId,
        sessionName: sessionName ?? this.sessionName,
        sectionName: sectionName ?? this.sectionName,
        sectionCode: sectionCode ?? this.sectionCode,
        sessionIdFk: sessionIdFk ?? this.sessionIdFk,
      );

  factory SectionsList.fromJson(Map<String, dynamic> json) => SectionsList(
        sectionId: json["SectionId"],
        sessionId: json["SessionId"],
        sessionName: json["SessionName"],
        sectionName: json["SectionName"],
        sectionCode: json["SectionCode"],
        sessionIdFk: json["SessionIdFk"],
      );

  Map<String, dynamic> toJson() => {
        "SectionId": sectionId,
        "SessionId": sessionId,
        "SessionName": sessionName,
        "SectionName": sectionName,
        "SectionCode": sectionCode,
        "SessionIdFk": sessionIdFk,
      };
}
