import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/module/kgs_teacher_module/home/repo/home_repo.dart';
import 'package:rts/module/kgs_teacher_module/parent_files/cubits/parent_files_state.dart';
import 'package:rts/module/kgs_teacher_module/parent_files/models/parent_file_input.dart';

import '../../../../core/api_result.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../utils/display/display_utils.dart';
import '../models/parent_files_response.dart';

class ParentFilesCubit extends Cubit<ParentFilesState> {
  ParentFilesCubit(this._repository) : super(ParentFilesState.initial());

  HomeRepository _repository;
  List<ParentsFileList> parentFiles = [];

  Future getParentFiles(ParentFileInput input, {bool loadMore = false}) async {
    emit(state.copyWith(
        status:
            loadMore ? ParentFilesStatus.loadMore : ParentFilesStatus.loading));

    if (loadMore) {
      DisplayUtils.showLoader();
    } else {
      parentFiles.clear();
    }
    try {
      ParentFilesResponse responseModel =
          await _repository.getParentFiles(input);

      if (responseModel.result == ApiResult.success) {
        parentFiles.addAll(responseModel.parentsFileList);

        emit(state.copyWith(
          status: ParentFilesStatus.success,
          parentFiles: parentFiles,
        ));
      } else {
        emit(state.copyWith(
            status: ParentFilesStatus.success, message: responseModel.message));
      }
    } on BaseFailure catch (e) {
      emit(state.copyWith(
          status: ParentFilesStatus.success, message: e.message));
    } catch (_) {}
    if (loadMore) {
      DisplayUtils.removeLoader();
    }
  }

// Future getParentFiles() async {
//   emit(state.copyWith(status: ParentFilesStatus.loading));
//
//   try {
//     ParentFilesResponse response = await _repository.getParentFiles();
//     if (response.result == ApiResult.success) {
//       emit(state.copyWith(
//           status: ParentFilesStatus.success,
//           parentFiles: response.parentsFileList));
//     } else {
//       emit(state.copyWith(
//           status: ParentFilesStatus.failure, message: response.message));
//     }
//   } on BaseFailure catch (e) {
//     emit(state.copyWith(
//         status: ParentFilesStatus.failure, message: e.message));
//   } catch (_) {}
// }
}
