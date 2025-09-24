import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/base_scaffold.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_textfield.dart';
import '../../../../components/text_view.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../utils/display/dialogs/widgets/dialogs.dart';
import '../../../../utils/display/display_utils.dart';
import '../../../../utils/validators/validation_utils.dart';
import '../cubit/kgs_teacher_login_cubit/kgs_teacher_login_cubit.dart';
import '../cubit/user_schools_cubit/user_schools_cubit.dart';
import '../widget/password_suffix_widget.dart';
import 'kgs_teacher_login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  void onSuccessfulSignup(BuildContext context) async {
    DisplayUtils.showLoader();
    await Future.delayed(Duration(seconds: 5));
    DisplayUtils.removeLoader();

    if (context.mounted) {
      NavRouter.pop(context);

      Future.delayed(Duration(milliseconds: 300), () {
        if (context.mounted) {
          Dialogs.showCongratulationsDialog(context);
        }
      });
    }
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();

      onSuccessfulSignup(context);
    } else {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSchoolsCubit(sl()),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return BaseScaffold(
            backgroundColor: AppColors.whiteColor,
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 90),
                    TextView(
                      'Create an Account',
                      textAlign: TextAlign.center,
                      color: AppColors.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 14),
                    const TextView(
                      'Hello, Welcome',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey4,
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 245,
                      width: 330,
                      child: SvgPicture.asset(
                        "assets/images/svg/ic_login_screen.svg",
                      ),
                    ),
                    const SizedBox(height: 50),
                    CustomTextField(
                      hintText: 'Email',
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                      fillColor: AppColors.lightGreyColor,
                      onValidate: (val) => ValidationUtils.validateEmail(val),
                    ),
                    const SizedBox(height: 4),
                    CustomTextField(
                      hintText: 'User Name',
                      inputType: TextInputType.emailAddress,
                      controller: userNameController,
                      fillColor: AppColors.lightGreyColor,
                      onValidate:
                          (val) => ValidationUtils.validateUserName(val),
                    ),
                    const SizedBox(height: 4),
                    CustomTextField(
                      hintText: 'Password',
                      controller: passwordController,
                      fillColor: AppColors.lightGreyColor,
                      inputType: TextInputType.visiblePassword,
                      obscureText: state.isPasswordHidden,
                      onValidate:
                          (val) => ValidationUtils.validatePassword(val),
                      suffixWidget: PasswordSuffixWidget(
                        isPasswordVisible: state.isPasswordHidden,
                        onTap: () {
                          context.read<LoginCubit>().toggleShowPassword();
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    CustomTextField(
                      hintText: 'Confirm Password',
                      controller: confirmPasswordController,
                      fillColor: AppColors.lightGreyColor,
                      inputType: TextInputType.visiblePassword,
                      obscureText: state.isPasswordHidden,
                      onValidate:
                          (val) => ValidationUtils.validatePassword(val),
                      suffixWidget: PasswordSuffixWidget(
                        isPasswordVisible: state.isPasswordHidden,
                        onTap: () {
                          context.read<LoginCubit>().toggleShowPassword();
                        },
                      ),
                    ),
                    const SizedBox(height: 44),
                    CustomButton(
                      height: 54,
                      title: 'Signup',
                      onPressed: () {
                        _onLoginButtonPressed();
                        //_showCampusesDialog();
                      },
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextView(
                          'Already Have an Account? ',
                          fontSize: 14,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                        TextView(
                          onTap: () {
                            NavRouter.push(context, LoginScreen());
                          },
                          'Login Now',
                          fontSize: 14,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
