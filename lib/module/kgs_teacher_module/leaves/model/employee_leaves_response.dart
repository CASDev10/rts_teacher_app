import 'dart:convert';

EmployeeLeavesResponse employeeLeavesResponseFromJson(dynamic json) =>
    EmployeeLeavesResponse.fromJson(json);

String employeeLeavesResponseToJson(EmployeeLeavesResponse data) =>
    json.encode(data.toJson());

class EmployeeLeavesResponse {
  String result;
  String message;
  List<EmployeeLeaveModel> data;

  EmployeeLeavesResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  EmployeeLeavesResponse copyWith({
    String? result,
    String? message,
    List<EmployeeLeaveModel>? data,
  }) =>
      EmployeeLeavesResponse(
        result: result ?? this.result,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory EmployeeLeavesResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeLeavesResponse(
        result: json["result"],
        message: json["message"],
        data: List<EmployeeLeaveModel>.from(
            json["data"].map((x) => EmployeeLeaveModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EmployeeLeaveModel {
  int id;
  int empId;
  DateTime fromDate;
  String fromDateString;
  DateTime toDate;
  String toDateString;
  String reason;
  int days;
  int entityLeaveTypeId;
  String entityLeaveType;
  bool isDeleted;
  int createdBy;
  DateTime createdDate;
  String createdDateString;
  dynamic employeeName;
  dynamic departmentName;
  dynamic desginationName;
  bool approved;
  dynamic shift;
  int waitingForApproval;
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

  EmployeeLeaveModel({
    required this.id,
    required this.empId,
    required this.fromDate,
    required this.fromDateString,
    required this.toDate,
    required this.toDateString,
    required this.reason,
    required this.days,
    required this.entityLeaveTypeId,
    required this.entityLeaveType,
    required this.isDeleted,
    required this.createdBy,
    required this.createdDate,
    required this.createdDateString,
    required this.employeeName,
    required this.departmentName,
    required this.desginationName,
    required this.approved,
    required this.shift,
    required this.waitingForApproval,
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

  EmployeeLeaveModel copyWith({
    int? id,
    int? empId,
    DateTime? fromDate,
    String? fromDateString,
    DateTime? toDate,
    String? toDateString,
    String? reason,
    int? days,
    int? entityLeaveTypeId,
    String? entityLeaveType,
    bool? isDeleted,
    int? createdBy,
    DateTime? createdDate,
    String? createdDateString,
    dynamic employeeName,
    dynamic departmentName,
    dynamic desginationName,
    bool? approved,
    dynamic shift,
    int? waitingForApproval,
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
      EmployeeLeaveModel(
        id: id ?? this.id,
        empId: empId ?? this.empId,
        fromDate: fromDate ?? this.fromDate,
        fromDateString: fromDateString ?? this.fromDateString,
        toDate: toDate ?? this.toDate,
        toDateString: toDateString ?? this.toDateString,
        reason: reason ?? this.reason,
        days: days ?? this.days,
        entityLeaveTypeId: entityLeaveTypeId ?? this.entityLeaveTypeId,
        entityLeaveType: entityLeaveType ?? this.entityLeaveType,
        isDeleted: isDeleted ?? this.isDeleted,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        createdDateString: createdDateString ?? this.createdDateString,
        employeeName: employeeName ?? this.employeeName,
        departmentName: departmentName ?? this.departmentName,
        desginationName: desginationName ?? this.desginationName,
        approved: approved ?? this.approved,
        shift: shift ?? this.shift,
        waitingForApproval: waitingForApproval ?? this.waitingForApproval,
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

  factory EmployeeLeaveModel.fromJson(Map<String, dynamic> json) =>
      EmployeeLeaveModel(
        id: json["ID"],
        empId: json["EmpId"],
        fromDate: DateTime.parse(json["FromDate"]),
        fromDateString: json["FromDateString"],
        toDate: DateTime.parse(json["ToDate"]),
        toDateString: json["ToDateString"],
        reason: json["Reason"],
        days: json["Days"],
        entityLeaveTypeId: json["EntityLeaveTypeId"],
        entityLeaveType: json["EntityLeaveType"],
        isDeleted: json["IsDeleted"],
        createdBy: json["CreatedBy"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        createdDateString: json["CreatedDateString"],
        employeeName: json["EmployeeName"],
        departmentName: json["DepartmentName"],
        desginationName: json["DesginationName"],
        approved: json["Approved"],
        shift: json["Shift"],
        waitingForApproval: json["WaitingForApproval"],
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
        "ID": id,
        "EmpId": empId,
        "FromDate": fromDate.toIso8601String(),
        "FromDateString": fromDateString,
        "ToDate": toDate.toIso8601String(),
        "ToDateString": toDateString,
        "Reason": reason,
        "Days": days,
        "EntityLeaveTypeId": entityLeaveTypeId,
        "EntityLeaveType": entityLeaveType,
        "IsDeleted": isDeleted,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate.toIso8601String(),
        "CreatedDateString": createdDateString,
        "EmployeeName": employeeName,
        "DepartmentName": departmentName,
        "DesginationName": desginationName,
        "Approved": approved,
        "Shift": shift,
        "WaitingForApproval": waitingForApproval,
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
