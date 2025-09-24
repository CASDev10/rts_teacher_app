import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/app_colors.dart';

class HomeTabCard extends StatelessWidget {
  final bool isSvg, show;
  final String name, imagePath;
  final VoidCallback? onTap;

  const HomeTabCard({
    super.key,
    this.isSvg = true,
    this.onTap,
    required this.name,
    required this.imagePath,
    this.show = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            show
                ? isSvg
                    ? SvgPicture.asset(imagePath, height: 120, width: 120)
                    : Image.asset(imagePath, height: 120, width: 120)
                : Icon(
                  Icons.request_page,
                  size: 50.0,
                  color: AppColors.primary,
                ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/png/bg_home_tabs.png"),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
