// To parse this JSON data, do
//
//     final evaluationResponse = evaluationResponseFromJson(jsonString);

import 'dart:convert';

EvaluationResponse evaluationResponseFromJson(dynamic json) =>
    EvaluationResponse.fromJson(json);

String evaluationResponseToJson(EvaluationResponse data) =>
    json.encode(data.toJson());

class EvaluationResponse {
  String result;
  String message;
  List<EvaluationModel> data;

  EvaluationResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  EvaluationResponse copyWith({
    String? result,
    String? message,
    List<EvaluationModel>? data,
  }) =>
      EvaluationResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory EvaluationResponse.fromJson(Map<String, dynamic> json) =>
      EvaluationResponse(
        result: json["result"],
        message: json["message"],
        data: List<EvaluationModel>.from(
            json["data"].map((x) => EvaluationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EvaluationModel {
  int evaluationId;
  String name;
  int evaluationTypeId;
  String evaluationType;
  int orderNumber;
  dynamic lastDate;

  EvaluationModel({
    required this.evaluationId,
    required this.name,
    required this.evaluationTypeId,
    required this.evaluationType,
    required this.orderNumber,
    required this.lastDate,
  });

  EvaluationModel copyWith({
    int? evaluationId,
    String? name,
    int? evaluationTypeId,
    String? evaluationType,
    int? orderNumber,
    dynamic lastDate,
  }) =>
      EvaluationModel(
        evaluationId: evaluationId ?? this.evaluationId,
        name: name ?? this.name,
        evaluationTypeId: evaluationTypeId ?? this.evaluationTypeId,
        evaluationType: evaluationType ?? this.evaluationType,
        orderNumber: orderNumber ?? this.orderNumber,
        lastDate: lastDate ?? this.lastDate,
      );

  factory EvaluationModel.fromJson(Map<String, dynamic> json) =>
      EvaluationModel(
        evaluationId: json["EvaluationId"],
        name: json["Name"],
        evaluationTypeId: json["EvaluationTypeId"],
        evaluationType: json["EvaluationType"],
        orderNumber: json["OrderNumber"],
        lastDate: json["LastDate"],
      );

  Map<String, dynamic> toJson() => {
        "EvaluationId": evaluationId,
        "Name": name,
        "EvaluationTypeId": evaluationTypeId,
        "EvaluationType": evaluationType,
        "OrderNumber": orderNumber,
        "LastDate": lastDate,
      };
}
