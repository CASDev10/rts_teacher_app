import 'package:bloc/bloc.dart';

import '../../../../../core/api_result.dart';
import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../../../../core/failures/high_priority_failure.dart';
import '../../models/employee_detail_response.dart';
import '../../repo/observation_repo.dart';

part 'employee_detail_state.dart';

class EmployeeDetailCubit extends Cubit<EmployeeDetailState> {
  EmployeeDetailCubit(this.repository) : super(EmployeeDetailState.initial());

  ObservationRepository repository;

  Future getEmployeeDetail(String empId) async {
    try {
      emit(state.copyWith(employeeDetailStatus: EmployeeDetailStatus.loading));
      EmployeeDetailResponse employeeDetailResponse = await repository
          .getEmployeeDetail(empId);
      if (employeeDetailResponse.result == ApiResult.success) {
        if (employeeDetailResponse.data.isNotEmpty) {
          emit(
            state.copyWith(
              employeeDetailStatus: EmployeeDetailStatus.success,
              employeeModel: employeeDetailResponse.data.first,
            ),
          );
        } else {
          emit(
            state.copyWith(
              employeeDetailStatus: EmployeeDetailStatus.failure,
              failure: HighPriorityException("Employee data not found"),
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            employeeDetailStatus: EmployeeDetailStatus.failure,
            failure: HighPriorityException(employeeDetailResponse.message),
          ),
        );
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          employeeDetailStatus: EmployeeDetailStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {}
  }
}
