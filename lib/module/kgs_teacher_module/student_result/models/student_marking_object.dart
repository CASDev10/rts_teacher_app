class StudentMarkingObject {
  int examDetailId;
  int studentId;
  double obtainedMarks;
  double obtainedPercentage;
  String obtainedGrade;
  int attendanceStatusId;
  int awardListStatusId;

  StudentMarkingObject({
    required this.examDetailId,
    required this.studentId,
    required this.obtainedMarks,
    required this.obtainedPercentage,
    required this.obtainedGrade,
    required this.attendanceStatusId,
    required this.awardListStatusId,
  });

  StudentMarkingObject copyWith({
    int? examDetailId,
    int? studentId,
    double? obtainedMarks,
    double? obtainedPercentage,
    String? obtainedGrade,
    int? attendanceStatusId,
    int? awardListStatusId,
  }) =>
      StudentMarkingObject(
        examDetailId: examDetailId ?? this.examDetailId,
        studentId: studentId ?? this.studentId,
        obtainedMarks: obtainedMarks ?? this.obtainedMarks,
        obtainedPercentage: obtainedPercentage ?? this.obtainedPercentage,
        obtainedGrade: obtainedGrade ?? this.obtainedGrade,
        attendanceStatusId: attendanceStatusId ?? this.attendanceStatusId,
        awardListStatusId: awardListStatusId ?? this.awardListStatusId,
      );

  factory StudentMarkingObject.fromJson(Map<String, dynamic> json) =>
      StudentMarkingObject(
        examDetailId: json["ExamDetailId"],
        studentId: json["StudentId"],
        obtainedMarks: json["ObtainedMarks"],
        obtainedPercentage: json["ObtainedPercentage"],
        obtainedGrade: json["ObtainedGrade"],
        attendanceStatusId: json["AttendanceStatusId"],
        awardListStatusId: json["AwardListStatusId"],
      );

  Map<String, dynamic> toJson() => {
        "ExamDetailId": examDetailId,
        "StudentId": studentId,
        "ObtainedMarks": obtainedMarks,
        "ObtainedPercentage": obtainedPercentage,
        "ObtainedGrade": obtainedGrade,
        "AttendanceStatusId": 2,
        "AwardListStatusId": awardListStatusId,
      };
}
