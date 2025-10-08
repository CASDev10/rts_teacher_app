// To parse this JSON data, do
//
//     final createUpdateAwardInput = createUpdateAwardInputFromJson(jsonString);

import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_input.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_marking_object.dart';

class CreateUpdateAwardInput {
  int ucLoginUserId;
  int ucEntityId;
  StudentListInput examMaster;
  List<StudentMarkingObject> examDetailList;

  CreateUpdateAwardInput({
    required this.ucLoginUserId,
    required this.ucEntityId,
    required this.examMaster,
    required this.examDetailList,
  });

  CreateUpdateAwardInput copyWith({
    int? ucLoginUserId,
    int? ucEntityId,
    StudentListInput? examMaster,
    List<StudentMarkingObject>? examDetailList,
  }) => CreateUpdateAwardInput(
    ucLoginUserId: ucLoginUserId ?? this.ucLoginUserId,
    ucEntityId: ucEntityId ?? this.ucEntityId,
    examMaster: examMaster ?? this.examMaster,
    examDetailList: examDetailList ?? this.examDetailList,
  );
  Map<String, dynamic> toJson() => {
    "UC_LoginUserId": ucLoginUserId,
    "UC_EntityId": ucEntityId,
    "ExamMaster": examMaster.toResultSubmission(),
    "ExamDetailList": List<dynamic>.from(examDetailList.map((x) => x.toJson())),
  };
}
