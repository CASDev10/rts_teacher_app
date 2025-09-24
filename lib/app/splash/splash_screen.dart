import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/components/base_scaffold.dart';
import 'package:rts/module/kgs_teacher_module/home/pages/home_screen.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/pages/kgs_teacher_login_screen.dart';

import '../../config/routes/nav_router.dart';
import '../../constants/app_colors.dart';
import 'splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.whiteColor,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    return BlocProvider(
      create: (context) => SplashCubit()..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state == SplashState.authenticated) {
            NavRouter.pushReplacement(context, HomeScreen());
          } else if (state == SplashState.unauthenticated) {
            NavRouter.pushReplacement(context, const LoginScreen());
          }
        },
        child: BaseScaffold(
          hMargin: 0,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/png/thinking_school_logo.png",
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
