import 'dart:convert';

ProcessingResult processingResultFromJson(dynamic json) =>
    ProcessingResult.fromJson(json);

String processingResultToJson(ProcessingResult data) =>
    json.encode(data.toJson());

class ProcessingResult {
  String result;
  String message;
  List<Datum> data;

  ProcessingResult({
    required this.result,
    required this.message,
    required this.data,
  });

  ProcessingResult copyWith({
    String? result,
    String? message,
    List<Datum>? data,
  }) =>
      ProcessingResult(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ProcessingResult.fromJson(Map<String, dynamic> json) =>
      ProcessingResult(
        result: json["result"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int message;

  Datum({
    required this.message,
  });

  Datum copyWith({
    int? message,
  }) =>
      Datum(
        message: message ?? this.message,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
      };
}
