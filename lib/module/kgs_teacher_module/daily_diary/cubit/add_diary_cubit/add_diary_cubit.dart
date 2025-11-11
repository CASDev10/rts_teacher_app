import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/add_diary_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/add_diary_response.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/class_student_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/diary_description_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/diary_input.dart'
    show DiaryInput;
import 'package:rts/module/kgs_teacher_module/daily_diary/models/students_model.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/repo/diary_repo.dart';

import '../../../../../core/api_result.dart';
import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../../../../core/failures/high_priority_failure.dart';
import '../../../base_resposne_model.dart';
import '../../models/student_diary_list_response.dart';
import 'add_diary_state.dart';

class AddDiaryCubit extends Cubit<AddDiaryState> {
  AddDiaryCubit(this._repository) : super(AddDiaryState.initial());

  DiaryRepository _repository;

  // Future addDiary(AddDiaryInput input) async {
  //   emit(state.copyWith(addDiaryStatus: AddDiaryStatus.loading));
  //   try {
  //     AddDiaryResponseModel response = await _repository.addDiary(input);
  //     if (response.result == ApiResult.success) {
  //       emit(state.copyWith(addDiaryStatus: AddDiaryStatus.success));
  //     } else {
  //       emit(
  //         state.copyWith(
  //           addDiaryStatus: AddDiaryStatus.failure,
  //           failure: HighPriorityException(response.message),
  //         ),
  //       );
  //     }
  //   } on BaseFailure catch (e) {
  //     emit(
  //       state.copyWith(
  //         addDiaryStatus: AddDiaryStatus.failure,
  //         failure: HighPriorityException(e.message),
  //       ),
  //     );
  //   } catch (_) {}
  // }

  Future uploadTeacherFileDiary(DiaryInput input, [MultipartFile? file]) async {
    emit(state.copyWith(addDiaryStatus: AddDiaryStatus.loading));
    try {
      print('Diary cubit');
      print('Diary cubit ###${input.toJson()}');
      BaseResponseModel response = await _repository.uploadTeacherFile(
        input,
        file,
      );
      if (response.result == ApiResult.success) {
        emit(state.copyWith(addDiaryStatus: AddDiaryStatus.success));
        return true;
      } else {
        emit(
          state.copyWith(
            addDiaryStatus: AddDiaryStatus.failure,
            failure: HighPriorityException(response.message),
          ),
        );
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          addDiaryStatus: AddDiaryStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {}
  }

  Future uploadTeacherAssignment(DiaryDescriptionInput input) async {
    emit(state.copyWith(addDiaryStatus: AddDiaryStatus.loading));
    try {
      BaseResponseModel response = await _repository.uploadTeacherAssignment(
        input,
      );
      if (response.result == ApiResult.success) {
        emit(state.copyWith(addDiaryStatus: AddDiaryStatus.success));
        return true;
      } else {
        emit(
          state.copyWith(
            addDiaryStatus: AddDiaryStatus.failure,
            failure: HighPriorityException(response.message),
          ),
        );
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          addDiaryStatus: AddDiaryStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {}
  }

  Future fetchDiaryStudentList(dynamic input) async {
    print('Inside cubit:${input}}');
    emit(state.copyWith(addDiaryStatus: AddDiaryStatus.loading));
    try {
      StudentsModel response = await _repository.getClassStudents(input);
      if (response.result == ApiResult.success) {
        emit(
          state.copyWith(
            addDiaryStatus: AddDiaryStatus.success,
            studentList: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            addDiaryStatus: AddDiaryStatus.failure,
            failure: HighPriorityException(response.message),
          ),
        );
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          addDiaryStatus: AddDiaryStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {}
  }
}
