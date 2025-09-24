import 'package:flutter/material.dart';
import 'package:rts/module/kgs_teacher_module/daily_diary/widgets/student_selectable_tile.dart';

import '../../../../components/custom_button.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
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

  List<int> parseStudentIds(String idsString) {
    return idsString
        .split(',') // Split by comma
        .map((e) => int.parse(e)) // Convert each to int
        .toList(); // Return as list
  }

  void addAllIds() {
    for (var student in widget.studentsList) {
      toggleStudentId(student.studentId);
    }
    setState(() {});
  }

  @override
  void initState() {
    if (widget.selectedStudents!.isNotEmpty) {
      setState(() {
        studentIds = parseStudentIds(widget.selectedStudents!);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800),
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
            SizedBox(height: 4.0),
            Divider(),
            SizedBox(height: 4.0),
            ...widget.studentsList
                .map(
                  (student) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
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
                  ),
                )
                .toList(),
            SizedBox(height: 4.0),
            Divider(),
            SizedBox(height: 4.0),
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
                      SizedBox(width: 12.0),
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            NavRouter.pop(context);
                          },
                          fontSize: 14.0,
                          backgroundColor: Colors.transparent,
                          textColor: AppColors.primary,
                          title: "Cancel",
                          height: 40.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
