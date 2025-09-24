// To parse this JSON data, do
//
//     final parentFilesResponse = parentFilesResponseFromJson(jsonString);

import 'dart:convert';

ParentFilesResponse parentFilesResponseFromJson(dynamic json) =>
    ParentFilesResponse.fromJson(json);

String parentFilesResponseToJson(ParentFilesResponse data) =>
    json.encode(data.toJson());

class ParentFilesResponse {
  String result;
  String message;
  List<ParentsFileModel> parentsFileList;

  ParentFilesResponse({
    required this.result,
    required this.message,
    required this.parentsFileList,
  });

  factory ParentFilesResponse.fromJson(Map<String, dynamic> json) =>
      ParentFilesResponse(
        result: json["result"],
        message: json["message"],
        parentsFileList: List<ParentsFileModel>.from(
            json["ParentsFileList"].map((x) => ParentsFileModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "ParentsFileList":
            List<dynamic>.from(parentsFileList.map((x) => x.toJson())),
      };
}

class ParentsFileModel {
  String studentName;
  String text;
  String fileDownloadLink;

  ParentsFileModel({
    required this.studentName,
    required this.text,
    required this.fileDownloadLink,
  });

  factory ParentsFileModel.fromJson(Map<String, dynamic> json) =>
      ParentsFileModel(
        studentName: json["StudentName"],
        text: json["Text"],
        fileDownloadLink: json["FileDownloadLink"],
      );

  Map<String, dynamic> toJson() => {
        "StudentName": studentName,
        "Text": text,
        "FileDownloadLink": fileDownloadLink,
      };
}
