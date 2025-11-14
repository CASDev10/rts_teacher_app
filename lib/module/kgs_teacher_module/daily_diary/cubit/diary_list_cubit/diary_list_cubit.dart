import 'package:bloc/bloc.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/get_diary_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/repo/diary_repo.dart';

import '../../../../../core/api_result.dart';
import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../../../../core/failures/high_priority_failure.dart';
import '../../../../../utils/display/display_utils.dart';
import '../../models/diary_list_response.dart';
import 'diary_list_state.dart';

class DiaryListCubit extends Cubit<DiaryListState> {
  DiaryListCubit(this._repository) : super(DiaryListState.initial());

  DiaryRepository _repository;

  List<DiaryModel> diaryList = [];

  Future fetchDiaryList(GetDiaryInput input, {bool loadMore = false}) async {
    emit(
      state.copyWith(
        diaryListStatus: loadMore
            ? DiaryListStatus.loadMore
            : DiaryListStatus.loading,
      ),
    );
    if (loadMore) {
      DisplayUtils.showLoader();
    } else {
      diaryList.clear();
    }
    try {
      DiaryListResponseModel response = await _repository.getDiaryList(input);
      if (response.result == ApiResult.success) {
        diaryList.addAll(response.data);
        emit(
          state.copyWith(
            diaryListStatus: DiaryListStatus.success,
            diaryList: diaryList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            diaryListStatus: DiaryListStatus.failure,
            failure: HighPriorityException(response.message),
          ),
        );
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          diaryListStatus: DiaryListStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {}
    if (loadMore) {
      DisplayUtils.removeLoader();
    }
  }
}
