// // To parse this JSON data, do
// //
// //     final parentFilesResponse = parentFilesResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// ParentFilesResponse parentFilesResponseFromJson(dynamic json) =>
//     ParentFilesResponse.fromJson(json);
//
// String parentFilesResponseToJson(ParentFilesResponse data) =>
//     json.encode(data.toJson());
//
// class ParentFilesResponse {
//   String result;
//   String message;
//   List<ParentsFileModel> parentsFileList;
//
//   ParentFilesResponse({
//     required this.result,
//     required this.message,
//     required this.parentsFileList,
//   });
//
//   factory ParentFilesResponse.fromJson(Map<String, dynamic> json) =>
//       ParentFilesResponse(
//         result: json["result"],
//         message: json["message"],
//         parentsFileList: List<ParentsFileModel>.from(
//             json["ParentsFileList"].map((x) => ParentsFileModel.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "result": result,
//         "message": message,
//         "ParentsFileList":
//             List<dynamic>.from(parentsFileList.map((x) => x.toJson())),
//       };
// }
//
// class ParentsFileModel {
//   String studentName;
//   String fileDownloadLink;
//
//   String description;
//
//   ParentsFileModel({
//     required this.studentName,
//     required this.fileDownloadLink,
//     required this.description,
//   });
//
//   factory ParentsFileModel.fromJson(Map<String, dynamic> json) =>
//       ParentsFileModel(
//         studentName: json["StudentName"],
//         description: json["Description"],
//         fileDownloadLink: json["FileDownloadLink"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "StudentName": studentName,
//         "Description": description,
//         "FileDownloadLink": fileDownloadLink,
//       };
// }
//
//

// To parse this JSON data, do
//
//     final parentFilesResponse = parentFilesResponseFromJson(jsonString);

import 'dart:convert';

ParentFilesResponse parentFilesResponseFromJson(dynamic json) =>
    ParentFilesResponse.fromJson(json);

String parentFilesResponseToJson(ParentFilesResponse data) =>
    json.encode(data.toJson());

class ParentFilesResponse {
  List<ParentsFileList> parentsFileList;
  String result;
  String message;

  ParentFilesResponse({
    required this.parentsFileList,
    required this.result,
    required this.message,
  });

  ParentFilesResponse copyWith({
    List<ParentsFileList>? parentsFileList,
    String? result,
    String? message,
  }) =>
      ParentFilesResponse(
        parentsFileList: parentsFileList ?? this.parentsFileList,
        result: result ?? this.result,
        message: message ?? this.message,
      );

  factory ParentFilesResponse.fromJson(Map<String, dynamic> json) =>
      ParentFilesResponse(
        parentsFileList: List<ParentsFileList>.from(
            json["ParentsFileList"].map((x) => ParentsFileList.fromJson(x))),
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

class ParentsFileList {
  String studentName;
  String text;
  String fileDownloadLink;
  String description;
  String className;
  String rollNumber;
  String sectionName;
  int studentId;
  String studentIds;

  ParentsFileList({
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

  ParentsFileList copyWith({
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
      ParentsFileList(
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

  factory ParentsFileList.fromJson(Map<String, dynamic> json) {
    print("Student Name -> " + json["StudentName"]);

    return ParentsFileList(
      studentName: json["StudentName"],
      text: json["Text"] ?? "",
      fileDownloadLink: json["FileDownloadLink"] ?? "",
      description: json["Description"],
      className: json["ClassName"],
      rollNumber: json["RollNumber"],
      sectionName: json["SectionName"],
      studentId: json["StudentId"] ?? -1,
      studentIds: json["StudentIds"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "StudentName": studentName,
        "Text": text,
        "FileDownloadLink": fileDownloadLink,
        "Description": description,
        "ClassName": className,
        "RollNumber": rollNumber,
        "SectionName": sectionName,
        "StudentId": studentId,
        "StudentIds": studentIds,
      };
}
