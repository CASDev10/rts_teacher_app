// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:rts/components/base_scaffold.dart';
// import 'package:rts/components/custom_appbar.dart';
// import 'package:rts/components/custom_button.dart';
// import 'package:rts/components/custom_dropdown.dart';
// import 'package:rts/components/custom_textfield.dart';
// import 'package:rts/constants/app_colors.dart';
// import 'package:rts/module/kgs_teacher_module/daily_diary/cubit/add_diary_cubit/add_diary_cubit.dart';
// import 'package:rts/module/kgs_teacher_module/daily_diary/cubit/add_diary_cubit/add_diary_state.dart';
// import 'package:rts/module/kgs_teacher_module/daily_diary/cubit/subject_cubit/subjects_cubit.dart';
// import 'package:rts/module/kgs_teacher_module/daily_diary/models/add_diary_input.dart';
// import 'package:rts/module/kgs_teacher_module/daily_diary/models/diary_description_input.dart';
// import 'package:rts/module/kgs_teacher_module/daily_diary/models/diary_input.dart';
// // import 'package:rts/module/kgs_teacher_module/daily_diary/models/diary_input.dart';
// import 'package:rts/module/kgs_teacher_module/daily_diary/models/subjects_response.dart';
// import 'package:rts/widgets/helper_function.dart';

// import '../../../../components/loading_indicator.dart';
// import '../../../../config/routes/nav_router.dart';
// import '../../../../core/di/service_locator.dart';
// import '../../../../utils/display/dialogs/dialog_utils.dart';
// import '../../../../utils/display/display_utils.dart';
// import '../../class_section/cubit/classes_cubit/classes_cubit.dart';
// import '../../class_section/cubit/sections_cubit/sections_cubit.dart';
// import '../../class_section/model/classes_model.dart';
// import '../../class_section/model/sections_model.dart';
// import '../../kgs_teacher_auth/repo/auth_repository.dart';
// import '../../student_result/widgets/student_result_date_picker.dart';
// import '../models/class_student_input.dart';
// import '../widgets/select_students_dialogue.dart';

// class AddDailyDiaryScreen extends StatefulWidget {
//   @override
//   State<AddDailyDiaryScreen> createState() => _AddDailyDiaryScreenState();
// }

// class _AddDailyDiaryScreenState extends State<AddDailyDiaryScreen> {
//   TextEditingController fromDateController = TextEditingController();
//   TextEditingController toDateController = TextEditingController();
//   TextEditingController textBoxController = TextEditingController();
//   TextEditingController fileNameController = TextEditingController();
//   FilePickerResult? result;
//   File? file;
//   String selectedStudents = "";

//   Future<MultipartFile> changeMulti(File file) async {
//     MultipartFile multipartFile = await MultipartFile.fromFile(
//       file.path,
//       filename: file.path,
//     );
//     return multipartFile;
//   }

//   Class? selectedClass;
//   Section? selectedSection;
//   SubjectModel? selectedSubject;

//   // String? dropdownValueClass;
//   // String? dropdownValueSection;
//   // String? dropdownValueSubject;
//   // String? classId;
//   String? selectedWorkType;
//   String? selectedAssignmentType;

//   // String? sectionId;
//   // String? subjectId;
//   // List<Section>? sections;
//   // List<SubjectModel>? subjects;

//   AuthRepository authRepository = sl<AuthRepository>();

//   DiaryDescriptionInput _onApiHit() {
//     DiaryDescriptionInput input = DiaryDescriptionInput(
//       dateFrom: fromDateController.text,
//       dateTo: toDateController.text,
//       classIdFk: selectedClass?.classId ?? 0,

//       subjectIdFk: selectedSubject?.subjectId ?? 0,
//       text: selectedAssignmentType != null
//           ? "$selectedAssignmentType" + textBoxController.text
//           : textBoxController.text,
//       ucSchoolId: authRepository.user.schoolId.toString(),
//       studentIDs: selectedStudents,
//       sectionIdFk: selectedSection?.sectionId ?? 0,
//       description: selectedAssignmentType != null
//           ? "$selectedAssignmentType${textBoxController.text}"
//           : textBoxController.text,
//       schoold: authRepository.user.schoolId!,
//       createdBy: authRepository.user.userId,
//     );

