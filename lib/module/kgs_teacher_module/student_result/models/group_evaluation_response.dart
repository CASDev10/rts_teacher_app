// To parse this JSON data, do
//
//     final groupEvaluationResponse = groupEvaluationResponseFromJson(jsonString);

import 'dart:convert';

GroupEvaluationResponse groupEvaluationResponseFromJson(dynamic json) =>
    GroupEvaluationResponse.fromJson(json);

String groupEvaluationResponseToJson(GroupEvaluationResponse data) =>
    json.encode(data.toJson());

class GroupEvaluationResponse {
  String result;
  String message;
  List<EvaluationGroupModel> data;

  GroupEvaluationResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  factory GroupEvaluationResponse.fromJson(Map<String, dynamic> json) =>
      GroupEvaluationResponse(
        result: json["result"],
        message: json["message"],
        data: List<EvaluationGroupModel>.from(
          json["data"].map((x) => EvaluationGroupModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class EvaluationGroupModel {
  int evaluationGroupId;
  String name;
  DateTime fromDate;
  DateTime toDate;
  bool isActive;
  DateTime creationDate;
  int createdBy;
  DateTime lastDate;

  EvaluationGroupModel({
    required this.evaluationGroupId,
    required this.name,
    required this.fromDate,
    required this.toDate,
    required this.isActive,
    required this.creationDate,
    required this.createdBy,
    required this.lastDate,
  });

  factory EvaluationGroupModel.fromJson(Map<String, dynamic> json) =>
      EvaluationGroupModel(
        evaluationGroupId: json["EvaluationGroupId"],
        name: json["Name"],
        fromDate: DateTime.parse(json["FromDate"]),
        toDate: DateTime.parse(json["ToDate"]),
        isActive: json["IsActive"],
        creationDate: DateTime.parse(json["CreationDate"]),
        createdBy: json["CreatedBy"],
        lastDate: DateTime.parse(json["LastDate"]),
      );

  Map<String, dynamic> toJson() => {
    "EvaluationGroupId": evaluationGroupId,
    "Name": name,
    "FromDate": fromDate.toIso8601String(),
    "ToDate": toDate.toIso8601String(),
    "IsActive": isActive,
    "CreationDate": creationDate.toIso8601String(),
    "CreatedBy": createdBy,
    "LastDate": lastDate.toIso8601String(),
  };
}
