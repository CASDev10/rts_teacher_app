import 'package:flutter/cupertino.dart';
import 'package:rts/module/kgs_teacher_module/exam_result/pages/show_result_screen.dart';

import '../../../../components/base_scaffold.dart';
import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_dropdown.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';

class ProcessResultScreen extends StatelessWidget {
  const ProcessResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const CustomAppbar('Process Result', centerTitle: true),
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
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  CustomDropDown(
                    allPadding: 0,
                    horizontalPadding: 15,
                    isOutline: false,
                    hintColor: AppColors.primary,
                    iconColor: AppColors.primary,
                    suffixIconPath: '',
                    hint: 'Select Class',
                    items: [],
                    onSelect: (String value) {},
                  ),
                  const SizedBox(height: 16),
                  CustomDropDown(
                    allPadding: 0,
                    horizontalPadding: 15,
                    isOutline: false,
                    hintColor: AppColors.primary,
                    iconColor: AppColors.primary,
                    suffixIconPath: '',
                    hint: 'Evaluation Type',
                    items: [],
                    onSelect: (String value) {},
                  ),
                  const SizedBox(height: 16),
                  CustomDropDown(
                    allPadding: 0,
                    horizontalPadding: 15,
                    isOutline: false,
                    hintColor: AppColors.primary,
                    iconColor: AppColors.primary,
                    suffixIconPath: '',
                    hint: 'Check Point',
                    items: [],
                    onSelect: (String value) {},
                  ),
                  const SizedBox(height: 20),
                  CustomDropDown(
                    allPadding: 0,
                    horizontalPadding: 15,
                    isOutline: false,
                    hintColor: AppColors.primary,
                    iconColor: AppColors.primary,
                    suffixIconPath: '',
                    hint: 'Evaluation',
                    items: [],
                    onSelect: (String value) {},
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomButton(
                  height: 50,
                  borderRadius: 15,
                  onPressed: () {
                    NavRouter.push(context, ShowResultScreen());
                  },
                  title: 'Submit',
                  isEnabled: true,
                ),
              ),
            ],
          ),
        ),
      ),
      hMargin: 0,
      backgroundColor: AppColors.primary,
    );
  }
}
