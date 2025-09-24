import 'dart:convert';

StudentListResponse studentListResponseFromJson(dynamic json) =>
    StudentListResponse.fromJson(json);

String studentListResponseToJson(StudentListResponse data) =>
    json.encode(data.toJson());

class StudentListResponse {
  String result;
  String message;
  StudentsListResponseModel data;

  StudentListResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  StudentListResponse copyWith({
    String? result,
    String? message,
    StudentsListResponseModel? data,
  }) =>
      StudentListResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory StudentListResponse.fromJson(Map<String, dynamic> json) =>
      StudentListResponse(
        result: json["result"],
        message: json["message"],
        data: StudentsListResponseModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data.toJson(),
      };
}

class StudentsListResponseModel {
  ExamMaster examMaster;
  List<ExamDetailList> examDetailList;
  List<GradePointList> gradePointList;
  List<AwardListStatusList> awardListStatusList;

  StudentsListResponseModel({
    required this.examMaster,
    required this.examDetailList,
    required this.gradePointList,
    required this.awardListStatusList,
  });

  StudentsListResponseModel copyWith({
    ExamMaster? examMaster,
    List<ExamDetailList>? examDetailList,
    List<GradePointList>? gradePointList,
    List<AwardListStatusList>? awardListStatusList,
  }) =>
      StudentsListResponseModel(
        examMaster: examMaster ?? this.examMaster,
        examDetailList: examDetailList ?? this.examDetailList,
        gradePointList: gradePointList ?? this.gradePointList,
        awardListStatusList: awardListStatusList ?? this.awardListStatusList,
      );

