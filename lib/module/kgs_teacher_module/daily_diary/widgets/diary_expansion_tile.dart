import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../widgets/helper_function.dart';
import '../models/diary_list_response.dart';
import 'detail_row_widget.dart';

class DiaryExpansionTile extends StatelessWidget {
  const DiaryExpansionTile({super.key, required this.model});

  final DiaryModel model;

  String shortenText(String text, [int maxLength = 30]) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
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
            model.subjectName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
          childrenPadding:
              EdgeInsets.symmetric(horizontal: 12.0) +
              EdgeInsets.only(bottom: 14.0),
          children: [
            Divider(thickness: 1.5),
            DetailRowWidget(name: 'Date From', value: model.dateFromString),
            Divider(thickness: 0.7),
            DetailRowWidget(name: 'Date To', value: model.dateToString),
            Divider(thickness: 0.7),
            DetailRowWidget(
              name: 'Class Name',
              value: "${model.className} - ${model.sectionName}",
            ),
            Divider(thickness: 0.7),
            DetailRowWidget(name: 'Diary Text', value: model.text),
            Divider(thickness: 0.7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Download Diary",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(width: 10),
                (model.logoContent != null || model.uploadFilePath != null)
                    ? Flexible(
                        child: InkWell(
                          child: Text(
                            shortenText(model.userFileName),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.blue,
                            ),
                          ),
                          onTap: () {
                            if (model.logoContent != null) {
                              saveBase64ToFile2(
                                context,
                                base64String: model.logoContent,
                                fileName: model.userFileName,
                              );
                            } else if (model.uploadFilePath != null) {
                              openUrlInBrowser(model.uploadFilePath);
                            }
                          },
                        ),
                      )
                    : Text('N/A'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
