import 'dart:convert';

DiaryStudentListResponse diaryStudentListResponseFromJson(dynamic json) =>
    DiaryStudentListResponse.fromJson(json);

String diaryStudentListResponseToJson(DiaryStudentListResponse data) =>
    json.encode(data.toJson());

class DiaryStudentListResponse {
  String result;
  String message;
  List<DiaryStudentModel> data;

  DiaryStudentListResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  DiaryStudentListResponse copyWith({
    String? result,
    String? message,
    List<DiaryStudentModel>? data,
  }) =>
      DiaryStudentListResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory DiaryStudentListResponse.fromJson(Map<String, dynamic> json) =>
      DiaryStudentListResponse(
        result: json["result"],
        message: json["message"],
        data: List<DiaryStudentModel>.from(
            json["data"].map((x) => DiaryStudentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DiaryStudentModel {
  int studentId;
  String studentName;
  String rollNumber;
  String className;
  String sectionName;
  int examId;
  bool isProcessed;

  DiaryStudentModel({
    required this.studentId,
    required this.studentName,
    required this.rollNumber,
    required this.className,
    required this.sectionName,
    required this.examId,
    required this.isProcessed,
  });

  DiaryStudentModel copyWith({
    int? studentId,
    String? studentName,
    String? rollNumber,
    String? className,
    String? sectionName,
    int? examId,
    bool? isProcessed,
  }) =>
      DiaryStudentModel(
        studentId: studentId ?? this.studentId,
        studentName: studentName ?? this.studentName,
        rollNumber: rollNumber ?? this.rollNumber,
        className: className ?? this.className,
        sectionName: sectionName ?? this.sectionName,
        examId: examId ?? this.examId,
        isProcessed: isProcessed ?? this.isProcessed,
      );

  factory DiaryStudentModel.fromJson(Map<String, dynamic> json) =>
      DiaryStudentModel(
        studentId: json["StudentId"],
        studentName: json["StudentName"],
        rollNumber: json["RollNumber"],
        className: json["ClassName"],
        sectionName: json["SectionName"],
        examId: json["ExamId"],
        isProcessed: json["IsProcessed"],
      );

  Map<String, dynamic> toJson() => {
        "StudentId": studentId,
        "StudentName": studentName,
        "RollNumber": rollNumber,
        "ClassName": className,
        "SectionName": sectionName,
        "ExamId": examId,
        "IsProcessed": isProcessed,
      };
}
