// To parse this JSON data, do
//
//     final studentsModel = studentsModelFromJson(jsonString);

import 'dart:convert';

StudentsModel studentsModelFromJson(dynamic str) => StudentsModel.fromJson(str);

String studentsModelToJson(StudentsModel data) => json.encode(data.toJson());

class StudentsModel {
    String result;
    String message;
    List<StudentsResponse> data;

    StudentsModel({
        required this.result,
        required this.message,
        required this.data,
    });

    factory StudentsModel.fromJson(Map<String, dynamic> json) => StudentsModel(
        result: json["result"],
        message: json["message"],
        data: List<StudentsResponse>.from(json["data"].map((x) => StudentsResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class StudentsResponse {
    int studentId;
    String rollNumber;
    String studentName;
    String fatherName;

    StudentsResponse({
        required this.studentId,
        required this.rollNumber,
        required this.studentName,
        required this.fatherName,
    });

    factory StudentsResponse.fromJson(Map<String, dynamic> json) => StudentsResponse(
        studentId: json["StudentId"],
        rollNumber: json["RollNumber"],
        studentName: json["StudentName"],
        fatherName: json["FatherName"],
    );

    Map<String, dynamic> toJson() => {
        "StudentId": studentId,
        "RollNumber": rollNumber,
        "StudentName": studentName,
        "FatherName": fatherName,
    };
}
