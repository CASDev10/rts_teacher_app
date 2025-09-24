// To parse this JSON data, do
//
//     final gradesResponse = gradesResponseFromJson(jsonString);

import 'dart:convert';

GradesResponse gradesResponseFromJson(dynamic json) =>
    GradesResponse.fromJson(json);

String gradesResponseToJson(GradesResponse data) => json.encode(data.toJson());

class GradesResponse {
  String result;
  String message;
  List<GradeModel> data;

  GradesResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  GradesResponse copyWith({
    String? result,
    String? message,
    List<GradeModel>? data,
  }) =>
      GradesResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GradesResponse.fromJson(Map<String, dynamic> json) => GradesResponse(
        result: json["result"],
        message: json["message"],
        data: List<GradeModel>.from(
            json["data"].map((x) => GradeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GradeModel {
  int gradeId;
  String gradeName;

  GradeModel({
    required this.gradeId,
    required this.gradeName,
  });

  GradeModel copyWith({
    int? gradeId,
    String? gradeName,
  }) =>
      GradeModel(
        gradeId: gradeId ?? this.gradeId,
        gradeName: gradeName ?? this.gradeName,
      );

  factory GradeModel.fromJson(Map<String, dynamic> json) => GradeModel(
        gradeId: json["GradeId"],
        gradeName: json["GradeName"],
      );

  factory GradeModel.empty() => GradeModel(
        gradeId: -1,
        gradeName: "Select a grade",
      );

  Map<String, dynamic> toJson() => {
        "GradeId": gradeId,
        "GradeName": gradeName,
      };
}
