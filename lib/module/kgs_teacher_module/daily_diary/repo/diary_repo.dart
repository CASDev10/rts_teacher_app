import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/add_diary_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/add_diary_response.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/assignment_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/class_student_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/diary_description_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/diary_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/diary_list_response.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/get_diary_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/punishment_assignment_repsonse.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/students_model.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/subjects_response.dart';
import '../../../../constants/api_endpoints.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/network_service/network_service.dart';
import '../../base_resposne_model.dart';
import '../../kgs_teacher_auth/repo/auth_repository.dart';
import '../models/student_diary_list_response.dart';

class DiaryRepository {
  final NetworkService _networkService = sl<NetworkService>();
  AuthRepository _authRepository = sl<AuthRepository>();

  Future<DiaryListResponseModel> getDiaryList(GetDiaryInput input) async {
    try {
      var response = await _networkService.post(
        Endpoints.getDiaryList,
        data: input.toJson(),
      );
      DiaryListResponseModel diaryListResponseModel = await compute(
        diaryListResponseModelFromJson,
        response,
      );
      return diaryListResponseModel;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  // Future<AddDiaryResponseModel> addDiary(AddDiaryInput input) async {
  //   try {
  //     var response = await _networkService.post(
  //       Endpoints.addDiary,
  //       data: input.toJson(),
  //     );
  //     AddDiaryResponseModel responseModel = await compute(
  //       addDiaryResponseModelFromJson,
  //       response,
  //     );
  //     return responseModel;
  //   } on BaseFailure catch (_) {
  //     rethrow;
  //   } on TypeError catch (e) {
  //     log('TYPE error stackTrace :: ${e.stackTrace}');
  //     rethrow;
  //   }
  // }

  Future<BaseResponseModel> uploadTeacherFile(
    DiaryInput input,
    MultipartFile? file,
  ) async {
    try {
      print('Diary Repo');
      print('Diary Repo ###${input.toJson()}');

      FormData toFormData() => FormData.fromMap({
        "Description": jsonEncode(
          input,
        ), // or input.toJson() depending on backend
        "TeacherFile": file,
      });

      var response = await _networkService.post(
        Endpoints.addDiary,
        data: toFormData(),
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

  Future<BaseResponseModel> uploadTeacherAssignment(
    DiaryDescriptionInput input,
  ) async {
    try {
      FormData toFormData() => FormData.fromMap({
        "Description": jsonEncode(input),
        "TeacherFile": input.file,
      });
      var response = await _networkService.post(
        Endpoints.uploadTeacherAssignment,
        data: toFormData(),
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

  Future<SubjectsResponseModel> getClassSubjects(String classId) async {
    try {
      Map<String, dynamic> input = {
        "UC_EntityId": _authRepository.user.entityId,
        "UC_SchoolId": _authRepository.user.schoolId,
        "ClassIdFk": classId,
      };
      var response = await _networkService.get(
        Endpoints.getSubjectOfClass,
        data: input,
      );
      SubjectsResponseModel responseModel = await compute(
        subjectsResponseModelFromJson,
        response,
      );
      return responseModel;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<StudentsModel> getClassStudents(dynamic input) async {
    try {
      var response = await _networkService.post(
        Endpoints.getStudentListByClassAndSection,
        data: input,
      );
      StudentsModel studentsModel = await compute(
        studentsModelFromJson,
        response,
      );
      return studentsModel;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<PunishmentAssignmentResponse> getAssignmentPunishment(
    AssignmentInput input,
  ) async {
    try {
      var response = await _networkService.post(
        Endpoints.getAssignmentOrPunishment,
        data: input.toJson(),
      );
      PunishmentAssignmentResponse punishmentAssignmentResponse = await compute(
        punishmentAssignmentResponseFromJson,
        response,
      );
      return punishmentAssignmentResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }
}
