import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/network_service/network_service.dart';
import '../../base_resposne_model.dart';
import '../models/attendance_input.dart';
import '../models/attendance_reponse.dart';
import '../models/submit_attendance_input.dart';

class AttendanceRepository {
  final NetworkService _networkService = sl<NetworkService>();

  Future<AttendanceResponseModel> getGetSectionStudentList(
    AttendanceInput input,
  ) async {
    try {
      var response = await _networkService.get(
        Endpoints.getGetSectionStudentList,
        data: input.toJson(),
      );
      AttendanceResponseModel attendanceResponseModel = await compute(
        attendanceResponseModelFromJson,
        response,
      );
      return attendanceResponseModel;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<BaseResponseModel> submitAttendance(
    SubmitAttendanceInput input,
  ) async {
    try {
      var response = await _networkService.post(
        Endpoints.addSchoolAttendance,
        data: input.toJson(),
      );
      BaseResponseModel baseResponseModel = await compute(
        baseResponseModelFromJson,
        response,
      );
      return baseResponseModel;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }
}
