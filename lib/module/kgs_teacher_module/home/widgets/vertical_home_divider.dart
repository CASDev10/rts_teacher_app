import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class VerticalHomeDivider extends StatelessWidget {
  const VerticalHomeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      color: AppColors.dividerColor,
      height: 200,
    );
  }
}
