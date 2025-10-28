import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/cubit/forget_password_cubit/forget_password_cubit.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/cubit/kgs_teacher_login_cubit/kgs_teacher_login_cubit.dart';
import 'package:rts/module/kgs_teacher_module/teacher_observation/cubit/observation_level_cubit/observation_level_cubit.dart';

import 'app.dart';
import 'config/flavors/flavors.dart';
import 'core/app_bloc_observer.dart';
import 'core/di/service_locator.dart';
import 'core/initializer/init_app.dart';
import 'module/kgs_teacher_module/evaluation/cubit/add_evaluation_remarks_cubit/add_evaluation_remarks_cubit.dart';
import 'module/kgs_teacher_module/evaluation/cubit/evaluation_areas_cubit/evaluation_areas_cubit.dart';
import 'module/kgs_teacher_module/kgs_teacher_auth/cubit/kgs_teacher_auth_cubit/kgs_teacher_auth_cubit.dart';
import 'module/kgs_teacher_module/kgs_teacher_auth/cubit/kgs_teacher_signup_cubit/kgs_teacher_signup_cubit.dart';
import 'module/kgs_teacher_module/leaves/cubit/leaves_cubit.dart';
import 'module/kgs_teacher_module/student_evaluation/cubit/student_evaluation_cubit.dart';
import 'module/kgs_teacher_module/teacher_observation/cubit/add_update_delete_level_cubit/add_update_delete_level_cubit.dart';
import 'module/kgs_teacher_module/teacher_observation/cubit/employee_detail_cubit/employee_detail_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initApp(AppEnv.dev);
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit(sl())),
        BlocProvider<TeacherLeaveCubit>(
          create: (context) => TeacherLeaveCubit(sl()),
        ),
        BlocProvider<LoginCubit>(create: (_) => LoginCubit(sl())),
        BlocProvider<SignupCubit>(create: (_) => SignupCubit(sl())),
        BlocProvider<ForgetPasswordCubit>(
          create: (_) => ForgetPasswordCubit(sl()),
        ),
        BlocProvider<AddEvaluationRemarksCubit>(
          create: (_) => AddEvaluationRemarksCubit(sl()),
        ),
        BlocProvider<StudentsEvaluationCubit>(
          create: (_) => StudentsEvaluationCubit(sl()),
        ),
        BlocProvider<EvaluationAreasCubit>(
          create: (_) => EvaluationAreasCubit(sl()),
        ),
        BlocProvider<ObservationLevelCubit>(
          create: (_) => ObservationLevelCubit(sl()),
        ),
        BlocProvider<AddUpdateDeleteLevelCubit>(
          create: (_) => AddUpdateDeleteLevelCubit(sl()),
        ),
        BlocProvider<EmployeeDetailCubit>(
          create: (_) => EmployeeDetailCubit(sl()),
        ),
      ],
      child: const App(),
    ),
  );
}