//     print(jsonEncode(input));
//     print(input.toJson());

//     return input;
//   }

//   DiaryInput _onDiaryApiHit() {
//     DiaryInput input = DiaryInput(
//       dateFrom: fromDateController.text,
//       dateTo: toDateController.text,
//       classIdFk: selectedClass?.classId ?? 0,

//       subjectIdFk: selectedSubject?.subjectId ?? 0,
//       text: selectedAssignmentType != null
//           ? "$selectedAssignmentType${textBoxController.text}"
//           : textBoxController.text,
//       ucSchoolId: authRepository.user.schoolId?.toInt() ?? 0,
//       sectionIdFk: selectedSection?.sectionId ?? 0,
//       ucLoginUserId: authRepository.user.userId?.toInt() ?? 0,
//       // file: file != null
//       //     ? MultipartFile.fromFileSync(
//       //         file!.path,
//       //         filename: fileNameController.text,
//       //       )
//       //     : null,
//     );

//     print(jsonEncode(input));
//     print(input.toJson());

//     return input;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => ClassesCubit(sl())..fetchClasses()),
//         BlocProvider(create: (context) => SectionsCubit(sl())),
//         BlocProvider(create: (context) => SubjectsCubit(sl())),
//         BlocProvider(create: (context) => AddDiaryCubit(sl())),
//       ],
//       child: BaseScaffold(
//         appBar: const CustomAppbar(
//           'Add Diary / Assignment Work',
//           centerTitle: true,
//         ),
//         body: Container(
//           padding:
//               const EdgeInsets.symmetric(horizontal: 20) +
//               const EdgeInsets.symmetric(vertical: 30),
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(50),
//               topRight: Radius.circular(50),
//             ),
//           ),
//           child: BlocBuilder<ClassesCubit, ClassesState>(
//             builder: (context, classState) {
//               if (classState.classesStatus == ClassesStatus.loading) {
//                 return Center(child: LoadingIndicator());
//               }
//               if (classState.classesStatus == ClassesStatus.success) {
//                 return ListView(
//                   children: [
//                     const SizedBox(height: 12),
//                     AddResultDatePicker(
//                       stringFunction: (v) {
//                         setState(() {
//                           fromDateController.text = v;
//                         });
//                       },
//                       hintText: 'From Date',
//                     ),
//                     SizedBox(height: 12.0),
//                     AddResultDatePicker(
//                       stringFunction: (v) {
//                         setState(() {
//                           toDateController.text = v;
//                         });
//                       },
//                       hintText: 'To Date',
//                     ),
//                     const SizedBox(height: 12),
//                     GeneralCustomDropDown<String>(
//                       allPadding: 0,
//                       horizontalPadding: 15,
//                       isOutline: false,
//                       hintColor: AppColors.primaryGreen,
//                       iconColor: AppColors.primaryGreen,
//                       suffixIconPath: '',
//                       hint: "Select Work Type",
//                       items: ["Assignment", "Diary"],
//                       onSelect: (v) {
//                         setState(() {
//                           selectedWorkType = v;
//                           if (selectedWorkType != "Assignment") {
//                             selectedAssignmentType = null;
//                           }
//                         });
//                       },
//                     ),
//                     SizedBox(height: 12.0),
//                     GeneralCustomDropDown<Class>(
//                       allPadding: 0,
//                       horizontalPadding: 15,
//                       // selectedValue: selectedClass,
//                       isOutline: false,
//                       hintColor: AppColors.primaryGreen,
//                       iconColor: AppColors.primaryGreen,
//                       suffixIconPath: '',
//                       displayField: (item) => item.className,
//                       hint: 'Select Class',
//                       items: classState.classes,
//                       onSelect: (value) {
//                         setState(() {
//                           selectedClass = value;
//                           selectedSection = null;
//                         });
//                         context.read<SectionsCubit>().fetchSections(
//                           selectedClass?.classId.toString() ?? '',
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 12),
//                     BlocConsumer<SectionsCubit, SectionsState>(
//                       listener: (context, sectionStatus) {
//                         if (sectionStatus.sectionsStatus ==
//                             SectionsStatus.loading) {
//                           DisplayUtils.showLoader();
//                         } else if (sectionStatus.sectionsStatus ==
//                             SectionsStatus.success) {
//                           DisplayUtils.removeLoader();
//                         } else if (sectionStatus.sectionsStatus ==
//                             SectionsStatus.failure) {
//                           DisplayUtils.removeLoader();
//                           DisplayUtils.showSnackBar(
//                             context,
//                             sectionStatus.failure.message,
//                           );
//                         }
//                       },
//                       builder: (context, state) {
//                         return GeneralCustomDropDown<Section>(
//                           allPadding: 0,
//                           horizontalPadding: 15,
//                           selectedValue: selectedSection,
//                           isOutline: false,
//                           hintColor: AppColors.primaryGreen,
//                           iconColor: AppColors.primaryGreen,
//                           suffixIconPath: '',
//                           displayField: (item) => item.sectionName,
//                           hint: 'Select Section',
//                           items: state.sections,
//                           onSelect: (value) {
//                             setState(() {
//                               selectedSection = value;
//                               print(
//                                 '###@@@@@@@@#${selectedSection?.sectionName}',
//                               );
//                             });
//                           },
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 12),
//                     if (selectedWorkType == "Assignment" &&
//                         selectedWorkType != null) ...[
//                       BlocBuilder<AddDiaryCubit, AddDiaryState>(
//                         builder: (context, state) {
//                           return GestureDetector(
//                             onTap: state.studentList.isEmpty
//                                 ? () {
//                                     DisplayUtils.showSnackBar(
//                                       context,
//                                       "Select Class and Section First",
//                                     );
//                                   }
//                                 : () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return SelectStudentsDialogue(
//                                           studentsList: state.studentList,
//                                           selectedStudents: selectedStudents,
//                                           onSave: (v) {
//                                             setState(() {
//                                               selectedStudents = v;
//                                             });
//                                           },
//                                         );
//                                       },
//                                     );
//                                   },
//                             child: Container(
//                               height: 50,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: AppColors.lightGreyColor,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(color: Colors.transparent),
//                               ),
//                               padding: EdgeInsets.all(8.0),
//                               child: Center(
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       selectedStudents.isNotEmpty
//                                           ? selectedStudents
//                                           : "Select Students",
//                                       // textAlign: ,
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: AppColors.primaryGreen,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       SizedBox(height: 12.0),
//                     ],
//                     BlocConsumer<SubjectsCubit, SubjectsState>(
//                       listener: (context, subjectsState) {
//                         if (subjectsState.subjectsStatus ==
//                             SubjectsStatus.loading) {
//                           DisplayUtils.showLoader();
//                         } else if (subjectsState.subjectsStatus ==
//                             SubjectsStatus.success) {
//                           DisplayUtils.removeLoader();
//                         } else if (subjectsState.subjectsStatus ==
//                             SubjectsStatus.failure) {
//                           DisplayUtils.removeLoader();
//                           DisplayUtils.showSnackBar(
//                             context,
//                             subjectsState.failure.message,
//                           );
//                         }
//                       },
//                       builder: (context, subjectsState) {
//                         // subjects = subjectsState.subjects;
//                         return GestureDetector(
//                           onTap: selectedSection == null
//                               ? () {
//                                   DisplayUtils.showSnackBar(
//                                     context,
//                                     "Please select section First",
//                                   );
//                                 }
//                               : null,
//                           child: GeneralCustomDropDown<SubjectModel>(
//                             allPadding: 0,
//                             horizontalPadding: 15,
//                             isOutline: false,
//                             hintColor: AppColors.primaryGreen,
//                             iconColor: AppColors.primaryGreen,
//                             suffixIconPath: '',
//                             hint: 'Subject',
//                             items: subjectsState.subjects,
//                             onSelect: (value) {
//                               setState(() {
//                                 // SubjectModel selectedSubject = subjectsState
//                                 //     .subjects
//                                 //     .firstWhere(
//                                 //       (element) => element.subjectName == value,
//                                 //     );
//                                 // subjectId = selectedSubject.subjectId
//                                 //     .toString();
//                                 selectedSubject = value;
//                               });
//                             },
//                           ),
//                         );
//                       },
//                     ),

