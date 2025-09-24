import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rts/utils/extensions/extended_string.dart';

import '../../../../components/base_scaffold.dart';
import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/loading_indicator.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/keys.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../widgets/helper_function.dart';
import '../../home/repo/home_repo.dart';
import '../../kgs_teacher_auth/repo/auth_repository.dart';
import '../cubit/diary_list_cubit/diary_list_cubit.dart';
import '../cubit/diary_list_cubit/diary_list_state.dart';
import '../models/diary_list_response.dart';
import '../widgets/detail_row_widget.dart';
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
    return BlocProvider(
      create:
          (context) =>
              DiaryListCubit(sl())
                ..fetchDiaryList(_authRepository.user.schoolId.toString()),
      child: DailyDiaryScreenView(),
    );
  }
}

class DailyDiaryScreenView extends StatefulWidget {
  @override
  State<DailyDiaryScreenView> createState() => _DailyDiaryScreenViewState();
}

class _DailyDiaryScreenViewState extends State<DailyDiaryScreenView> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

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
      userPrivileges = _authRepository.user.userPrivileges.toString().split(
        ',',
      );
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
        NavRouter.push(context, AddDailyDiaryScreen()).then((value) {
          context.read<DiaryListCubit>().fetchDiaryList('1');
        });
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
      appBar: const CustomAppbar('Diary Work', centerTitle: true),
      body: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 20) +
            const EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      BlocBuilder<DiaryListCubit, DiaryListState>(
                        builder: (context, state) {
                          if (state.diaryListStatus ==
                              DiaryListStatus.loading) {
                            return Center(child: LoadingIndicator());
                          }
                          if (state.diaryListStatus ==
                              DiaryListStatus.success) {
                            return Column(
                              children: List.generate(state.diaryList.length, (
                                index,
                              ) {
                                DiaryModel model = state.diaryList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    child: ExpansionTile(
                                      shape: RoundedRectangleBorder(),
                                      title: Text(
                                        model.subjectName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      childrenPadding:
                                          EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                          ) +
                                          EdgeInsets.only(bottom: 14.0),
                                      children: [
                                        Divider(thickness: 1.5),
                                        DetailRowWidget(
                                          name: 'Date From',
                                          value: model.dateFromString,
                                        ),
                                        Divider(thickness: 0.7),
                                        DetailRowWidget(
                                          name: 'Date To',
                                          value: model.dateToString,
                                        ),
                                        Divider(thickness: 0.7),
                                        DetailRowWidget(
                                          name: 'Class Name',
                                          value:
                                              "${model.className} - ${model.sectionName}",
                                        ),
                                        Divider(thickness: 0.7),
                                        DetailRowWidget(
                                          name: 'Diary Text',
                                          value: model.text,
                                        ),
                                        Divider(thickness: 0.7),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Download Diary",
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            if (model.logoContent != null ||
                                                model.uploadFilePath != null)
                                              InkWell(
                                                child: Text(
                                                  shortenText(
                                                    model.userFileName,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                onTap: () {
                                                  if (model.logoContent !=
                                                      null) {
                                                    saveBase64ToFile2(
                                                      base64String:
                                                          model.logoContent,
                                                      fileName:
                                                          model.userFileName,
                                                    );
                                                  } else if (model
                                                          .uploadFilePath !=
                                                      null) {
                                                    openUrlInBrowser(
                                                      model.uploadFilePath,
                                                    );
                                                  }
                                                },
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                          }
                          if (state.diaryListStatus ==
                              DiaryListStatus.failure) {
                            return Center(child: Text(state.failure.message));
                          }
                          return SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                height: 50,
                borderRadius: 15,
                onPressed: () {
                  _gotoAddDiary();
                },
                title: 'Add Diary Work',
                isEnabled: true,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.primary,
      hMargin: 0,
    );
  }
}
