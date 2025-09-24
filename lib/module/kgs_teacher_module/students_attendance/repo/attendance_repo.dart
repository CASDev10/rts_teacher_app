import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:rts/constants/api_endpoints.dart';
import 'package:rts/core/di/service_locator.dart';
import 'package:rts/core/failures/base_failures/base_failure.dart';
import 'package:rts/core/network_service/network_service.dart';
import 'package:rts/module/kgs_teacher_module/students_attendance/models/attendance_input.dart';
import 'package:rts/module/kgs_teacher_module/students_attendance/models/attendance_reponse.dart';
import 'package:rts/module/kgs_teacher_module/students_attendance/models/submit_attendance_input.dart';
import 'package:rts/module/kgs_teacher_module/students_attendance/models/submit_attendance_reponse.dart';

import '../../base_resposne_model.dart';

class AttendanceRepository {
  final NetworkService _networkService = sl<NetworkService>();

  Future<AttendanceResponseModel> getGetSectionStudentList(AttendanceInput input) async {
    try {
      var response = await _networkService.get(
        Endpoints.getGetSectionStudentList,
        data: input.toJson(),
      );
      AttendanceResponseModel attendanceResponseModel =
          await compute(attendanceResponseModelFromJson, response);
      return attendanceResponseModel;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<BaseResponseModel> submitAttendance(SubmitAttendanceInput input) async {
    try {
      var response = await _networkService.post(
        Endpoints.addSchoolAttendance,
        data: input.toJson(),
      );
      BaseResponseModel baseResponseModel =
      await compute(baseResponseModelFromJson, response);
      return baseResponseModel;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }
}
