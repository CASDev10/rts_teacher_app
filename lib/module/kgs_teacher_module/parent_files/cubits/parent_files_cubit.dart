import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/module/kgs_teacher_module/parent_files/cubits/parent_files_state.dart';

import '../../../../core/api_result.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../home/repo/home_repo.dart';
import '../models/parent_files_response.dart';

class ParentFilesCubit extends Cubit<ParentFilesState> {
  ParentFilesCubit(this._repository) : super(ParentFilesState.initial());

  HomeRepository _repository;

  Future getParentFiles() async {
    emit(state.copyWith(status: ParentFilesStatus.loading));

    try {
      ParentFilesResponse response = await _repository.getParentFiles();
      if (response.result == ApiResult.success) {
        emit(
          state.copyWith(
            status: ParentFilesStatus.success,
            parentFiles: response.parentsFileList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ParentFilesStatus.failure,
            message: response.message,
          ),
        );
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(status: ParentFilesStatus.failure, message: e.message),
      );
    } catch (_) {}
  }
}
