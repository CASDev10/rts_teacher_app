import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../components/base_scaffold.dart';
import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_dropdown.dart';
import '../../../../components/custom_textfield.dart';
import '../../../../components/loading_indicator.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../utils/display/dialogs/dialog_utils.dart';
import '../../../../utils/display/display_utils.dart';
import '../../../../widgets/helper_function.dart';
import '../../class_section/cubit/classes_cubit/classes_cubit.dart';
import '../../class_section/cubit/sections_cubit/sections_cubit.dart';
import '../../class_section/model/classes_model.dart';
import '../../class_section/model/sections_model.dart';
import '../../kgs_teacher_auth/repo/auth_repository.dart';
import '../../student_result/widgets/student_result_date_picker.dart';
import '../cubit/add_diary_cubit/add_diary_cubit.dart';
import '../cubit/add_diary_cubit/add_diary_state.dart';
import '../cubit/subject_cubit/subjects_cubit.dart';
import '../models/add_diary_input.dart';
import '../models/class_student_input.dart';
import '../models/diary_description_input.dart';
import '../models/subjects_response.dart';
import '../widgets/select_students_dialogue.dart';

class AddDailyDiaryScreen extends StatefulWidget {
  @override
  State<AddDailyDiaryScreen> createState() => _AddDailyDiaryScreenState();
}

