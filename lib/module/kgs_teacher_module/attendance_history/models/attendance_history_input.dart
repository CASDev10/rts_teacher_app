import 'dart:convert';

import '../../../../core/di/service_locator.dart';
import '../../kgs_teacher_auth/repo/auth_repository.dart';

String attendanceHistoryInputToJson(AttendanceHistoryInput data) =>
    json.encode(data.toJson());

class AttendanceHistoryInput {
  final AuthRepository _authRepository = sl<AuthRepository>();
  String startDate;
  String endDate;
  int offset;
  int next;

  AttendanceHistoryInput({
    required this.startDate,
    required this.endDate,
    required this.offset,
    required this.next,
  });

  AttendanceHistoryInput copyWith({
    String? startDate,
    String? endDate,
    int? empId,
    int? ucEntityId,
    int? ucSchoolId,
    int? offset,
    int? next,
  }) =>
      AttendanceHistoryInput(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        offset: offset ?? this.offset,
        next: next ?? this.next,
      );

  Map<String, dynamic> toJson() => {
        "StartDate": startDate,
        "EndDate": endDate,
        "EmpId": _authRepository.user.userId,
        "UC_EntityId": _authRepository.user.entityId,
        "UC_SchoolId": _authRepository.user.schoolId,
        "OffSet": offset,
        "Next": next
      };
}
