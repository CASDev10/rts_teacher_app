import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/network_service/network_service.dart';
import '../../base_resposne_model.dart';
import '../../class_section/model/classes_model.dart';
import '../../class_section/model/sections_model.dart';
import '../../kgs_teacher_auth/repo/auth_repository.dart';
import '../../student_result/models/evaluation_response.dart';
import '../../student_result/models/evaluation_type_response.dart';
import '../models/evaluation_by_student_id_response.dart';
import '../models/process_result_input.dart';
import '../models/processing_result_response.dart';
import '../models/save_evaluation_input.dart';
import '../models/student_evaluation_list_input.dart';
import '../models/student_evaluation_list_response.dart';
import '../models/student_outcomes_input.dart';
import '../models/unProcess_result_input.dart';

class StudentEvaluationRepository {
  final NetworkService _networkService = sl<NetworkService>();
  final AuthRepository _authRepository = sl<AuthRepository>();

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

  Future<EvaluationTypeResponse> getEvaluationType() async {
    try {
      var response = await _networkService.get(Endpoints.getEvaluationTypes);
      EvaluationTypeResponse evaluationTypeResponse = await compute(
        evaluationTypeResponseFromJson,
        response,
      );
      return evaluationTypeResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<EvaluationResponse> getEvaluation({
    required int evaluationTypeId,
  }) async {
    try {
      var response = await _networkService.get(
        Endpoints.getEvaluation,
        data: {
          "UC_EntityId": _authRepository.user.entityId,
          "EvaluationTypeId": evaluationTypeId,
          "UC_SchoolId": _authRepository.user.schoolId,
        },
      );
      EvaluationResponse evaluationResponse = await compute(
        evaluationResponseFromJson,
        response,
      );
      return evaluationResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<StudentEvaluationListResponse> getStudentsEvaluationList({
    required StudentEvaluationListInput input,
  }) async {
    try {
      var response = await _networkService.post(
        Endpoints.addUpdateKinderGartenTermOneResultPrep,
        data: input.toJson(),
      );
      StudentEvaluationListResponse studentEvaluationListResponse =
          await compute(studentEvaluationListResponseFromJson, response);
      return studentEvaluationListResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<StudentOutcomesListResponse> getStudentOutcomes({
    required StudentOutcomesInput input,
  }) async {
    try {
      var response = await _networkService.post(
        Endpoints.addUpdateKinderGartenTermOneResultPrep,
        data: input.toJson(),
      );
      StudentOutcomesListResponse studentOutcomesListResponse = await compute(
        studentOutcomesListResponseFromJson,
        response,
      );
      return studentOutcomesListResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<BaseResponseModel> saveOutcomeResults({
    required SaveEvaluationInput input,
  }) async {
    try {
      var response = await _networkService.post(
        Endpoints.addUpdateKinderGartenTermOneResultPrep,
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

  Future<ProcessingResult> processResult({
    required ProcessResultInput input,
  }) async {
    try {
      var response = await _networkService.post(
        Endpoints.addUpdateKinderGartenTermOneResultPrep,
        data: input.toJson(),
      );
      ProcessingResult processingResult = await compute(
        processingResultFromJson,
        response,
      );
      return processingResult;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<ProcessingResult> unProcessResult({
    required UnProcessResultInput input,
  }) async {
    try {
      var response = await _networkService.post(
        Endpoints.addUpdateKinderGartenTermOneResultPrep,
        data: input.toJson(),
      );
      ProcessingResult processingResult = await compute(
        processingResultFromJson,
        response,
      );
      return processingResult;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }
}
