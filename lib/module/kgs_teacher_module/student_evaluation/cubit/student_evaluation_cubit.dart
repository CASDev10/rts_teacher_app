import 'package:bloc/bloc.dart';
import 'package:rts/module/kgs_teacher_module/student_evaluation/cubit/student_evaluation_state.dart';

import '../../../../core/api_result.dart';
import '../../../../core/failures/base_failures/base_failure.dart';
import '../../../../core/failures/high_priority_failure.dart';
import '../../../../utils/display/display_utils.dart';
import '../../class_section/model/classes_model.dart';
import '../../class_section/model/sections_model.dart';
import '../../student_result/models/evaluation_response.dart';
import '../../student_result/models/evaluation_type_response.dart';
import '../models/evaluation_by_student_id_response.dart';
import '../models/process_result_input.dart';
import '../models/processing_result_response.dart';
import '../models/student_evaluation_list_input.dart';
import '../models/student_evaluation_list_response.dart';
import '../models/student_outcomes_input.dart';
import '../models/unProcess_result_input.dart';
import '../repo/student_evaluation_repository.dart';

class StudentsEvaluationCubit extends Cubit<StudentsEvaluationState> {
  StudentsEvaluationCubit(this._repository)
    : super(StudentsEvaluationState.initial());
  StudentEvaluationRepository _repository;

  StudentEvaluationListInput? input;

  Future init({
    required StudentEvaluationListInput input,
    required List<StudentEvaluationDataModel> studentList,
  }) async {
    emit(
      state.copyWith(studentEvaluationStatus: StudentsEvaluationStatus.loading),
    );
    this.input = input;
    emit(
      state.copyWith(
        studentEvaluationStatus: StudentsEvaluationStatus.success,
        studentList: studentList,
      ),
    );
  }

  Future fetchEvaluationType() async {
    DisplayUtils.showLoader();
    emit(
      state.copyWith(studentEvaluationStatus: StudentsEvaluationStatus.loading),
    );
    try {
      EvaluationTypeResponse evaluationTypeResponse =
          await _repository.getEvaluationType();

      emit(
        state.copyWith(
          studentEvaluationStatus: StudentsEvaluationStatus.success,
          evaluationTypes: evaluationTypeResponse.data,
          evaluations: <EvaluationModel>[],
        ),
      );
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(
        state.copyWith(
          studentEvaluationStatus: StudentsEvaluationStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future fetchEvaluation({required int evaluationTypeId}) async {
    DisplayUtils.showLoader();
    emit(
      state.copyWith(studentEvaluationStatus: StudentsEvaluationStatus.loading),
    );
    try {
      EvaluationResponse evaluationTypeResponse = await _repository
          .getEvaluation(evaluationTypeId: evaluationTypeId);

      emit(
        state.copyWith(
          studentEvaluationStatus: StudentsEvaluationStatus.success,
          evaluations: evaluationTypeResponse.data,
        ),
      );
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(
        state.copyWith(
          studentEvaluationStatus: StudentsEvaluationStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future fetchClasses() async {
    DisplayUtils.showLoader();
    emit(
      state.copyWith(studentEvaluationStatus: StudentsEvaluationStatus.loading),
    );

    try {
      ClassesModel classesModel = await _repository.getClasses();

      if (classesModel.result == ApiResult.success) {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.success,
            classes: classesModel.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.failure,
            failure: HighPriorityException(classesModel.message),
          ),
        );
      }
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          studentEvaluationStatus: StudentsEvaluationStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
      DisplayUtils.removeLoader();
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future fetchSections(String classId) async {
    DisplayUtils.showLoader();
    emit(
      state.copyWith(studentEvaluationStatus: StudentsEvaluationStatus.loading),
    );

    try {
      SectionsModel sectionsModel = await _repository.getSections(classId);

      if (sectionsModel.result == ApiResult.success) {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.success,
            sections: sectionsModel.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.failure,
            failure: HighPriorityException(sectionsModel.message),
          ),
        );
      }
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          studentEvaluationStatus: StudentsEvaluationStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
      DisplayUtils.removeLoader();
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future clearStudentList() async {
    DisplayUtils.showLoader();
    emit(
      state.copyWith(studentEvaluationStatus: StudentsEvaluationStatus.loading),
    );
    await Future.delayed(Duration(seconds: 1), () {
      emit(
        state.copyWith(
          studentEvaluationStatus: StudentsEvaluationStatus.loading,
          studentList: [],
        ),
      );
    });
    DisplayUtils.removeLoader();
  }

  Future fetchStudentsList(
    StudentEvaluationListInput input, {
    bool showLoading = true,
  }) async {
    if (showLoading) {
      DisplayUtils.showLoader();
    }

    emit(
      state.copyWith(studentEvaluationStatus: StudentsEvaluationStatus.loading),
    );

    try {
      StudentEvaluationListResponse response = await _repository
          .getStudentsEvaluationList(input: input);

      if (response.result == ApiResult.success) {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.success,
            studentList: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.failure,
            failure: HighPriorityException(response.message),
          ),
        );
      }
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          studentEvaluationStatus: StudentsEvaluationStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
      DisplayUtils.removeLoader();
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future fetchStudentOutcomes(
    StudentOutcomesInput input, {
    bool showLoading = true,
  }) async {
    if (showLoading) {
      DisplayUtils.showLoader();
    }

    emit(
      state.copyWith(studentEvaluationStatus: StudentsEvaluationStatus.loading),
    );

    try {
      StudentOutcomesListResponse response = await _repository
          .getStudentOutcomes(input: input);

      if (response.result == ApiResult.success) {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.success,
          ),
        );
        DisplayUtils.removeLoader();
        return response;
      } else {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.failure,
            failure: HighPriorityException(response.message),
          ),
        );
        DisplayUtils.removeLoader();
        return null;
      }
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          studentEvaluationStatus: StudentsEvaluationStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
      DisplayUtils.removeLoader();
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future processResult(ProcessResultInput input) async {
    DisplayUtils.showLoader();
    emit(
      state.copyWith(studentEvaluationStatus: StudentsEvaluationStatus.loading),
    );

    try {
      ProcessingResult processingResult = await _repository.processResult(
        input: input,
      );

      if (processingResult.result == ApiResult.success) {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.failure,
            failure: HighPriorityException(processingResult.message),
          ),
        );
      }
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          studentEvaluationStatus: StudentsEvaluationStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
      DisplayUtils.removeLoader();
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future unProcessResult(UnProcessResultInput input) async {
    DisplayUtils.showLoader();
    emit(
      state.copyWith(studentEvaluationStatus: StudentsEvaluationStatus.loading),
    );

    try {
      ProcessingResult processingResult = await _repository.unProcessResult(
        input: input,
      );

      if (processingResult.result == ApiResult.success) {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            studentEvaluationStatus: StudentsEvaluationStatus.failure,
            failure: HighPriorityException(processingResult.message),
          ),
        );
      }
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      emit(
        state.copyWith(
          studentEvaluationStatus: StudentsEvaluationStatus.failure,
          failure: HighPriorityException(e.message),
        ),
      );
      DisplayUtils.removeLoader();
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }
}
