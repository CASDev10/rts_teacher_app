import 'dart:convert';

ClassNamesResponse classNamesResponseFromJson(dynamic json) =>
    ClassNamesResponse.fromJson(json);

String classNamesResponseToJson(ClassNamesResponse data) =>
    json.encode(data.toJson());

class ClassNamesResponse {
  String result;
  String message;
  List<ClassNameModel> data;

  ClassNamesResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  ClassNamesResponse copyWith({
    String? result,
    String? message,
    List<ClassNameModel>? data,
  }) =>
      ClassNamesResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ClassNamesResponse.fromJson(Map<String, dynamic> json) =>
      ClassNamesResponse(
        result: json["result"],
        message: json["message"],
        data: List<ClassNameModel>.from(
            json["data"].map((x) => ClassNameModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ClassNameModel {
  int classId;
  String className;

  ClassNameModel({
    required this.classId,
    required this.className,
  });

  ClassNameModel copyWith({
    int? classId,
    String? className,
  }) =>
      ClassNameModel(
        classId: classId ?? this.classId,
        className: className ?? this.className,
      );

  factory ClassNameModel.fromJson(Map<String, dynamic> json) => ClassNameModel(
        classId: json["ClassId"] ?? -1,
        className: json["ClassName"] ?? "",
      );

  factory ClassNameModel.empty() => ClassNameModel(
        classId: -1,
        className: "Select a class",
      );

  Map<String, dynamic> toJson() => {
        "ClassId": classId,
        "ClassName": className,
      };
}