class _AddDailyDiaryScreenState extends State<AddDailyDiaryScreen> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController textBoxController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();
  FilePickerResult? result;
  File? file;
  String selectedStudents = "";

  Future<MultipartFile> changeMulti(File file) async {
    MultipartFile multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: file.path,
    );
    return multipartFile;
  }

  String? dropdownValueClass;
  String? dropdownValueSection;
  String? dropdownValueSubject;
  String? classId;

  String? sectionId;
  String? subjectId;
  List<Section>? sections;
  List<SubjectModel>? subjects;

  AuthRepository authRepository = sl<AuthRepository>();

  DiaryDescriptionInput _onApiHit() {
    DiaryDescriptionInput input = DiaryDescriptionInput(
      dateFrom: fromDateController.text,
      dateTo: toDateController.text,
      classIdFk: int.parse(classId!),
      subjectIdFk: int.parse(subjectId!),
      text: textBoxController.text,
      ucSchoolId: authRepository.user.schoolId.toString(),
      studentIDs: selectedStudents,
      sectionIdFk: int.parse(sectionId!),
      description: textBoxController.text,
      schoold: authRepository.user.schoolId!,
      createdBy: 1,
    );

    print(jsonEncode(input));
    return input;
  }

  AddDiaryInput _onSaveButtonPressed() {
    // DateTime fromDate = DateFormat("dd/MM/yyyy").parse(fromDateController.text);
    // DateTime toDate = DateFormat("dd/MM/yyyy").parse(toDateController.text);
    AddDiaryInput input = AddDiaryInput(
      dateFrom: fromDateController.text,
      // dateFrom: DateFormat("yyyy-MM-dd").format(fromDate),
      // dateTo: DateFormat("yyyy-MM-dd").format(toDate),
      dateTo: toDateController.text,
      sectionIdFk: sectionId.toString(),
      classIdFk: classId.toString(),
      subjectIdFk: subjectId.toString(),
      text: textBoxController.text,
      ucSchoolId: authRepository.user.schoolId.toString(),
      ucLoginUserId: authRepository.user.userId.toString(),
    );
    return input;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClassesCubit(sl())..fetchClasses()),
        BlocProvider(create: (context) => SectionsCubit(sl())),
        BlocProvider(create: (context) => SubjectsCubit(sl())),
        BlocProvider(create: (context) => AddDiaryCubit(sl())),
      ],
      child: BaseScaffold(
        appBar: const CustomAppbar('Add Diary Work', centerTitle: true),
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
          child: BlocBuilder<ClassesCubit, ClassesState>(
            builder: (context, classState) {
              if (classState.classesStatus == ClassesStatus.loading) {
                return Center(child: LoadingIndicator());
              }
              if (classState.classesStatus == ClassesStatus.success) {
                return ListView(
                  children: [
                    const SizedBox(height: 12),
                    AddResultDatePicker(
                      stringFunction: (v) {
                        setState(() {
                          fromDateController.text = v;
                        });
                      },
                      hintText: 'From Date',
                    ),
                    SizedBox(height: 12.0),
                    AddResultDatePicker(
                      stringFunction: (v) {
                        setState(() {
                          toDateController.text = v;
                        });
                      },
                      hintText: 'To Date',
                    ),
                    SizedBox(height: 12.0),

                    CustomDropDown(
                      allPadding: 0,
                      horizontalPadding: 15,
                      isOutline: false,
                      hintColor: AppColors.primary,
                      iconColor: AppColors.primary,
                      suffixIconPath: '',
                      hint: 'Class',
                      items:
                          classState.classes
                              .map((selectClass) => selectClass.className)
                              .toList(),
                      onSelect: (String value) {
                        Class selectedClass = classState.classes.firstWhere(
                          (element) => element.className == value,
                        );
                        setState(() {
                          classId = selectedClass.classId.toString();
                          dropdownValueClass = value;
                          context.read<SectionsCubit>().fetchSections(
                            selectedClass.classId.toString(),
                          );
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    BlocConsumer<SectionsCubit, SectionsState>(
                      listener: (context, sectionStatus) {
                        if (sectionStatus.sectionsStatus ==
                            SectionsStatus.loading) {
                          DisplayUtils.showLoader();
                        } else if (sectionStatus.sectionsStatus ==
                            SectionsStatus.success) {
                          DisplayUtils.removeLoader();
                        } else if (sectionStatus.sectionsStatus ==
                            SectionsStatus.failure) {
                          DisplayUtils.removeLoader();
                          DisplayUtils.showSnackBar(
                            context,
                            sectionStatus.failure.message,
                          );
                        }
                      },
                      builder: (context, sectionState) {
                        sections = sectionState.sections;
                        return GestureDetector(
                          onTap:
                              dropdownValueClass == null
                                  ? () {
                                    DisplayUtils.showSnackBar(
                                      context,
                                      "Please select Class First",
                                    );
                                  }
                                  : null,
                          child: CustomDropDown(
                            allPadding: 0,
                            horizontalPadding: 15,
                            isOutline: false,
                            hintColor: AppColors.primary,
                            iconColor: AppColors.primary,
                            suffixIconPath: '',
                            hint: 'Section',
                            items:
                                sectionState.sections
                                    .map((section) => section.sectionName)
                                    .toList(),
                            onSelect: (String value) {
                              setState(() {
                                dropdownValueSection = value;
                                Section selectedSection = sectionState.sections
                                    .firstWhere(
                                      (element) => element.sectionName == value,
                                    );
                                sectionId =
                                    selectedSection.sectionId.toString();
                                Class selectedClass = classState.classes
                                    .firstWhere(
                                      (element) =>
                                          element.className ==
                                          dropdownValueClass,
                                    );
                                context.read<SubjectsCubit>().fetchSubjects(
                                  selectedClass.classId.toString(),
                                );

                                ClassStudentInput input = ClassStudentInput(
                                  classId: int.parse(classId!),
                                  sectionId: int.parse(sectionId!),
                                  ucSchoolId: authRepository.user.schoolId!,
                                );
                                context
                                    .read<AddDiaryCubit>()
                                    .fetchDiaryStudentList(input);
                              });
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    BlocConsumer<SubjectsCubit, SubjectsState>(
                      listener: (context, subjectsState) {
                        if (subjectsState.subjectsStatus ==
                            SectionsStatus.loading) {
                          DisplayUtils.showLoader();
                        } else if (subjectsState.subjectsStatus ==
                            SectionsStatus.success) {
                          DisplayUtils.removeLoader();
                        } else if (subjectsState.subjectsStatus ==
                            SectionsStatus.failure) {
                          DisplayUtils.removeLoader();
                          DisplayUtils.showSnackBar(
                            context,
                            subjectsState.failure.message,
                          );
                        }
                      },
                      builder: (context, subjectsState) {
                        subjects = subjectsState.subjects;
                        return GestureDetector(
                          onTap:
                              dropdownValueSection == null
                                  ? () {
                                    DisplayUtils.showSnackBar(
                                      context,
                                      "Please select section First",
                                    );
                                  }
                                  : null,
                          child: CustomDropDown(
                            allPadding: 0,
                            horizontalPadding: 15,
                            isOutline: false,
                            hintColor: AppColors.primary,
                            iconColor: AppColors.primary,
                            suffixIconPath: '',
                            hint: 'Subject',
                            items:
                                subjectsState.subjects
                                    .map((section) => section.subjectName)
                                    .toList(),
                            onSelect: (String value) {
                              setState(() {
                                SubjectModel selectedSubject = subjectsState
                                    .subjects
                                    .firstWhere(
                                      (element) => element.subjectName == value,
                                    );
                                subjectId =
                                    selectedSubject.subjectId.toString();
                                dropdownValueSubject = value;
                              });
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      hintText: 'Description',
                      // height: 230,
                      inputType: TextInputType.text,
                      fillColor: AppColors.lightGreyColor,
                      maxLines: 5,
                      controller: textBoxController,
                      hintColor: AppColors.primary,
                    ),

                    //////
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.lightGreyColor,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Upload Attachment',
                              height: 50,
                              readOnly: true,
                              bottomMargin: 0,
                              fontSize: 14,
                              controller: fileNameController,
                              fontWeight: FontWeight.normal,
                              inputType: TextInputType.text,
                              fillColor: AppColors.lightGreyColor,
                              hintColor: AppColors.primary,

                              // onTap: () async {
                              //   result = await FilePicker.platform.pickFiles(
                              //     type: FileType.custom,
                              //     allowMultiple: false,
                              //     allowedExtensions: [
                              //       'pdf',
                              //       'doc',
                              //       'docx',
                              //       'txt',
                              //       'jpg',
                              //       'jpeg',
                              //       'png',
                              //       'xlsx',
                              //       'xlsm',
                              //       'xlsb',
                              //       'xltx',
                              //       'ppt',
                              //       'pptx'
                              //     ],
                              //   );
                              //   if (result == null) {
                              //     DisplayUtils.showToast(
                              //         context, "No file selected");
                              //   } else {
                              //     file = File(
                              //         result!.files.single.path.toString());
                              //     fileNameController.text =
                              //         result!.files.single.name;
                              //     setState(() {});
                              //   }
                              // },
                              onTap: () async {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Wrap(
                                      children: [
                                        // ListTile(
                                        //   leading: Icon(Icons.camera_alt),
                                        //   title: Text('Take Photo'),
                                        //   onTap: () async {
                                        //     Navigator.pop(context);
                                        //     await checkCameraPermission(); // Close the bottom sheet
                                        //     final pickedFile =
                                        //         await ImagePicker().pickImage(
                                        //             source:
                                        //                 ImageSource.camera);
                                        //     if (pickedFile != null) {
                                        //       file = File(pickedFile.path);
                                        //       fileNameController.text =
                                        //           file!.path.split('/').last;
                                        //       setState(() {});
                                        //     } else {
                                        //       DisplayUtils.showToast(
                                        //           context, "No photo taken");
                                        //     }
                                        //   },
                                        // ),
                                        ListTile(
                                          leading: Icon(Icons.camera_alt),
                                          title: Text('Take Photo'),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            await checkCameraPermission(); // Close the bottom sheet
                                            final pickedFile =
                                                await ImagePicker().pickImage(
                                                  source: ImageSource.camera,
                                                );
                                            if (pickedFile != null) {
                                              file = File(pickedFile.path);

                                              // Format current date/time
                                              String formattedDate = DateFormat(
                                                'yyyy-MM-dd-hh-mm-a',
                                              ).format(DateTime.now());

                                              // Get extension from the original file
                                              String extension =
                                                  pickedFile.path
                                                      .split('.')
                                                      .last;

                                              // Combine formatted date with extension
                                              fileNameController.text =
                                                  '$formattedDate.$extension';

                                              setState(() {});
                                            } else {
                                              DisplayUtils.showToast(
                                                context,
                                                "No photo taken",
                                              );
                                            }
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.insert_drive_file,
                                          ),
                                          title: Text('Pick File'),
                                          onTap: () async {
                                            Navigator.pop(
                                              context,
                                            ); // Close the bottom sheet
                                            result = await FilePicker.platform
                                                .pickFiles(
                                                  type: FileType.custom,
                                                  allowMultiple: false,
                                                  allowedExtensions: [
                                                    'pdf',
                                                    'doc',
                                                    'docx',
                                                    'txt',
                                                    'jpg',
                                                    'jpeg',
                                                    'png',
                                                    'xlsx',
                                                    'xlsm',
                                                    'xlsb',
                                                    'xltx',
                                                    'ppt',
                                                    'pptx',
                                                  ],
                                                );
                                            if (result == null) {
                                              DisplayUtils.showToast(
                                                context,
                                                "No file selected",
                                              );
                                            } else {
                                              file = File(
                                                result!.files.single.path
                                                    .toString(),
                                              );
                                              fileNameController.text =
                                                  result!.files.single.name;
                                              setState(() {});
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          CustomButton(
                            height: 50,
                            width: 90,
                            borderRadius: 15,
                            onPressed: () {
                              if (result != null) {
                                DialogUtils.confirmationDialog(
                                  context: context,
                                  title: 'Confirmation!',
                                  content:
                                      'Are you sure you want to remove the file?',
                                  onPressYes: () {
                                    fileNameController.clear();
                                    result = null;
                                    setState(() {});
                                    NavRouter.pop(context);
                                  },
                                );
                              }
                            },
                            title: 'Remove',
                            isEnabled: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    //////
                    BlocConsumer<AddDiaryCubit, AddDiaryState>(
                      listener: (context, state) {
                        if (state.addDiaryStatus == AddDiaryStatus.loading) {
                          DisplayUtils.showLoader();
                        } else if (state.addDiaryStatus ==
                            AddDiaryStatus.success) {
                          DisplayUtils.removeLoader();
                          // Fluttertoast.showToast(
                          //     msg: "Diary added successfully!");
                          // NavRouter.pop(context);
                        } else if (state.addDiaryStatus ==
                            AddDiaryStatus.failure) {
                          DisplayUtils.removeLoader();
                          DisplayUtils.showSnackBar(
                            context,
                            state.failure.message,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap:
                                  state.studentList.isEmpty
                                      ? () {
                                        DisplayUtils.showSnackBar(
                                          context,
                                          "Select Class and Section First",
                                        );
                                      }
                                      : () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SelectStudentsDialogue(
                                              studentsList: state.studentList,
                                              selectedStudents:
                                                  selectedStudents,
                                              onSave: (v) {
                                                setState(() {
                                                  selectedStudents = v;
                                                });
                                              },
                                            );
                                          },
                                        );
                                      },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreyColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.transparent),
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        selectedStudents.isNotEmpty
                                            ? selectedStudents
                                            : "Select Students",
                                        // textAlign: ,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.0),
                            SizedBox(height: 12.0),
                            CustomButton(
                              height: 50,
                              borderRadius: 15,
                              onPressed: () async {
                                DiaryDescriptionInput input = _onApiHit();
                                input.file = await changeMulti(file!);

                                await context
                                    .read<AddDiaryCubit>()
                                    .uploadTeacherFileDiary(input)
                                    .then((v) {
                                      if (v) {
                                        DisplayUtils.showToast(
                                          context,
                                          "Diary Added Successfully",
                                        );
                                        NavRouter.pop(context);
                                      }
                                    });
                              },
                              title: 'Save',
                              isEnabled: true,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              }
              if (classState.classesStatus == ClassesStatus.failure) {
                return Center(child: Text(classState.failure.message));
              }
              return SizedBox();
            },
          ),
        ),
        backgroundColor: AppColors.primary,
        hMargin: 0,
      ),
    );
  }
}
