import 'package:flutter/material.dart';
import 'package:rts/module/kgs_teacher_module/student_evaluation/widgets/radio_option_widget.dart';

import '../../../../constants/app_colors.dart';
import '../models/evaluation_by_student_id_response.dart';
import '../models/save_evaluation_input.dart';

class EvaluationFormWidget extends StatelessWidget {
  const EvaluationFormWidget(
      {super.key, required this.parent, required this.children, this.onSelect});

  final Function(KinderGartenTermOneResultDetail)? onSelect;
  final OutcomeParent parent;
  final List<OutcomeChild> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryGreen,
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        shape: RoundedRectangleBorder(),
        title: Text(
          parent.outcome,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: children.asMap().entries.map((entry) {
          int index = entry.key;
          var child = entry.value;

          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 8.0,
            ),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                  side: BorderSide(color: AppColors.primaryGreen, width: 1.5)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      child.outcome,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Divider(),
                    SizedBox(
                      height: 4.0,
                    ),
                    RadioButtonSelector(
                      selectedOption: returnSelectedOutcome(child),
                      onSelected: (v) {
                        final KinderGartenTermOneResultDetail item =
                            KinderGartenTermOneResultDetail(
                                gradeId: child.parentId,
                                subGradeId: child.outcomeId,
                                isWorkingTowards: false,
                                isWorkingWithin: false,
                                isWorkingBeyond: false);
                        if (v == "WW") {
                          item.isWorkingWithin = true;
                        } else if (v == "WT") {
                          item.isWorkingTowards = true;
                        } else if (v == "WB") {
                          item.isWorkingBeyond = true;
                        }
                        onSelect!(item);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  returnSelectedOutcome(OutcomeChild child) {
    if (child.isWorkingBeyond == true) {
      return "WB";
    } else if (child.isWorkingTowards == true) {
      return "WT";
    } else if (child.isWorkingWithin == true) {
      return "WW";
    } else {
      return "";
    }
  }
}
