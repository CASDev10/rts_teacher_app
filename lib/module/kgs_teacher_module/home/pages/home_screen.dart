import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rts/components/base_scaffold.dart';
import 'package:rts/components/custom_button.dart';
import 'package:rts/config/routes/nav_router.dart';
import 'package:rts/constants/app_colors.dart';
import 'package:rts/constants/keys.dart';
import 'package:rts/module/kgs_teacher_module/evaluation/models/student_evaluation_areas_input.dart';
import 'package:rts/module/kgs_teacher_module/evaluation/pages/student_evaluation_screen.dart';
import 'package:rts/module/kgs_teacher_module/home/app_config_cubit/app_config_cubit.dart';
import 'package:rts/module/kgs_teacher_module/home/app_config_cubit/app_config_state.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/cubit/kgs_teacher_auth_cubit/kgs_teacher_auth_cubit.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/pages/kgs_teacher_login_screen.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/repo/auth_repository.dart';
import 'package:rts/utils/display/dialogs/dialog_utils.dart';
import 'package:rts/utils/extensions/extended_string.dart';

import '../../../../components/custom_textfield.dart';
import '../../../../components/loading_indicator.dart';
import '../../../../components/text_view.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../utils/display/display_utils.dart';
import '../../attendance_history/pages/attendance_history_screen.dart';
import '../../class_section/pages/class_section_screen.dart';
import '../../daily_diary/pages/daily_diary_screen.dart';
import '../../evaluation/cubit/evaluation_areas_cubit/evaluation_areas_cubit.dart';
import '../../evaluation/cubit/evaluation_areas_cubit/evaluation_areas_state.dart';
import '../../leaves/pages/leaves_screen.dart';
import '../../parent_files/pages/parent_files_screen.dart';
import '../../student_evaluation/pages/student_evaluation_screen.dart';
import '../../student_result/pages/student_result_screen.dart';
import '../repo/home_repo.dart';
import '../widgets/all_info_dialogue.dart';
import '../widgets/home_tab_card.dart';
import '../widgets/horizontal_home_divider.dart';
import '../widgets/vertical_home_divider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: AppColors.primaryGreen,
    //   statusBarIconBrightness: Brightness.light,
    //   statusBarBrightness: Brightness.light,
    // ));
    return BlocProvider(
      create: (context) => AppConfigCubit(sl())..getAppConfig(),
      child: HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final AuthRepository _repository = sl<AuthRepository>();
  String? dropdownValueCampuses;

  List<String> campusesDropDownItems = [];
  List<String> userPrivileges = [];
  HomeRepository homeRepository = sl<HomeRepository>();
  TextEditingController studentIdTextController = TextEditingController();

  @override
  void initState() {
    debugPrint("${_repository.user.toJson()}");
    super.initState();
    if (_repository.user.userPrivileges?.isNotEmpty == true) {
      userPrivileges = _repository.user.userPrivileges.toString().split(',');
    }
  }

  void _gotoAttendance() {
    if (userPrivileges.isNotEmpty) {
      bool exists = false;
      for (var i = 0; i < userPrivileges.length; i++) {
        if (userPrivileges[i].toInt() == StorageKeys.loadAttendanceId) {
          exists = true;
          break;
        } else {
          exists = false;
        }
      }
      if (exists) {
        NavRouter.push(context, ClassSectionScreen());
      } else {
        Fluttertoast.showToast(msg: "You are not allowed to mark Attendance!");
      }
    } else {
      Fluttertoast.showToast(msg: "You are not allowed to mark Attendance!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      hMargin: 0,
      body: BlocBuilder<AppConfigCubit, AppConfigState>(
        buildWhen: (current, previous) => current != previous,
        builder: (context, state) {
          if (state.appConfigStatus == AppConfigStatus.loading) {
            return const Center(child: LoadingIndicator());
          } else if (state.appConfigStatus == AppConfigStatus.success) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 351,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/png/bg_home_top_view.png",
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AllInfoDialogue();
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/svg/ic_profile.svg",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextView(
                                        _repository.user.fullName.toString(),
                                        textAlign: TextAlign.left,
                                        fontSize: 15,
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      TextView(
                                        _repository.user.schoolName.toString(),
                                        textAlign: TextAlign.left,
                                        fontSize: 11,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.logout,
                                    color: AppColors.whiteColor,
                                  ),
                                  onPressed: () {
                                    DialogUtils.confirmationDialog(
                                      context: context,
                                      title: 'Confirmation!',
                                      content:
                                          'Are you sure you want to logout from the app?',
                                      onPressYes: () {
                                        context.read<AuthCubit>().logout();
                                        NavRouter.pushAndRemoveUntil(
                                          context,
                                          const LoginScreen(),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                height: 150,
                                "assets/images/png/rubrics_logo.png",
                                width: 150,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextView(
                        "Our services".toUpperCase(),
                        color: AppColors.primaryGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: HomeTabCard(
                            onTap: () {
                              _gotoAttendance();
                            },
                            isSvg: false,
                            show: true,
                            name: "Attendance",
                            imagePath: "assets/images/png/attendance.png",
                          ),
                        ),
                        VerticalHomeDivider(),
                        Expanded(
                          child: HomeTabCard(
                            show: true,
                            onTap: () {
                              NavRouter.push(context, DailyDiaryScreen());
                            },
                            name: "Daily Diary",
                            imagePath: "assets/images/svg/ic_daily_diary.svg",
                          ),
                        ),
                      ],
                    ),
                    HorizontalHomeDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: HomeTabCard(
                            show: true,
                            onTap: () {
                              NavRouter.push(context, const LeavesScreen());
                            },
                            name: "Teacher Leaves",
                            imagePath: "assets/images/svg/onboarding2.svg",
                          ),
                        ),
                        VerticalHomeDivider(),
                        Expanded(
                          child: HomeTabCard(
                            show: true,
                            onTap: () {
                              NavRouter.push(
                                context,
                                const ParentFilesScreen(),
                              );
                            },
                            name: "Parent Files",
                            imagePath:
                                "assets/images/svg/student_assignment.svg",
                          ),
                        ),
                      ],
                    ),
                    HorizontalHomeDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: HomeTabCard(
                            show: true,
                            imagePath: "assets/images/svg/roll-call.svg",
                            name: "Attendance History",
                            onTap: () {
                              NavRouter.push(
                                context,
                                const AttendanceHistoryScreen(),
                              );
                            },
                          ),
                        ),
                        VerticalHomeDivider(),
                        Expanded(
                          child: HomeTabCard(
                            show: true,
                            onTap: () {
                              NavRouter.push(
                                context,
                                const StudentResultScreen(),
                              );
                            },
                            name: "Exam Result",
                            imagePath: "assets/images/svg/ic_exam_result.svg",
                          ),
                        ),
                      ],
                    ),
                    HorizontalHomeDivider(),
                    HomeTabCard(
                      show: true,
                      onTap: () {
                        NavRouter.push(context, const StudentEvaluationPage());
                      },
                      name: "Student Evaluation",
                      imagePath:
                          "assets/images/svg/ic_student_evaluation_tab.svg",
                    ),
                  ],
                ),
              ),
            );
          } else if (state.appConfigStatus == AppConfigStatus.failure) {
            return Center(child: Text(state.failure.message));
          }

          return const SizedBox();
        },
      ),
    );
  }

  void showStudentEvaluationAreas(
    BuildContext context, {
    void Function(bool val)? onButtonPressYes,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ), //this right here
          child: SizedBox(
            height: 240,
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextView(
                    'Enter Student ID',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(height: 1, color: AppColors.dividerColor),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomTextField(
                    hintText: 'Student ID',
                    height: 50,
                    bottomMargin: 0,
                    controller: studentIdTextController,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    inputType: TextInputType.number,
                    fillColor: AppColors.lightGreyColor,
                    hintColor: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CustomButton(
                          isOutlinedButton: true,
                          onPressed: () {
                            NavRouter.pop(context);
                          },
                          width: 80,
                          title: 'Close',
                          fontSize: 14,
                          height: 45,
                          textColor: AppColors.primaryGreen,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child:
                            BlocConsumer<
                              EvaluationAreasCubit,
                              EvaluationAreasState
                            >(
                              listener: (context, evaluationAreasState) {
                                if (evaluationAreasState
                                        .evaluationAreasStatus ==
                                    EvaluationAreasStatus.loading) {
                                  DisplayUtils.showLoader();
                                } else if (evaluationAreasState
                                        .evaluationAreasStatus ==
                                    EvaluationAreasStatus.success) {
                                  DisplayUtils.removeLoader();
                                  NavRouter.pop(context);
                                  NavRouter.push(
                                    context,
                                    StudentEvaluationScreen(
                                      studentEvaluationAreaModel:
                                          evaluationAreasState.evaluationAreas!,
                                      studentId: studentIdTextController.text
                                          .trim(),
                                    ),
                                  );
                                } else if (evaluationAreasState
                                        .evaluationAreasStatus ==
                                    EvaluationAreasStatus.failure) {
                                  DisplayUtils.removeLoader();
                                  DisplayUtils.showToast(
                                    context,
                                    evaluationAreasState.failure.message,
                                  );
                                }
                              },
                              builder: (context, state) {
                                return CustomButton(
                                  onPressed: () {
                                    if (studentIdTextController.text
                                        .trim()
                                        .isNotEmpty) {
                                      context
                                          .read<EvaluationAreasCubit>()
                                          .fetchEvaluationAreas(
                                            StudentEvaluationAreasInput(
                                              studentIdfK:
                                                  studentIdTextController.text
                                                      .trim()
                                                      .toString(),
                                            ),
                                          );
                                    } else {
                                      DisplayUtils.showToast(
                                        context,
                                        "Enter student ID",
                                      );
                                    }
                                  },
                                  width: 80,
                                  fontSize: 14,
                                  title: 'Submit',
                                  height: 45,
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
