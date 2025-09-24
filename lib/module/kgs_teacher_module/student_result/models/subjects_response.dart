import 'dart:convert';

SubjectsResponse subjectsResponseFromJson(dynamic json) =>
    SubjectsResponse.fromJson(json);

String subjectsResponseToJson(SubjectsResponse data) =>
    json.encode(data.toJson());

class SubjectsResponse {
  String result;
  String message;
  List<SubjectsListExam> data;

  SubjectsResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  SubjectsResponse copyWith({
    String? result,
    String? message,
    List<SubjectsListExam>? data,
  }) =>
      SubjectsResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) =>
      SubjectsResponse(
        result: json["result"],
        message: json["message"],
        data: List<SubjectsListExam>.from(
            json["data"].map((x) => SubjectsListExam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SubjectsListExam {
  int subjectId;
  String subjectName;

  SubjectsListExam({
    required this.subjectId,
    required this.subjectName,
  });

  SubjectsListExam copyWith({
    int? subjectId,
    String? subjectName,
  }) =>
      SubjectsListExam(
        subjectId: subjectId ?? this.subjectId,
        subjectName: subjectName ?? this.subjectName,
      );

  factory SubjectsListExam.fromJson(Map<String, dynamic> json) =>
      SubjectsListExam(
        subjectId: json["SubjectId"],
        subjectName: json["SubjectName"],
      );

  Map<String, dynamic> toJson() => {
        "SubjectId": subjectId,
        "SubjectName": subjectName,
      };
}
