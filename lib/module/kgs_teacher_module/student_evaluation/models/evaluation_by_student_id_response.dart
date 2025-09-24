import 'dart:convert';

StudentOutcomesListResponse studentOutcomesListResponseFromJson(dynamic json) =>
    StudentOutcomesListResponse.fromJson(json);

String studentEvaluationListResponseToJson(StudentOutcomesListResponse data) =>
    json.encode(data.toJson());

class StudentOutcomesListResponse {
  String result;
  String message;
  List<OutcomeParent> outcomeParents;
  List<OutcomeChild> outcomeChilds;

  StudentOutcomesListResponse({
    required this.result,
    required this.message,
    required this.outcomeParents,
    required this.outcomeChilds,
  });

  StudentOutcomesListResponse copyWith({
    String? result,
    String? message,
    List<OutcomeParent>? outcomeParents,
    List<OutcomeChild>? outcomeChilds,
  }) =>
      StudentOutcomesListResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        outcomeParents: outcomeParents ?? this.outcomeParents,
        outcomeChilds: outcomeChilds ?? this.outcomeChilds,
      );

  factory StudentOutcomesListResponse.fromJson(Map<String, dynamic> json) {
    final data = json["data"] as List<dynamic>;
    return StudentOutcomesListResponse(
      result: json["result"],
      message: json["message"],
      outcomeParents: List<OutcomeParent>.from(
          data[0].map((x) => OutcomeParent.fromJson(x))),
      outcomeChilds:
          List<OutcomeChild>.from(data[1].map((x) => OutcomeChild.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "outcomeParents":
            List<dynamic>.from(outcomeParents.map((x) => x.toJson())),
        "outcomeChilds":
            List<dynamic>.from(outcomeChilds.map((x) => x.toJson())),
      };
}

class OutcomeChild {
  int outcomeId;
  String outcome;
  int parentId;
  String description;
  bool isWorkingTowards;
  bool isWorkingWithin;
  bool isWorkingBeyond;
  String teachersGeneralComments;

  OutcomeChild({
    required this.outcomeId,
    required this.outcome,
    required this.parentId,
    required this.description,
    required this.isWorkingTowards,
    required this.isWorkingWithin,
    required this.isWorkingBeyond,
    required this.teachersGeneralComments,
  });

  OutcomeChild copyWith({
    int? outcomeId,
    String? outcome,
    int? parentId,
    String? description,
    bool? isWorkingTowards,
    bool? isWorkingWithin,
    bool? isWorkingBeyond,
    String? teachersGeneralComments,
  }) =>
      OutcomeChild(
        outcomeId: outcomeId ?? this.outcomeId,
        outcome: outcome ?? this.outcome,
        parentId: parentId ?? this.parentId,
        description: description ?? this.description,
        isWorkingTowards: isWorkingTowards ?? this.isWorkingTowards,
        isWorkingWithin: isWorkingWithin ?? this.isWorkingWithin,
        isWorkingBeyond: isWorkingBeyond ?? this.isWorkingBeyond,
        teachersGeneralComments:
            teachersGeneralComments ?? this.teachersGeneralComments,
      );

  factory OutcomeChild.fromJson(Map<String, dynamic> json) => OutcomeChild(
        outcomeId: json["OutcomeId"] ?? -1,
        outcome: json["Outcome"] ?? "",
        parentId: json["ParentId"] ?? -1,
        description: json["Description"] ?? "",
        isWorkingTowards: json["IsWorkingTowards"] ?? false,
        isWorkingWithin: json["IsWorkingWithin"] ?? false,
        isWorkingBeyond: json["IsWorkingBeyond"] ?? false,
        teachersGeneralComments: json["TeachersGeneralComments"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "OutcomeId": outcomeId,
        "Outcome": outcome,
        "ParentId": parentId,
        "Description": description,
        "IsWorkingTowards": isWorkingTowards,
        "IsWorkingWithin": isWorkingWithin,
        "IsWorkingBeyond": isWorkingBeyond,
        "TeachersGeneralComments": teachersGeneralComments,
      };
}

class OutcomeParent {
  int examId;
  int outcomeId;
  String outcome;
  String description;

  OutcomeParent({
    required this.examId,
    required this.outcomeId,
    required this.outcome,
    required this.description,
  });

  OutcomeParent copyWith({
    int? examId,
    int? outcomeId,
    String? outcome,
    String? description,
  }) =>
      OutcomeParent(
        examId: examId ?? this.examId,
        outcomeId: outcomeId ?? this.outcomeId,
        outcome: outcome ?? this.outcome,
        description: description ?? this.description,
      );

  factory OutcomeParent.fromJson(Map<String, dynamic> json) => OutcomeParent(
        examId: json["ExamId"],
        outcomeId: json["OutcomeId"],
        outcome: json["Outcome"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "ExamId": examId,
        "OutcomeId": outcomeId,
        "Outcome": outcome,
        "Description": description,
      };
}
