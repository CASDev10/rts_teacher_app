import 'package:flutter/material.dart';
import 'package:rts/components/custom_button.dart';
import 'package:rts/components/custom_textfield.dart';
import 'package:rts/config/config.dart';
import 'package:rts/constants/app_colors.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/widgets/student_selectable_tile.dart';
import 'package:rts/utils/extensions/extended_context.dart';

import '../models/student_diary_list_response.dart';

class SelectStudentsDialogue extends StatefulWidget {
  const SelectStudentsDialogue({
    super.key,
    required this.studentsList,
    this.onSave,
    this.selectedStudents,
  });

  final List<DiaryStudentModel> studentsList;
  final Function(String)? onSave;
  final String? selectedStudents;

  @override
  State<SelectStudentsDialogue> createState() => _SelectStudentsDialogueState();
}

class _SelectStudentsDialogueState extends State<SelectStudentsDialogue> {
  List<int> studentIds = [];
  List<DiaryStudentModel> filteredStudents = [];
  final TextEditingController _searchStudentController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredStudents = widget.studentsList;
    if (widget.selectedStudents!.isNotEmpty) {
      setState(() {
        studentIds = parseStudentIds(widget.selectedStudents!);
      });
    }
    // Listen for changes in the search text field
    _searchStudentController.addListener(_filterStudents);
  }

  @override
  void dispose() {
    _searchStudentController.removeListener(_filterStudents);
    _searchStudentController.dispose();
    super.dispose();
  }

  List<int> parseStudentIds(String idsString) {
    return idsString
        .split(',') // Split by comma
        .map((e) => int.parse(e)) // Convert each to int
        .toList(); // Return as list
  }

  void _filterStudents() {
    final query = _searchStudentController.text.toLowerCase();

    setState(() {
      filteredStudents = widget.studentsList
          .where((student) => student.studentName.toLowerCase().contains(query))
          .toList();
    });
  }

  bool isStudentInList(int id) {
    return studentIds.contains(id);
  }

  void toggleStudentId(int id) {
    if (studentIds.contains(id)) {
      studentIds.remove(id);
    } else {
      studentIds.add(id);
    }
  }

  void addAllIds() {
    if (studentIds.isEmpty) {
      // Add all student IDs if the list is currently empty
      for (var student in widget.studentsList) {
        toggleStudentId(student.studentId);
      }
    } else {
      // Remove all student IDs if the list is not empty
      studentIds.clear();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 300, maxHeight: 300),
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Students",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      addAllIds();
                    },
                    child: Text(
                      "Select All",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              CustomTextField(
                borderColor: AppColors.primaryGreen,
                enableBorderColor: AppColors.primaryGreen,
                bottomMargin: 0,
                minHeight: 40.0,
                hintText: 'Search by Student Name',
                hintColor: AppColors.primaryGreen,
                inputType: TextInputType.text,
                controller: _searchStudentController,
                fillColor: AppColors.lightGreyColor,
                suffixWidget: Icon(
                  Icons.search,
                  color: AppColors.primaryGreen,
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Divider(),
              SizedBox(
                height: 4.0,
              ),
              filteredStudents.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        var student = filteredStudents[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 12.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              toggleStudentId(student.studentId);
                              setState(() {});
                            },
                            child: StudentSelectableTile(
                              name: student.studentName,
                              isSelected: isStudentInList(student.studentId),
                            ),
                          ),
                        );
                      })
                  : Text(
                      "No Student with this name",
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              SizedBox(
                height: 4.0,
              ),
              Divider(),
              SizedBox(
                height: 4.0,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              String students = studentIds
                                  .toString()
                                  .replaceAll("[", "")
                                  .replaceAll("]", "");
                              NavRouter.pop(context);
                              widget.onSave!(students);
                            },
                            title: "Save",
                            height: 40.0,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              NavRouter.pop(context);
                            },
                            fontSize: 14.0,
                            backgroundColor: Colors.transparent,
                            textColor: AppColors.primaryGreen,
                            title: "Cancel",
                            height: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
