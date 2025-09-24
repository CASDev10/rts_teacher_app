import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:rts/module/kgs_teacher_module/base_resposne_model.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/repo/auth_repository.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/class_name_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/create_update_award_input.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/evaluation_type_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/grade_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_input.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/subjects_response.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/network_service/network_service.dart';
import '../models/evaluation_response.dart';
import '../models/sections_name_response.dart';

class StudentResultRepository {
  final NetworkService _networkService = sl<NetworkService>();
  final AuthRepository _authRepository = sl<AuthRepository>();

  Future<GradesResponse> getGradeResponse() async {
    try {
      var response = await _networkService.get(
        Endpoints.getEmployeeAssignedGrades,
        data: {"UC_LoginUserId": _authRepository.user.userId},
      );
      GradesResponse gradesResponse =
          await compute(gradesResponseFromJson, response);
      return gradesResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<ClassNamesResponse> getClassesResponse({required int gradeId}) async {
    try {
      var response = await _networkService.get(
        Endpoints.getSchoolClassesByGradeId,
        data: {
          "UC_SchoolId": _authRepository.user.schoolId,
          "GradeId": gradeId
        },
      );
      ClassNamesResponse classNamesResponse =
          await compute(classNamesResponseFromJson, response);
      return classNamesResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<SectionsListResponse> getClassSection({
    required int classId,
  }) async {
    try {
      var response = await _networkService.get(
        Endpoints.getClassSections,
        data: {"SchoolId": _authRepository.user.schoolId, "ClassId": classId},
      );
      SectionsListResponse sectionsListResponse =
          await compute(sectionsListResponseFromJson, response);
      // List<SectionsModel>? sections = sectionsResponse.data.sectionsList;
      return sectionsListResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<SubjectsResponse> getSubjectsOfClass({
    required int classId,
  }) async {
    try {
      var response = await _networkService.get(
        Endpoints.getSubjectOfClass,
        data: {
          "UC_SchoolId": _authRepository.user.schoolId,
          "ClassIdFk": classId,
          "UC_EntityId": _authRepository.user.entityId
        },
      );
      SubjectsResponse subjectsResponse =
          await compute(subjectsResponseFromJson, response);
      return subjectsResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<EvaluationTypeResponse> getEvaluationType() async {
    try {
      var response = await _networkService.get(
        Endpoints.getEvaluationTypes,
      );
      EvaluationTypeResponse evaluationTypeResponse =
          await compute(evaluationTypeResponseFromJson, response);
      return evaluationTypeResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<EvaluationResponse> getEvaluation(
      {required int evaluationTypeId}) async {
    try {
      var response = await _networkService.get(Endpoints.getEvaluation, data: {
        "UC_EntityId": _authRepository.user.entityId,
        "EvaluationTypeId": evaluationTypeId,
        "UC_SchoolId": _authRepository.user.schoolId
      });
      EvaluationResponse evaluationResponse =
          await compute(evaluationResponseFromJson, response);
      return evaluationResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<StudentListResponse> getStudentList(
      {required StudentListInput input}) async {
    try {
      var response = await _networkService.get(
        Endpoints.getSectionStudentListForResult,
        data: input.toJson(),
        // data: input.toResultSubmission(),
      );
      StudentListResponse studentListResponse =
          await compute(studentListResponseFromJson, response);
      return studentListResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<BaseResponseModel> createUpdateAwardList({
    required CreateUpdateAwardInput input,
  }) async {
    try {
      var response = await _networkService.post(
        Endpoints.createUpdateAwardList,
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
