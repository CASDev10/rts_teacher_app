import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/network_service/network_service.dart';
import '../../kgs_teacher_auth/repo/auth_repository.dart';
import '../model/classes_model.dart';
import '../model/sections_model.dart';

class ClassesSectionsRepository {
  final NetworkService _networkService = sl<NetworkService>();
  AuthRepository _authRepository = sl<AuthRepository>();

  Future<ClassesModel> getClasses() async {
    try {
      Map<String, dynamic> input = {
        "UC_LoginUserId": _authRepository.user.userId,
        "UC_EntityId": _authRepository.user.entityId,
        "UC_SchoolId": _authRepository.user.schoolId,
      };

      var response = await _networkService.get(
        Endpoints.getClassesForAttendance,
        data: input,
      );

      ClassesModel classesModel = await compute(classesModelFromJson, response);

      return classesModel;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<SectionsModel> getSections(String classId) async {
    try {
      Map<String, dynamic> input = {
        "UC_LoginUserId": _authRepository.user.userId,
        "UC_EntityId": _authRepository.user.entityId,
        "UC_SchoolId": _authRepository.user.schoolId,
        "ClassIdFk": classId,
      };

      var response = await _networkService.get(
        Endpoints.getSectionsForAttendance,
        data: input,
      );

      SectionsModel sectionsModel = await compute(
        sectionsModelFromJson,
        response,
      );

      return sectionsModel;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }
}
