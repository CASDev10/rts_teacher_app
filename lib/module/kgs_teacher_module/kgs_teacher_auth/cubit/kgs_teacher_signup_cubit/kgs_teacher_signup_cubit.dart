import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api_result.dart';
import '../../../../../core/core.dart';
import '../../../../../core/notifications/cloud_messaging_api.dart';
import '../../models/kgs_teacher_auth_response.dart';
import '../../models/signup_input.dart';
import '../../repo/auth_repository.dart';

part 'kgs_teacher_signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authenticationRepo,)
      : super(SignupState.initial());
  final AuthRepository _authenticationRepo;

  void toggleShowPassword() => emit(
    state.copyWith(
      isPasswordVisible: !state.isPasswordHidden,
      signupStatus: SignupStatus.initial,
    ),
  );

  void enableAutoValidateMode() => emit(
    state.copyWith(
      isAutoValidate: true,
      signupStatus: SignupStatus.initial,
    ),
  );

  Future signup(SignupInput signupInput) async {
    emit(state.copyWith(signupStatus: SignupStatus.loading));
    try {


      AuthResponse authResponse =
      await _authenticationRepo.signup(signupInput);
      if (authResponse.result == ApiResult.success) {
        emit(state.copyWith(signupStatus: SignupStatus.success));
      } else {
        emit(state.copyWith(
            signupStatus: SignupStatus.failure,
            failure: HighPriorityException(authResponse.message)));
      }
    } on BaseFailure catch (exception) {
      emit(state.copyWith(
          signupStatus: SignupStatus.failure,
          failure: HighPriorityException(exception.message)));
    } catch (e) {
      emit(state.copyWith(
          signupStatus: SignupStatus.failure,
          failure: HighPriorityException(e.toString())));
    }
  }
}