  factory StudentsListResponseModel.fromJson(Map<String, dynamic> json) =>
      StudentsListResponseModel(
        examMaster: ExamMaster.fromJson(json["ExamMaster"]),
        examDetailList: List<ExamDetailList>.from(
            json["ExamDetailList"].map((x) => ExamDetailList.fromJson(x))),
        gradePointList: List<GradePointList>.from(
            json["GradePointList"].map((x) => GradePointList.fromJson(x))),
        awardListStatusList: List<AwardListStatusList>.from(
            json["AwardListStatusList"]
                .map((x) => AwardListStatusList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ExamMaster": examMaster.toJson(),
        "ExamDetailList":
            List<dynamic>.from(examDetailList.map((x) => x.toJson())),
        "GradePointList":
            List<dynamic>.from(gradePointList.map((x) => x.toJson())),
        "AwardListStatusList":
            List<dynamic>.from(awardListStatusList.map((x) => x.toJson())),
      };
}

class AwardListStatusList {
  int awardListStatusId;
  String value;
  bool includeInResult;
  bool includeInPosition;

  AwardListStatusList({
    required this.awardListStatusId,
    required this.value,
    required this.includeInResult,
    required this.includeInPosition,
  });

  AwardListStatusList copyWith({
    int? awardListStatusId,
    String? value,
    bool? includeInResult,
    bool? includeInPosition,
  }) =>
      AwardListStatusList(
        awardListStatusId: awardListStatusId ?? this.awardListStatusId,
        value: value ?? this.value,
        includeInResult: includeInResult ?? this.includeInResult,
        includeInPosition: includeInPosition ?? this.includeInPosition,
      );

  factory AwardListStatusList.fromJson(Map<String, dynamic> json) =>
      AwardListStatusList(
        awardListStatusId: json["AwardListStatusId"],
        value: json["Value"],
        includeInResult: json["IncludeInResult"],
        includeInPosition: json["IncludeInPosition"],
      );

  Map<String, dynamic> toJson() => {
        "AwardListStatusId": awardListStatusId,
        "Value": value,
        "IncludeInResult": includeInResult,
        "IncludeInPosition": includeInPosition,
      };
}

class ExamDetailList {
  int examDetailId;
  int studentId;
  String rollNumber;
  String studentName;
  String fatherName;
  String studentStatus;
  double obtainedMarks;
  double obtainedPercentage;
  String obtainedGrade;
  int attendanceStatusId;
  String attendance;
  int awardListStatusId;
  dynamic ucUser;
  int ucLoginUserId;
  dynamic ucUserFullName;
  dynamic ucEntityCode;
  int ucEntityId;
  int ucSchoolId;
  int ucPrivilegeId;
  int ucIsAllowed;
  int ucMessageId;
  dynamic ucMessage;
  dynamic ucCompanyName;
  dynamic ucDbConnectionString;
  bool ucIsAdminUser;

  ExamDetailList({
    required this.examDetailId,
    required this.studentId,
    required this.rollNumber,
    required this.studentName,
    required this.fatherName,
    required this.studentStatus,
    required this.obtainedMarks,
    required this.obtainedPercentage,
    required this.obtainedGrade,
    required this.attendanceStatusId,
    required this.attendance,
    required this.awardListStatusId,
    required this.ucUser,
    required this.ucLoginUserId,
    required this.ucUserFullName,
    required this.ucEntityCode,
    required this.ucEntityId,
    required this.ucSchoolId,
    required this.ucPrivilegeId,
    required this.ucIsAllowed,
    required this.ucMessageId,
    required this.ucMessage,
    required this.ucCompanyName,
    required this.ucDbConnectionString,
    required this.ucIsAdminUser,
  });

  ExamDetailList copyWith({
    int? examDetailId,
    int? studentId,
    String? rollNumber,
    String? studentName,
    String? fatherName,
    String? studentStatus,
    double? obtainedMarks,
    double? obtainedPercentage,
    String? obtainedGrade,
    int? attendanceStatusId,
    String? attendance,
    int? awardListStatusId,
    dynamic ucUser,
    int? ucLoginUserId,
    dynamic ucUserFullName,
    dynamic ucEntityCode,
    int? ucEntityId,
    int? ucSchoolId,
    int? ucPrivilegeId,
    int? ucIsAllowed,
    int? ucMessageId,
    dynamic ucMessage,
    dynamic ucCompanyName,
    dynamic ucDbConnectionString,
    bool? ucIsAdminUser,
  }) =>
      ExamDetailList(
        examDetailId: examDetailId ?? this.examDetailId,
        studentId: studentId ?? this.studentId,
        rollNumber: rollNumber ?? this.rollNumber,
        studentName: studentName ?? this.studentName,
        fatherName: fatherName ?? this.fatherName,
        studentStatus: studentStatus ?? this.studentStatus,
        obtainedMarks: obtainedMarks ?? this.obtainedMarks,
        obtainedPercentage: obtainedPercentage ?? this.obtainedPercentage,
        obtainedGrade: obtainedGrade ?? this.obtainedGrade,
        attendanceStatusId: attendanceStatusId ?? this.attendanceStatusId,
        attendance: attendance ?? this.attendance,
        awardListStatusId: awardListStatusId ?? this.awardListStatusId,
        ucUser: ucUser ?? this.ucUser,
        ucLoginUserId: ucLoginUserId ?? this.ucLoginUserId,
        ucUserFullName: ucUserFullName ?? this.ucUserFullName,
        ucEntityCode: ucEntityCode ?? this.ucEntityCode,
        ucEntityId: ucEntityId ?? this.ucEntityId,
        ucSchoolId: ucSchoolId ?? this.ucSchoolId,
        ucPrivilegeId: ucPrivilegeId ?? this.ucPrivilegeId,
        ucIsAllowed: ucIsAllowed ?? this.ucIsAllowed,
        ucMessageId: ucMessageId ?? this.ucMessageId,
        ucMessage: ucMessage ?? this.ucMessage,
        ucCompanyName: ucCompanyName ?? this.ucCompanyName,
        ucDbConnectionString: ucDbConnectionString ?? this.ucDbConnectionString,
        ucIsAdminUser: ucIsAdminUser ?? this.ucIsAdminUser,
      );

  factory ExamDetailList.fromJson(Map<String, dynamic> json) => ExamDetailList(
        examDetailId: json["ExamDetailId"],
        studentId: json["StudentId"],
        rollNumber: json["RollNumber"],
        studentName: json["StudentName"],
        fatherName: json["FatherName"],
        studentStatus: json["StudentStatus"],
        obtainedMarks: json["ObtainedMarks"],
        obtainedPercentage: json["ObtainedPercentage"],
        obtainedGrade: json["ObtainedGrade"],
        attendanceStatusId: json["AttendanceStatusId"],
        attendance: json["Attendance"],
        awardListStatusId: json["AwardListStatusId"],
        ucUser: json["UC_User"],
        ucLoginUserId: json["UC_LoginUserId"],
        ucUserFullName: json["UC_UserFullName"],
        ucEntityCode: json["UC_EntityCode"],
        ucEntityId: json["UC_EntityId"],
        ucSchoolId: json["UC_SchoolId"],
        ucPrivilegeId: json["UC_PrivilegeId"],
        ucIsAllowed: json["UC_isAllowed"],
        ucMessageId: json["UC_MessageId"],
        ucMessage: json["UC_Message"],
        ucCompanyName: json["UC_CompanyName"],
        ucDbConnectionString: json["UC_DBConnectionString"],
        ucIsAdminUser: json["UC_isAdminUser"],
      );

  Map<String, dynamic> toJson() => {
        "ExamDetailId": examDetailId,
        "StudentId": studentId,
        "RollNumber": rollNumber,
        "StudentName": studentName,
        "FatherName": fatherName,
        "StudentStatus": studentStatus,
        "ObtainedMarks": obtainedMarks,
        "ObtainedPercentage": obtainedPercentage,
        "ObtainedGrade": obtainedGrade,
        "AttendanceStatusId": attendanceStatusId,
        "Attendance": attendance,
        "AwardListStatusId": awardListStatusId,
        "UC_User": ucUser,
        "UC_LoginUserId": ucLoginUserId,
        "UC_UserFullName": ucUserFullName,
        "UC_EntityCode": ucEntityCode,
        "UC_EntityId": ucEntityId,
        "UC_SchoolId": ucSchoolId,
        "UC_PrivilegeId": ucPrivilegeId,
        "UC_isAllowed": ucIsAllowed,
        "UC_MessageId": ucMessageId,
        "UC_Message": ucMessage,
        "UC_CompanyName": ucCompanyName,
        "UC_DBConnectionString": ucDbConnectionString,
        "UC_isAdminUser": ucIsAdminUser,
      };
}

class ExamMaster {
  DateTime examDate;
  DateTime submissionDate;
  String examDateString;
  String submissionDateString;

  ExamMaster({
    required this.examDate,
    required this.submissionDate,
    required this.examDateString,
    required this.submissionDateString,
  });

  ExamMaster copyWith({
    DateTime? examDate,
    DateTime? submissionDate,
    String? examDateString,
    String? submissionDateString,
  }) =>
      ExamMaster(
        examDate: examDate ?? this.examDate,
        submissionDate: submissionDate ?? this.submissionDate,
        examDateString: examDateString ?? this.examDateString,
        submissionDateString: submissionDateString ?? this.submissionDateString,
      );

  factory ExamMaster.fromJson(Map<String, dynamic> json) => ExamMaster(
        examDate: DateTime.parse(json["ExamDate"]),
        submissionDate: DateTime.parse(json["SubmissionDate"]),
        examDateString: json["ExamDateString"],
        submissionDateString: json["SubmissionDateString"],
      );

  Map<String, dynamic> toJson() => {
        "ExamDate": examDate.toIso8601String(),
        "SubmissionDate": submissionDate.toIso8601String(),
        "ExamDateString": examDateString,
        "SubmissionDateString": submissionDateString,
      };
}

class GradePointList {
  int gradePointId;
  String name;
  dynamic remarks;
  double fromMarks;
  double toMarks;
  int schoolId;
  int isShowRemarksOnReports;
  bool isDeleted;
  dynamic ucUser;
  int ucLoginUserId;
  dynamic ucUserFullName;
  dynamic ucEntityCode;
  int ucEntityId;
  int ucSchoolId;
  int ucPrivilegeId;
  int ucIsAllowed;
  int ucMessageId;
  dynamic ucMessage;
  dynamic ucCompanyName;
  dynamic ucDbConnectionString;
  bool ucIsAdminUser;

  GradePointList({
    required this.gradePointId,
    required this.name,
    required this.remarks,
    required this.fromMarks,
    required this.toMarks,
    required this.schoolId,
    required this.isShowRemarksOnReports,
    required this.isDeleted,
    required this.ucUser,
    required this.ucLoginUserId,
    required this.ucUserFullName,
    required this.ucEntityCode,
    required this.ucEntityId,
    required this.ucSchoolId,
    required this.ucPrivilegeId,
    required this.ucIsAllowed,
    required this.ucMessageId,
    required this.ucMessage,
    required this.ucCompanyName,
    required this.ucDbConnectionString,
    required this.ucIsAdminUser,
  });

  GradePointList copyWith({
    int? gradePointId,
    String? name,
    dynamic remarks,
    double? fromMarks,
    double? toMarks,
    int? schoolId,
    int? isShowRemarksOnReports,
    bool? isDeleted,
    dynamic ucUser,
    int? ucLoginUserId,
    dynamic ucUserFullName,
    dynamic ucEntityCode,
    int? ucEntityId,
    int? ucSchoolId,
    int? ucPrivilegeId,
    int? ucIsAllowed,
    int? ucMessageId,
    dynamic ucMessage,
    dynamic ucCompanyName,
    dynamic ucDbConnectionString,
    bool? ucIsAdminUser,
  }) =>
      GradePointList(
        gradePointId: gradePointId ?? this.gradePointId,
        name: name ?? this.name,
        remarks: remarks ?? this.remarks,
        fromMarks: fromMarks ?? this.fromMarks,
        toMarks: toMarks ?? this.toMarks,
        schoolId: schoolId ?? this.schoolId,
        isShowRemarksOnReports:
            isShowRemarksOnReports ?? this.isShowRemarksOnReports,
        isDeleted: isDeleted ?? this.isDeleted,
        ucUser: ucUser ?? this.ucUser,
        ucLoginUserId: ucLoginUserId ?? this.ucLoginUserId,
        ucUserFullName: ucUserFullName ?? this.ucUserFullName,
        ucEntityCode: ucEntityCode ?? this.ucEntityCode,
        ucEntityId: ucEntityId ?? this.ucEntityId,
        ucSchoolId: ucSchoolId ?? this.ucSchoolId,
        ucPrivilegeId: ucPrivilegeId ?? this.ucPrivilegeId,
        ucIsAllowed: ucIsAllowed ?? this.ucIsAllowed,
        ucMessageId: ucMessageId ?? this.ucMessageId,
        ucMessage: ucMessage ?? this.ucMessage,
        ucCompanyName: ucCompanyName ?? this.ucCompanyName,
        ucDbConnectionString: ucDbConnectionString ?? this.ucDbConnectionString,
        ucIsAdminUser: ucIsAdminUser ?? this.ucIsAdminUser,
      );

  factory GradePointList.fromJson(Map<String, dynamic> json) => GradePointList(
        gradePointId: json["GradePointId"],
        name: json["Name"],
        remarks: json["Remarks"],
        fromMarks: json["FromMarks"]?.toDouble(),
        toMarks: json["ToMarks"],
        schoolId: json["SchoolId"],
        isShowRemarksOnReports: json["IsShowRemarksOnReports"],
        isDeleted: json["isDeleted"],
        ucUser: json["UC_User"],
        ucLoginUserId: json["UC_LoginUserId"],
        ucUserFullName: json["UC_UserFullName"],
        ucEntityCode: json["UC_EntityCode"],
        ucEntityId: json["UC_EntityId"],
        ucSchoolId: json["UC_SchoolId"],
        ucPrivilegeId: json["UC_PrivilegeId"],
        ucIsAllowed: json["UC_isAllowed"],
        ucMessageId: json["UC_MessageId"],
        ucMessage: json["UC_Message"],
        ucCompanyName: json["UC_CompanyName"],
        ucDbConnectionString: json["UC_DBConnectionString"],
        ucIsAdminUser: json["UC_isAdminUser"],
      );

  Map<String, dynamic> toJson() => {
        "GradePointId": gradePointId,
        "Name": name,
        "Remarks": remarks,
        "FromMarks": fromMarks,
        "ToMarks": toMarks,
        "SchoolId": schoolId,
        "IsShowRemarksOnReports": isShowRemarksOnReports,
        "isDeleted": isDeleted,
        "UC_User": ucUser,
        "UC_LoginUserId": ucLoginUserId,
        "UC_UserFullName": ucUserFullName,
        "UC_EntityCode": ucEntityCode,
        "UC_EntityId": ucEntityId,
        "UC_SchoolId": ucSchoolId,
        "UC_PrivilegeId": ucPrivilegeId,
        "UC_isAllowed": ucIsAllowed,
        "UC_MessageId": ucMessageId,
        "UC_Message": ucMessage,
        "UC_CompanyName": ucCompanyName,
        "UC_DBConnectionString": ucDbConnectionString,
        "UC_isAdminUser": ucIsAdminUser,
      };
}
