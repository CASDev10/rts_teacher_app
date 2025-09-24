import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_input.dart';

import '../../../../../../core/failures/base_failures/base_failure.dart';
import '../../models/student_list_response.dart';

enum MarkingStudentStatus {
  none,
  loading,
  success,
  failure,
}

class MarkingStudentState {
  final MarkingStudentStatus markingStudentStatus;
  final BaseFailure failure;
  final List<AwardListStatusList> awardListStatusList;
  final List<ExamDetailList> examDetailList;
  final StudentListInput? examMaster;
  MarkingStudentState({
    required this.markingStudentStatus,
    required this.examDetailList,
    required this.failure,
    required this.examMaster,
    required this.awardListStatusList,
  });

  factory MarkingStudentState.initial() {
    return MarkingStudentState(
      markingStudentStatus: MarkingStudentStatus.none,
      failure: const BaseFailure(),
      examDetailList: [],
      awardListStatusList: [],
      examMaster: null,
    );
  }

  MarkingStudentState copyWith(
      {MarkingStudentStatus? markingStudentStatus,
      List<ExamDetailList>? examDetailList,
      List<AwardListStatusList>? awardListStatusList,
      BaseFailure? failure,
      StudentListInput? examMaster}) {
    return MarkingStudentState(
      markingStudentStatus: markingStudentStatus ?? this.markingStudentStatus,
      failure: failure ?? this.failure,
      examDetailList: examDetailList ?? this.examDetailList,
      awardListStatusList: awardListStatusList ?? this.awardListStatusList,
      examMaster: examMaster ?? this.examMaster,
    );
  }
}
