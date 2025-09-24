import 'dart:convert';

AttendanceHistoryInput attendanceHistoryInputFromJson(dynamic json) =>
    AttendanceHistoryInput.fromJson(json);

String attendanceHistoryInputToJson(AttendanceHistoryInput data) =>
    json.encode(data.toJson());

class AttendanceHistoryInput {
  String startDate;
  String endDate;
  int empId;
  int ucEntityId;
  int ucSchoolId;

  AttendanceHistoryInput({
    required this.startDate,
    required this.endDate,
    required this.empId,
    required this.ucEntityId,
    required this.ucSchoolId,
  });

  AttendanceHistoryInput copyWith({
    String? startDate,
    String? endDate,
    int? empId,
    int? ucEntityId,
    int? ucSchoolId,
  }) =>
      AttendanceHistoryInput(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        empId: empId ?? this.empId,
        ucEntityId: ucEntityId ?? this.ucEntityId,
        ucSchoolId: ucSchoolId ?? this.ucSchoolId,
      );

  factory AttendanceHistoryInput.fromJson(Map<String, dynamic> json) =>
      AttendanceHistoryInput(
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        empId: json["EmpId"],
        ucEntityId: json["UC_EntityId"],
        ucSchoolId: json["UC_SchoolId"],
      );

  Map<String, dynamic> toJson() => {
        "StartDate": startDate,
        "EndDate": endDate,
        "EmpId": empId,
        "UC_EntityId": ucEntityId,
        "UC_SchoolId": ucSchoolId,
      };
}
