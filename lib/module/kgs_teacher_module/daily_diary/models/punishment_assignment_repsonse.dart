import 'dart:convert';

PunishmentAssignmentResponse punishmentAssignmentResponseFromJson(
        dynamic json) =>
    PunishmentAssignmentResponse.fromJson(json);

String punishmentAssignmentResponseToJson(PunishmentAssignmentResponse data) =>
    json.encode(data.toJson());

class PunishmentAssignmentResponse {
  List<AssignmentModel> parentsFileList;
  String result;
  String message;

  PunishmentAssignmentResponse({
    required this.parentsFileList,
    required this.result,
    required this.message,
  });

  PunishmentAssignmentResponse copyWith({
    List<AssignmentModel>? parentsFileList,
    String? result,
    String? message,
  }) =>
      PunishmentAssignmentResponse(
        parentsFileList: parentsFileList ?? this.parentsFileList,
        result: result ?? this.result,
        message: message ?? this.message,
      );

  factory PunishmentAssignmentResponse.fromJson(Map<String, dynamic> json) =>
      PunishmentAssignmentResponse(
        parentsFileList: List<AssignmentModel>.from(
            json["ParentsFileList"].map((x) => AssignmentModel.fromJson(x))),
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "ParentsFileList":
            List<dynamic>.from(parentsFileList.map((x) => x.toJson())),
        "result": result,
        "message": message,
      };
}

class AssignmentModel {
  String studentName;
  String text;
  String fileDownloadLink;
  String description;
  String className;
  String rollNumber;
  String sectionName;
  int studentId;
  String studentIds;

  AssignmentModel({
    required this.studentName,
    required this.text,
    required this.fileDownloadLink,
    required this.description,
    required this.className,
    required this.rollNumber,
    required this.sectionName,
    required this.studentId,
    required this.studentIds,
  });

  AssignmentModel copyWith({
    String? studentName,
    String? text,
    String? fileDownloadLink,
    String? description,
    String? className,
    String? rollNumber,
    String? sectionName,
    int? studentId,
    String? studentIds,
  }) =>
      AssignmentModel(
        studentName: studentName ?? this.studentName,
        text: text ?? this.text,
        fileDownloadLink: fileDownloadLink ?? this.fileDownloadLink,
        description: description ?? this.description,
        className: className ?? this.className,
        rollNumber: rollNumber ?? this.rollNumber,
        sectionName: sectionName ?? this.sectionName,
        studentId: studentId ?? this.studentId,
        studentIds: studentIds ?? this.studentIds,
      );

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      AssignmentModel(
        studentName: json["StudentName"] ?? "",
        text: json["Text"] ?? "",
        fileDownloadLink: json["FileDownloadLink"] ?? "",
        description: json["Description"],
        className: json["ClassName"],
        rollNumber: json["RollNumber"] ?? "",
        sectionName: json["SectionName"],
        studentId: json["StudentId"] ?? -1,
        studentIds: json["StudentIds"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "StudentName": studentName,
        "Text": text,
        "FileDownloadLink": fileDownloadLink,
        "Description": description,
      };
}
