import 'dart:convert';

StudentEvaluationListResponse studentEvaluationListResponseFromJson(
        dynamic json) =>
    StudentEvaluationListResponse.fromJson(json);

String studentEvaluationListResponseToJson(
        StudentEvaluationListResponse data) =>
    json.encode(data.toJson());

class StudentEvaluationListResponse {
  String result;
  String message;
  List<StudentEvaluationDataModel> data;

  StudentEvaluationListResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  StudentEvaluationListResponse copyWith({
    String? result,
    String? message,
    List<StudentEvaluationDataModel>? data,
  }) =>
      StudentEvaluationListResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory StudentEvaluationListResponse.fromJson(Map<String, dynamic> json) =>
      StudentEvaluationListResponse(
        result: json["result"],
        message: json["message"],
        data: List<StudentEvaluationDataModel>.from(
            json["data"].map((x) => StudentEvaluationDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StudentEvaluationDataModel {
  int studentId;
  String studentName;
  String rollNumber;
  String className;
  String sectionName;
  int examId;
  bool isProcessed;

  StudentEvaluationDataModel({
    required this.studentId,
    required this.studentName,
    required this.rollNumber,
    required this.className,
    required this.sectionName,
    required this.examId,
    required this.isProcessed,
  });

  StudentEvaluationDataModel copyWith({
    int? studentId,
    String? studentName,
    String? rollNumber,
    String? className,
    String? sectionName,
    int? examId,
    bool? isProcessed,
  }) =>
      StudentEvaluationDataModel(
        studentId: studentId ?? this.studentId,
        studentName: studentName ?? this.studentName,
        rollNumber: rollNumber ?? this.rollNumber,
        className: className ?? this.className,
        sectionName: sectionName ?? this.sectionName,
        examId: examId ?? this.examId,
        isProcessed: isProcessed ?? this.isProcessed,
      );

  factory StudentEvaluationDataModel.fromJson(Map<String, dynamic> json) =>
      StudentEvaluationDataModel(
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
