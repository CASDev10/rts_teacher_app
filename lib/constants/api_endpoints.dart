class Endpoints {
  static const String login = '/AuthenticateEmployee';
  static const String signup = '/EmployeeRegestrtion';
  static const String getUserSchools = '/GetUserSchools';
  static const String getClassesForAttendance =
      '/GetClassesOfSchoolForAttendance';
  static const String getSectionsForAttendance =
      '/GetSectionsOfClassForAttendance';
  static const String getGetSectionStudentList = '/GetSectionStudentList';
  static const String getSubjectOfClass = '/GetSubjectOfClass';
  static const String getDiaryList = '/GetDiaryList';
  static const String createUpdateAwardList = '/CreateUpdateAwardList';
  static const String getEvaluationRemarksList = '/GetEvaluationRemarksList';
  static const String getEvaluationTypes = '/GetEvaluationTypes';
  static const String getEvaluation = '/GetEvaluation';
  static const String getSectionStudentListForResult =
      '/GetSectionStudentListForResult';
  static const String addEvaluationRemarks = '/AddEvaluationRemarks';

  static const String getEmployeeAttendance = '/GetEmployeeAttendance';
  static const String getEmployeeAssignedGrades = '/GetEmployeeAssignedGrades';
  static const String getEmployeeLeaveBalance = '/GetEmployeeLeaveBalance';
  static const String getEmployeeLeavesByEmpId = '/GetEmployeeLeavesByEmpId';
  static const String addUpdateKinderGartenTermOneResultPrep =
      '/AddUpdateKinderGartenTermOneResultPrep';
  static const String insertEmployeeLeave = '/InsertEmployeeLeave';
  static const String deleteLeave = '/Delete';
  static const String getSchoolClassesByGradeId = '/GetSchoolClassesByGradeId';

  static const String getClassSections = '/GetClassSections';
  static const String getEvaluationAreas = '/GetEvaluationAreas';
  static const String getStudentEvaluationAreas = '/GetStudentEvaluationAreas';
  static const String addEvaluationLogBook = '/AddEvaluationLogBook';
  static const String addDiary = '/AddDiary';
  static const String addSchoolAttendance = '/AddSchoolAttendance';
  static const String getMobileAppConfig = '/GetMobileAppConfig';
  static const String forgetPassword = '/UpdateForgetMobilePassword';
  static const String getClassesForExam = '/GetClassesOfSchoolForExam';
  static const String getSectionsForExam = '/GetClassSectionsForExam';
  static const String importExamResultData = '/ImportExamResultData';
  static const String addObservationLevel = '/AddObservationLevel';
  static const String updateObservationLevel = '/UpdateObservationLevel';
  static const String deleteObservationLevel = '/DeleteObservationLevel';
  static const String getObservationLevelList = '/GetObservationLevelList';
  static const String getObservationAreas = '/GetObservationAreas';
  static const String getObservationAreaRemarksList =
      '/GetObservationAreaRemarksList';
  static const String addObservationAreaRemarks = '/AddObservationAreaRemarks';
  static const String deleteObservationAreaRemarks =
      '/DeleteObservationAreaRemarks';
  static const String updateObservationAreaRemarks =
      '/UpdateObservationAreaRemarks';
  static const String getEmployeeById = '/GetEmployeeById';
  static const String saveTeacherObservation = '/SaveTeacherObservation';
  static const String getObservationReport = '/GetObservationReport';
  static const String getParentFile = '/GetParentFile';
  static const String uploadTeacherFile = '/UploadTeacherFile';
}
