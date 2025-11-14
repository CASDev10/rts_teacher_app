import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rts/components/base_scaffold.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/diary_list_response.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/models/get_diary_input.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/widgets/diary_expansion_tile.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/repo/auth_repository.dart';

import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_dropdown.dart';
import '../../../../components/loading_indicator.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../utils/display/display_utils.dart';
import '../../class_section/cubit/classes_cubit/classes_cubit.dart';
import '../../class_section/cubit/sections_cubit/sections_cubit.dart';
import '../../class_section/model/classes_model.dart';
import '../../class_section/model/sections_model.dart';
import '../../student_result/widgets/dropdown_place_holder.dart';
import '../../student_result/widgets/student_result_date_picker.dart';
import '../cubit/diary_list_cubit/diary_list_cubit.dart';
import '../cubit/diary_list_cubit/diary_list_state.dart';

class TeacherDiary extends StatelessWidget {
  const TeacherDiary({super.key});

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
    ], child: TeacherDiaryView());
  }
}

class TeacherDiaryView extends StatefulWidget {
  const TeacherDiaryView({super.key});

  @override
  State<TeacherDiaryView> createState() => _TeacherDiaryViewState();
}

class _TeacherDiaryViewState extends State<TeacherDiaryView> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  Section? selectedSection;
  Class? selectedClass;
  AuthRepository _authRepository = sl<AuthRepository>();
  final int _next = 10;
  int offset = 0;

  returnOffset() {
    offset += _next;
    return offset;
  }

  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        GetDiaryInput input = GetDiaryInput(
            ucSchoolId: _authRepository.user.schoolId!,
            ucLoginUserId: _authRepository.user.userId,
            dateFrom: fromDateController.text,
            dateTo: toDateController.text,
            classIdFk: selectedClass!.classId,
            sectionIdFk: selectedSection!.sectionId,
            offSet: returnOffset(),
            next: _next);
        Future.wait([
          context.read<DiaryListCubit>().fetchDiaryList(input, loadMore: true)
        ]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: const CustomAppbar(
          'Diary Work',
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
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AddResultDatePicker(
                      stringFunction: (v) {
                        setState(() {
                          fromDateController.text = v;
                        });
                      },
                      hintText: 'From Date',
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: AddResultDatePicker(
                      stringFunction: (v) {
                        setState(() {
                          toDateController.text = v;
                        });
                      },
                      hintText: 'To Date',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              BlocBuilder<ClassesCubit, ClassesState>(
                builder: (context, state) {
                  return GeneralCustomDropDown(
                    allPadding: 0,
                    horizontalPadding: 15,
                    isOutline: false,
                    hintColor: AppColors.primaryGreen,
                    iconColor: AppColors.primaryGreen,
                    suffixIconPath: '',
                    displayField: (v) => v.className,
                    hint: "Select Class",
                    items: state.classes,
                    onSelect: (v) {
                      setState(() {
                        selectedClass = v;
                        selectedSection = null;
                      });
                      context
                          .read<SectionsCubit>()
                          .fetchSections(v.classId.toString());
                    },
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              BlocConsumer<SectionsCubit, SectionsState>(
                listener: (context, sectionStatus) {
                  if (sectionStatus.sectionsStatus == SectionsStatus.loading) {
                    DisplayUtils.showLoader();
                  } else if (sectionStatus.sectionsStatus ==
                      SectionsStatus.success) {
                    DisplayUtils.removeLoader();
                  } else if (sectionStatus.sectionsStatus ==
                      SectionsStatus.failure) {
                    DisplayUtils.removeLoader();
                    DisplayUtils.showToast(
                        context, sectionStatus.failure.message);
                  }
                },
                builder: (context, sectionState) {
                  return GestureDetector(
                    onTap: selectedSection == null
                        ? () {
                            DisplayUtils.showToast(
                                context, "Please select Class First");
                          }
                        : null,
                    child: selectedSection != null
                        ? DropdownPlaceHolder(
                            name: selectedSection != null
                                ? selectedSection!.sectionName
                                : "Select Section",
                          )
                        : GeneralCustomDropDown(
                            allPadding: 0,
                            horizontalPadding: 15,
                            isOutline: false,
                            hintColor: AppColors.primaryGreen,
                            iconColor: AppColors.primaryGreen,
                            suffixIconPath: '',
                             displayField: (v) =>
                                      "${v.sectionName} (${v.sessionName})",
                            hint: "Select Section",
                            items: sectionState.sections,
                            onSelect: (v) {
                              setState(() {
                                selectedSection = v;
                              });
                            },
                          ),
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              BlocBuilder<DiaryListCubit, DiaryListState>(
                  builder: (context, state) {
                if (state.diaryListStatus == DiaryListStatus.loading) {
                  return Expanded(
                    child: Center(
                      child: LoadingIndicator(),
                    ),
                  );
                }
                if (state.diaryListStatus == DiaryListStatus.success ||
                    state.diaryListStatus == DiaryListStatus.loadMore) {
                  return Expanded(
                      child: ListView.separated(
                    controller: _scrollController,
                    itemCount: state.diaryList.length,
                    itemBuilder: (context, index) {
                      DiaryModel model = state.diaryList[index];
                      return DiaryExpansionTile(
                        model: model,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 12.0,
                      );
                    },
                  ));
                }
                if (state.diaryListStatus == DiaryListStatus.failure) {
                  return Center(
                    child: Text(state.failure.message),
                  );
                }
                return Expanded(child: SizedBox());
              }),
              const SizedBox(
                height: 12,
              ),
              CustomButton(
                height: 50,
                borderRadius: 15,
                onPressed: () async {
                  offset = 0;
                  GetDiaryInput input = GetDiaryInput(
                      ucSchoolId: _authRepository.user.schoolId!,
                      ucLoginUserId: _authRepository.user.userId,
                      dateFrom: fromDateController.text,
                      dateTo: toDateController.text,
                      classIdFk: selectedClass!.classId,
                      sectionIdFk: selectedSection!.sectionId,
                      offSet: offset,
                      next: _next);
                  print(input.toJson());
                  await context.read<DiaryListCubit>().fetchDiaryList(input);
                },
                title: 'Get Diary',
                isEnabled: true,
              ),
            ],
          ),
        ));
  }
}
