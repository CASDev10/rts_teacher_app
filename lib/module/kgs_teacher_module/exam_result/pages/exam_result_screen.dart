import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../components/base_scaffold.dart';
import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_textfield.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
import 'add_result_screen.dart';

class ExamResultScreen extends StatelessWidget {
  const ExamResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const CustomAppbar('Exam & Result', centerTitle: true),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20) +
              const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Add Result',
                height: 50,
                inputType: TextInputType.text,
                fillColor: AppColors.lightGreyColor,
                hintColor: AppColors.primary,
                fontWeight: FontWeight.w500,
                readOnly: true,
                fontSize: 16,
                suffixWidget: SvgPicture.asset(
                  'assets/images/svg/ic_arrow_forward.svg',
                  color: AppColors.primary,
                ),
                onTap: () async {
                  NavRouter.push(context, AddResultScreen());
                },
              ),
              /*CustomTextField(
                hintText: 'Process Result',
                height: 50,
                inputType: TextInputType.text,
                fillColor: AppColors.lightGreyColor,
                hintColor: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
                readOnly: true,
                fontSize: 16,
                suffixWidget: SvgPicture.asset(
                  'assets/images/svg/ic_arrow_forward.svg',
                  color: AppColors.primaryDark,
                ),
                onTap: () async {
                  NavRouter.push(context, ProcessResultScreen());
                },
              ),*/
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      hMargin: 0,
      backgroundColor: AppColors.primary,
    );
  }
}
