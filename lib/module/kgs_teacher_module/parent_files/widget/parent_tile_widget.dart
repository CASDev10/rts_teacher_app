import 'package:flutter/material.dart';
import 'package:rts/module/kgs_teacher_module/parent_files/models/parent_files_response.dart';

import '../../../../constants/app_colors.dart';
import '../../../../widgets/helper_function.dart';
import '../../daily_diary/widgets/detail_row_widget.dart';

class ParentFileExpansionTile extends StatelessWidget {
  const ParentFileExpansionTile({super.key, required this.model});

  final ParentsFileList model;

  String shortenText(String text, [int maxLength = 30]) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
  }

  checkKeywords(String input) {
    if (input.contains(RegExp(r'\bAssignment\b', caseSensitive: false))) {
      return 'Assignment';
    }
    if (input.contains(RegExp(r'\bPunishment\b', caseSensitive: false))) {
      return 'Punishment';
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: AppColors.primaryGreen),
        ),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(),
          title: Text(
            model.studentName,
          ),
          childrenPadding: EdgeInsets.symmetric(
                horizontal: 12.0,
              ) +
              EdgeInsets.only(
                bottom: 14.0,
              ),
          children: [
            Divider(
              thickness: 1.5,
            ),
            DetailRowWidget(
              name: 'Description',
              value: model.description
                  .replaceAll("Assignment:", "")
                  .replaceAll("Punishment:", ""),
            ),
            Divider(
              thickness: 0.7,
            ),
            DetailRowWidget(
              name: 'Type',
              value: checkKeywords(model.description),
            ),
            Divider(
              thickness: 0.7,
            ),
            DetailRowWidget(
              name: 'Class Name',
              value: model.className,
            ),
            Divider(
              thickness: 0.7,
            ),
            DetailRowWidget(
              name: 'Section Name',
              value: model.sectionName,
            ),
            Divider(
              thickness: 0.7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Download File",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                if (model.fileDownloadLink.isNotEmpty)
                  InkWell(
                    child: Text(
                      "Download",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.blue),
                    ),
                    onTap: () {
                      openUrlInBrowser(model.fileDownloadLink);
                    },
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
