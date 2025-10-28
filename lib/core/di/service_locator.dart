import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/repo/diary_repo.dart';
import 'package:rts/module/kgs_teacher_module/evaluation/repo/evaluation_repo.dart';
import 'package:rts/module/kgs_teacher_module/exam_result/repo/exam_result_repo.dart';
import 'package:rts/module/kgs_teacher_module/home/repo/home_repo.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/repo/user_schools_repo.dart';
import 'package:rts/module/kgs_teacher_module/student_result/repo/student_result_repo.dart';
import 'package:rts/module/kgs_teacher_module/students_attendance/repo/attendance_repo.dart';
import 'package:rts/module/kgs_teacher_module/teacher_observation/repo/observation_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/flavors/flavors.dart';
import '../../module/kgs_teacher_module/attendance_history/repo/attendance_history_repo.dart';
import '../../module/kgs_teacher_module/class_section/repo/classes_sections_repo.dart';
import '../../module/kgs_teacher_module/kgs_teacher_auth/repo/auth_repository.dart';
import '../../module/kgs_teacher_module/leaves/repo/leaves_repo.dart';
import '../../module/kgs_teacher_module/student_evaluation/repo/student_evaluation_repository.dart';
import '../core.dart';

final sl = GetIt.instance;

Future<void> initDependencies(AppEnv appEnv) async {
  sl.registerSingleton(Flavors()..initConfig(appEnv));
  sl.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );

  // modules
  sl.registerSingletonWithDependencies<StorageService>(
    () => StorageService(sl()),
    dependsOn: [SharedPreferences],
  );
  sl.registerLazySingleton<NetworkService>(
    () => NetworkService(sl(), dio: Dio()),
  );

  /// ==================== Notifications =========================
  // sl.registerLazySingleton<CloudMessagingApi>(() => CloudMessagingApi());
  // sl.registerLazySingleton<LocalNotificationsApi>(
  //     () => LocalNotificationsApi());

  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl(), sl()));
  sl.registerLazySingleton<UserSchoolsRepository>(
    () => UserSchoolsRepository(),
  );
  sl.registerLazySingleton<LeavesRepository>(() => LeavesRepository());

  sl.registerLazySingleton<AttendanceHistoryRepository>(
    () => AttendanceHistoryRepository(),
  );

  sl.registerLazySingleton<StudentResultRepository>(
    () => StudentResultRepository(),
  );
  sl.registerLazySingleton<ClassesSectionsRepository>(
    () => ClassesSectionsRepository(),
  );
  sl.registerLazySingleton<StudentEvaluationRepository>(
    () => StudentEvaluationRepository(),
  );
  sl.registerLazySingleton<AttendanceRepository>(() => AttendanceRepository());
  sl.registerLazySingleton<DiaryRepository>(() => DiaryRepository());
  sl.registerLazySingleton<HomeRepository>(() => HomeRepository());
  sl.registerLazySingleton<EvaluationRepository>(() => EvaluationRepository());
  sl.registerLazySingleton<ExamResultRepository>(() => ExamResultRepository());
  sl.registerLazySingleton<ObservationRepository>(
    () => ObservationRepository(),
  );
}
