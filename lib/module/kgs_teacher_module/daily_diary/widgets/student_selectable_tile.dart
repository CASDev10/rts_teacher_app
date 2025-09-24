import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class StudentSelectableTile extends StatelessWidget {
  const StudentSelectableTile({
    super.key,
    required this.name,
    required this.isSelected,
  });

  final String name;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green),
      ),
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              // textAlign: ,
              style: TextStyle(fontSize: 14, color: AppColors.primary),
            ),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(color: AppColors.primary),
              ),
              child:
                  isSelected
                      ? Icon(
                        Icons.check_outlined,
                        size: 12.0,
                        color: Colors.white,
                      )
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
