part of 'kgs_teacher_signup_cubit.dart';

enum SignupStatus {
  initial,
  loading,
  success,
  failure,
}

class SignupState {
  final SignupStatus signupStatus;
  final bool isPasswordHidden;
  final bool isAutoValidate;
  final BaseFailure failure;

  SignupState({
    required this.signupStatus,
    required this.isPasswordHidden,
    required this.isAutoValidate,
    required this.failure,
  });

  factory SignupState.initial() {
    return SignupState(
      signupStatus: SignupStatus.initial,
      isPasswordHidden: true,
      isAutoValidate: false,
      failure: const BaseFailure(),
    );
  }

  SignupState copyWith({
    SignupStatus? signupStatus,
    bool? isPasswordVisible,
    bool? isAutoValidate,
    BaseFailure? failure,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      isPasswordHidden: isPasswordVisible ?? isPasswordHidden,
      isAutoValidate: isAutoValidate ?? this.isAutoValidate,
      failure: failure ?? this.failure,
    );
  }
}
