import 'package:rts/module/kgs_teacher_module/student_result/models/student_list_input.dart';
import 'package:rts/module/kgs_teacher_module/student_result/models/student_marking_object.dart';

class CreateUpdateAwardInput {
  StudentListInput examMaster;
  List<StudentMarkingObject> examDetailList;

  CreateUpdateAwardInput({
    required this.examMaster,
    required this.examDetailList,
  });

  CreateUpdateAwardInput copyWith({
    StudentListInput? examMaster,
    List<StudentMarkingObject>? examDetailList,
  }) => CreateUpdateAwardInput(
    examMaster: examMaster ?? this.examMaster,
    examDetailList: examDetailList ?? this.examDetailList,
  );
  Map<String, dynamic> toJson() => {
    "ExamMaster": examMaster.toResultSubmission(),
    "ExamDetailList": List<dynamic>.from(examDetailList.map((x) => x.toJson())),
  };
}
