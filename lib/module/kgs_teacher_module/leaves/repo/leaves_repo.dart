import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/network_service/network_service.dart';
import '../../base_resposne_model.dart';
import '../../kgs_teacher_auth/repo/auth_repository.dart';
import '../model/add_update_leave_input.dart';
import '../model/employee_leaves_response.dart';
import '../model/leave_balance_response.dart';

class LeavesRepository {
  final NetworkService _networkService = sl<NetworkService>();
  final AuthRepository _authRepository = sl<AuthRepository>();

  Future<LeaveBalanceResponse> getEmployeeLeaveBalance() async {
    try {
      var response = await _networkService.get(
        Endpoints.getEmployeeLeaveBalance,
        data: {"EmpId": _authRepository.user.userId, "Option": 0},
      );
      LeaveBalanceResponse leaveBalanceResponse = await compute(
        leaveBalanceResponseFromJson,
        response,
      );
      return leaveBalanceResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<EmployeeLeavesResponse> getGetEmployeeLeaves() async {
    try {
      var response = await _networkService.get(
        Endpoints.getEmployeeLeavesByEmpId,
        data: {"EmpId": _authRepository.user.userId},
      );
      EmployeeLeavesResponse employeeLeavesResponse = await compute(
        employeeLeavesResponseFromJson,
        response,
      );
      return employeeLeavesResponse;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<BaseResponseModel> addUpdateEmployeeLeave({
    required AddUpdateLeaveInput input,
  }) async {
    try {
      var response = await _networkService.post(
        Endpoints.insertEmployeeLeave,
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

  Future<BaseResponseModel> deleteLeave({required int id}) async {
    try {
      var response = await _networkService.delete(
        Endpoints.deleteLeave,
        data: {"ID": id},
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
