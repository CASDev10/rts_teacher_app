import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/network_service/network_service.dart';
import '../models/attendance_history_input.dart';
import '../models/attendance_history_model.dart';

class AttendanceHistoryRepository {
  final NetworkService _networkService = sl<NetworkService>();
  Future<AttendanceHistoryResponse> getEmployeeAttendance({
    required AttendanceHistoryInput input,
  }) async {
    try {
      var response = await _networkService.get(
        Endpoints.getEmployeeAttendance,
        data: input,
      );
      AttendanceHistoryResponse attendanceHistoryResponse = await compute(
        attendanceHistoryResponseFromJson,
        response,
      );
      return attendanceHistoryResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }
}
