import 'package:bloc/bloc.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/repo/auth_repository.dart';
import 'package:rts/module/kgs_teacher_module/student_result/cubit/student_result/student_result_state.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/class_name_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/evaluation_type_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/grade_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/sections_name_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_input.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_response.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/subjects_response.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../../../../core/failures/high_priority_failure.dart';
import '../../../../../utils/display/display_utils.dart';
import '../../models/evaluation_response.dart';
import '../../repo/student_result_repo.dart';

class StudentResultCubit extends Cubit<StudentResultState> {
  StudentResultCubit(this._repository) : super(StudentResultState.initial());
  StudentResultRepository _repository;
  final AuthRepository _authRepository = sl<AuthRepository>();

  Future fetchGradesList() async {
    DisplayUtils.showLoader();
    emit(state.copyWith(studentAttendanceStatus: StudentResultStatus.loading));
    try {
      GradesResponse gradesResponse = await _repository.getGradeResponse();
      List<GradeModel> gradesList = state.grades;
      print(" Grade List Length ${gradesList.length}");
      gradesList.addAll(gradesResponse.data);

      print(" Grade List Length ${gradesList.length}");
      emit(
        state.copyWith(
            studentAttendanceStatus: StudentResultStatus.success,
            grades: gradesList,
            classNames: [],
            sectionsNames: [],
            subjectsName: []),
      );
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(state.copyWith(
          studentAttendanceStatus: StudentResultStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future fetchEvaluationType() async {
    DisplayUtils.showLoader();
    emit(state.copyWith(studentAttendanceStatus: StudentResultStatus.loading));
    try {
      EvaluationTypeResponse evaluationTypeResponse =
          await _repository.getEvaluationType();

      emit(
        state.copyWith(
            studentAttendanceStatus: StudentResultStatus.success,
            evaluationTypes: evaluationTypeResponse.data),
      );
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(state.copyWith(
          studentAttendanceStatus: StudentResultStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future fetchEvaluation({required int evaluationTypeId}) async {
    DisplayUtils.showLoader();
    emit(state.copyWith(studentAttendanceStatus: StudentResultStatus.loading));
    try {
      EvaluationResponse evaluationTypeResponse =
          await _repository.getEvaluation(evaluationTypeId: evaluationTypeId);

      emit(
        state.copyWith(
          studentAttendanceStatus: StudentResultStatus.success,
          evaluations: evaluationTypeResponse.data,
        ),
      );
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(state.copyWith(
          studentAttendanceStatus: StudentResultStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future fetchClassNames({required int gradeId}) async {
    DisplayUtils.showLoader();
    emit(state.copyWith(studentAttendanceStatus: StudentResultStatus.loading));
    try {
      ClassNamesResponse classNamesResponse =
          await _repository.getClassesResponse(gradeId: gradeId);

      emit(
        state.copyWith(
          studentAttendanceStatus: StudentResultStatus.success,
          classNames: classNamesResponse.data,
        ),
      );
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(state.copyWith(
          studentAttendanceStatus: StudentResultStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future fetchSectionsAndSubjects({required int classId}) async {
    DisplayUtils.showLoader();
    emit(state.copyWith(studentAttendanceStatus: StudentResultStatus.loading));

    try {
      late SubjectsResponse subjectsResponse;
      late SectionsListResponse sectionsListResponse;
      Future getSubjects() async {
        subjectsResponse = await _repository.getSubjectsOfClass(
          classId: classId,
        );
      }

      Future getSections() async {
        sectionsListResponse = await _repository.getClassSection(
          classId: classId,
        );
      }

      await Future.wait([getSections(), getSubjects()]);
      emit(
        state.copyWith(
            studentAttendanceStatus: StudentResultStatus.success,
            sectionsNames: sectionsListResponse.data.sectionsList,
            subjectsName: subjectsResponse
                .data // Default to empty list if it's null or empty,
            ),
      );
      DisplayUtils.removeLoader();
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(state.copyWith(
          studentAttendanceStatus: StudentResultStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }

  Future fetchStudentList({required StudentListInput input}) async {
    DisplayUtils.showLoader();
    emit(state.copyWith(studentAttendanceStatus: StudentResultStatus.loading));

    try {
      StudentListResponse studentListResponse =
          await _repository.getStudentList(input: input);
      emit(
        state.copyWith(
          studentAttendanceStatus: StudentResultStatus.success,
        ),
      );
      DisplayUtils.removeLoader();
      return studentListResponse;
    } on BaseFailure catch (e) {
      DisplayUtils.removeLoader();
      emit(state.copyWith(
          studentAttendanceStatus: StudentResultStatus.failure,
          failure: HighPriorityException(e.message)));
    } catch (_) {
      DisplayUtils.removeLoader();
    }
  }
}
