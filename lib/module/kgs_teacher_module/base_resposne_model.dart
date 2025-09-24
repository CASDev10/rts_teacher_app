// To parse this JSON data, do
//
//     final baseResponseModel = baseResponseModelFromJson(jsonString);

import 'dart:convert';

BaseResponseModel baseResponseModelFromJson(dynamic json) =>
    BaseResponseModel.fromJson(json);

String baseResponseModelToJson(BaseResponseModel data) =>
    json.encode(data.toJson());

class BaseResponseModel {
  String result;
  String message;

  BaseResponseModel({
    required this.result,
    required this.message,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      BaseResponseModel(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };
}