//                     const SizedBox(height: 12),

//                     if (selectedWorkType == "Assignment" &&
//                         selectedWorkType != null) ...[
//                       GeneralCustomDropDown<String>(
//                         allPadding: 0,
//                         horizontalPadding: 15,
//                         isOutline: false,
//                         hintColor: AppColors.primaryGreen,
//                         iconColor: AppColors.primaryGreen,
//                         suffixIconPath: '',
//                         hint: "Select Assignment Type",
//                         items: ["Punishment", "Assignment"],
//                         onSelect: (v) {
//                           setState(() {
//                             selectedAssignmentType = "$v:";
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 12),
//                     ],

//                     CustomTextField(
//                       hintText: 'Description',
//                       // height: 230,
//                       inputType: TextInputType.text,
//                       fillColor: AppColors.lightGreyColor,
//                       maxLines: 5,
//                       controller: textBoxController,
//                       hintColor: AppColors.primaryGreen,
//                     ),

//                     //////
//                     Container(
//                       decoration: const BoxDecoration(
//                         color: AppColors.lightGreyColor,
//                         borderRadius: BorderRadius.all(Radius.circular(12)),
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: CustomTextField(
//                               hintText: 'Upload Attachment',
//                               height: 50,
//                               readOnly: true,
//                               bottomMargin: 0,
//                               fontSize: 14,
//                               controller: fileNameController,
//                               fontWeight: FontWeight.normal,
//                               inputType: TextInputType.text,
//                               fillColor: AppColors.lightGreyColor,
//                               hintColor: AppColors.primaryGreen,
//                               onTap: () async {
//                                 showModalBottomSheet(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return SafeArea(
//                                       child: Wrap(
//                                         children: [
//                                           ListTile(
//                                             leading: Icon(Icons.camera_alt),
//                                             title: Text('Take Photo'),
//                                             onTap: () async {
//                                               Navigator.pop(context);
//                                               await checkCameraPermission(); // Close the bottom sheet
//                                               final pickedFile =
//                                                   await ImagePicker().pickImage(
//                                                     source: ImageSource.camera,
//                                                   );
//                                               if (pickedFile != null) {
//                                                 file = File(pickedFile.path);

//                                                 // Format current date/time
//                                                 String formattedDate =
//                                                     DateFormat(
//                                                       'yyyy-MM-dd-hh-mm-a',
//                                                     ).format(DateTime.now());

//                                                 // Get extension from the original file
//                                                 String extension = pickedFile
//                                                     .path
//                                                     .split('.')
//                                                     .last;

//                                                 // Combine formatted date with extension
//                                                 fileNameController.text =
//                                                     '$formattedDate.$extension';

//                                                 setState(() {});
//                                               } else {
//                                                 DisplayUtils.showToast(
//                                                   context,
//                                                   "No photo taken",
//                                                 );
//                                               }
//                                             },
//                                           ),
//                                           ListTile(
//                                             leading: Icon(
//                                               Icons.insert_drive_file,
//                                             ),
//                                             title: Text('Pick File'),
//                                             onTap: () async {
//                                               Navigator.pop(
//                                                 context,
//                                               ); // Close the bottom sheet
//                                               result = await FilePicker.platform
//                                                   .pickFiles(
//                                                     type: FileType.custom,
//                                                     allowMultiple: false,
//                                                     allowedExtensions: [
//                                                       'pdf',
//                                                       'doc',
//                                                       'docx',
//                                                       'txt',
//                                                       'jpg',
//                                                       'jpeg',
//                                                       'png',
//                                                       'xlsx',
//                                                       'xlsm',
//                                                       'xlsb',
//                                                       'xltx',
//                                                       'ppt',
//                                                       'pptx',
//                                                     ],
//                                                   );
//                                               if (result == null) {
//                                                 DisplayUtils.showToast(
//                                                   context,
//                                                   "No file selected",
//                                                 );
//                                               } else {
//                                                 file = File(
//                                                   result!.files.single.path
//                                                       .toString(),
//                                                 );
//                                                 fileNameController.text =
//                                                     result!.files.single.name;
//                                                 setState(() {});
//                                               }
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             ),
//                           ),
//                           CustomButton(
//                             height: 50,
//                             width: 90,
//                             borderRadius: 15,
//                             onPressed: () {
//                               if (result != null) {
//                                 DialogUtils.confirmationDialog(
//                                   context: context,
//                                   title: 'Confirmation!',
//                                   content:
//                                       'Are you sure you want to remove the file?',
//                                   onPressYes: () {
//                                     fileNameController.clear();
//                                     result = null;
//                                     setState(() {});
//                                     NavRouter.pop(context);
//                                   },
//                                 );
//                               }
//                             },
//                             title: 'Remove',
//                             isEnabled: true,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     //////
//                     BlocConsumer<AddDiaryCubit, AddDiaryState>(
//                       listener: (context, state) {
//                         if (state.addDiaryStatus == AddDiaryStatus.loading) {
//                           DisplayUtils.showLoader();
//                         } else if (state.addDiaryStatus ==
//                             AddDiaryStatus.success) {
//                           DisplayUtils.removeLoader();
//                         } else if (state.addDiaryStatus ==
//                             AddDiaryStatus.failure) {
//                           DisplayUtils.removeLoader();
//                           DisplayUtils.showSnackBar(
//                             context,
//                             state.failure.message,
//                           );
//                         }
//                       },
//                       builder: (context, state) {
//                         return Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             SizedBox(height: 12.0),
//                             CustomButton(
//                               height: 50,
//                               borderRadius: 15,
//                               onPressed: () async {
//                                 DiaryDescriptionInput input = _onApiHit();
//                                 DiaryInput diaryInput = _onDiaryApiHit();
//                                 input.file = await changeMulti(file!);
//                                 final diaryFile = await changeMulti(file!);
//                                 print('###worktype $selectedWorkType');
//                                 print(
//                                   '###assignmenttype $selectedAssignmentType',
//                                 );
//                                 if (selectedWorkType != "Assignment") {
//                                   print('###object Diary ');
//                                   //   For uploading diary
//                                   if (fromDateController.text.isNotEmpty &&
//                                       toDateController.text.isNotEmpty &&
//                                       selectedSubject != null &&
//                                       selectedClass != null &&
//                                       selectedSection != null) {
//                                     await context
//                                         .read<AddDiaryCubit>()
//                                         .uploadTeacherFileDiary(
//                                           diaryInput,
//                                           diaryFile,
//                                         )
//                                         .then((v) {
//                                           if (v) {
//                                             DisplayUtils.showToast(
//                                               context,
//                                               "Diary Added Successfully",
//                                             );
//                                             NavRouter.pop(context);
//                                           }
//                                         });
//                                   } else {
//                                     DisplayUtils.showSnackBar(
//                                       context,
//                                       "Required all Fields for Diary",
//                                     );
//                                   }
//                                 } else {
//                                   print('###object Assignment ');
//                                   if (fromDateController.text.isNotEmpty &&
//                                       toDateController.text.isNotEmpty &&
//                                       selectedSubject != null &&
//                                       selectedClass != null &&
//                                       selectedSection != null &&
//                                       selectedAssignmentType != null) {
//                                     await context
//                                         .read<AddDiaryCubit>()
//                                         .uploadTeacherAssignment(input)
//                                         .then((v) {
//                                           if (v) {
//                                             DisplayUtils.showToast(
//                                               context,
//                                               "Assignment Added Successfully",
//                                             );
//                                             NavRouter.pop(context);
//                                           }
//                                         });
//                                   } else {
//                                     DisplayUtils.showSnackBar(
//                                       context,
//                                       "Required all Fields for Assignment",
//                                     );
//                                   }
//                                 }
//                               },
//                               title: 'Save',
//                               isEnabled: true,
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ],
//                 );
//               }
//               if (classState.classesStatus == ClassesStatus.failure) {
//                 return Center(child: Text(classState.failure.message));
//               }
//               return SizedBox();
//             },
//           ),
//         ),
//         backgroundColor: AppColors.primaryGreen,
//         hMargin: 0,
//       ),
//     );
//   }
// }
