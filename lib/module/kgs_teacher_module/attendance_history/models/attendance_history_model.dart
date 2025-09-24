import 'dart:convert';

AttendanceHistoryResponse attendanceHistoryResponseFromJson(dynamic json) =>
    AttendanceHistoryResponse.fromJson(json);

String attendanceHistoryResponseToJson(AttendanceHistoryResponse data) =>
    json.encode(data.toJson());

class AttendanceHistoryResponse {
  String result;
  String message;
  List<AttendanceHistoryModel> data;

  AttendanceHistoryResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  AttendanceHistoryResponse copyWith({
    String? result,
    String? message,
    List<AttendanceHistoryModel>? data,
  }) =>
      AttendanceHistoryResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory AttendanceHistoryResponse.fromJson(Map<String, dynamic> json) =>
      AttendanceHistoryResponse(
        result: json["result"],
        message: json["message"],
        data: List<AttendanceHistoryModel>.from(
            json["data"].map((x) => AttendanceHistoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AttendanceHistoryModel {
  String attendanceDate;
  String inTime;
  String outTime;
  int duration;
  String status;
  int presents;
  int absents;
  int leaves;

  AttendanceHistoryModel({
    required this.attendanceDate,
    required this.inTime,
    required this.outTime,
    required this.duration,
    required this.status,
    required this.presents,
    required this.absents,
    required this.leaves,
  });

  AttendanceHistoryModel copyWith({
    String? attendanceDate,
    String? inTime,
    String? outTime,
    int? duration,
    String? status,
    int? presents,
    int? absents,
    int? leaves,
  }) =>
      AttendanceHistoryModel(
        attendanceDate: attendanceDate ?? this.attendanceDate,
        inTime: inTime ?? this.inTime,
        outTime: outTime ?? this.outTime,
        duration: duration ?? this.duration,
        status: status ?? this.status,
        presents: presents ?? this.presents,
        absents: absents ?? this.absents,
        leaves: leaves ?? this.leaves,
      );

  factory AttendanceHistoryModel.fromJson(Map<String, dynamic> json) =>
      AttendanceHistoryModel(
        attendanceDate: json["AttendanceDate"],
        inTime: json["INTIME"],
        outTime: json["OUTTIME"],
        duration: json["Duration"],
        status: json["Status"]!,
        presents: json["Presents"],
        absents: json["Absents"],
        leaves: json["Leaves"],
      );

  Map<String, dynamic> toJson() => {
        "AttendanceDate": attendanceDate,
        "INTIME": inTime,
        "OUTTIME": outTime,
        "Duration": duration,
        "Status": status,
        "Presents": presents,
        "Absents": absents,
        "Leaves": leaves,
      };
}
