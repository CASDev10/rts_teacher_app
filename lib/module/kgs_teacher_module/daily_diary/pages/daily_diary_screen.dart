import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rts/components/base_scaffold.dart';
import 'package:rts/components/custom_appbar.dart';
import 'package:rts/components/custom_button.dart';
import 'package:rts/config/config.dart';
import 'package:rts/constants/app_colors.dart';
import 'package:rts/module/kgs_teacher_module/class_section/model/classes_model.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/cubit/diary_list_cubit/diary_list_cubit.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/pages/assignment_view.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/pages/diary_view.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/repo/auth_repository.dart';
import 'package:rts/utils/extensions/extended_string.dart';

import '../../../../constants/keys.dart';
import '../../../../core/di/service_locator.dart';
import '../../class_section/cubit/classes_cubit/classes_cubit.dart';
import '../../class_section/cubit/sections_cubit/sections_cubit.dart';
import '../../class_section/model/sections_model.dart';
import '../../home/repo/home_repo.dart';
import 'add_daily_diary_screen.dart';

class DailyDiaryScreen extends StatefulWidget {
  const DailyDiaryScreen({super.key});

  @override
  State<DailyDiaryScreen> createState() => _DailyDiaryScreenState();
}

class _DailyDiaryScreenState extends State<DailyDiaryScreen> {
  AuthRepository _authRepository = sl<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ClassesCubit(sl())..fetchClasses(),
      ),
      BlocProvider(
        create: (context) => SectionsCubit(sl()),
      ),
      BlocProvider(
        create: (context) => DiaryListCubit(sl()),
      )
    ], child: DailyDiaryScreenView());
  }
}

class DailyDiaryScreenView extends StatefulWidget {
  @override
  State<DailyDiaryScreenView> createState() => _DailyDiaryScreenViewState();
}

class _DailyDiaryScreenViewState extends State<DailyDiaryScreenView> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  Section? selectedSection;
  Class? selectedClass;

  String shortenText(String text, [int maxLength = 30]) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
  }

  AuthRepository _authRepository = sl<AuthRepository>();
  List<String> userPrivileges = [];
  HomeRepository homeRepository = sl<HomeRepository>();

  @override
  void initState() {
    super.initState();
    if (_authRepository.user.userPrivileges?.isNotEmpty == true) {
      userPrivileges =
          _authRepository.user.userPrivileges.toString().split(',');
    }
  }

  void _gotoAddDiary() {
    if (userPrivileges.isNotEmpty) {
      bool exists = false;
      for (var i = 0; i < userPrivileges.length; i++) {
        if (userPrivileges[i].toInt() == StorageKeys.addDiaryId) {
          exists = true;
          break;
        } else {
          exists = false;
        }
      }
      if (exists) {
        NavRouter.push(context, AddDailyDiaryScreen());
      } else {
        Fluttertoast.showToast(msg: "You are not allowed to add diary!");
      }
    } else {
      Fluttertoast.showToast(msg: "You are not allowed to add diary!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const CustomAppbar(
        'Diary / Assignment',
        centerTitle: true,
      ),
      backgroundColor: AppColors.primaryGreen,
      hMargin: 0,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20) +
            const EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              CustomButton(
                height: 50,
                borderRadius: 15,
                onPressed: () {
                  NavRouter.push(context, TeacherDiary());
                },
                title: 'Check Diary',
                isEnabled: true,
              ),
              SizedBox(
                height: 12.0,
              ),
              CustomButton(
                height: 50,
                borderRadius: 15,
                onPressed: () {
                  NavRouter.push(context, TeacherAssignment());
                },
                title: 'Check Assignment',
                isEnabled: true,
              ),
              SizedBox(
                height: 12.0,
              ),
              CustomButton(
                height: 50,
                borderRadius: 15,
                onPressed: () {
                  _gotoAddDiary();
                },
                title: 'Add Diary Work',
                isEnabled: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
