import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class HorizontalHomeDivider extends StatelessWidget {
  const HorizontalHomeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: double.infinity,
        color: AppColors.dividerColor,
        height: 1,
      ),
    );
  }
}
