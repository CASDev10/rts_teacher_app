import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api_result.dart';
import '../../../../../core/core.dart';
import '../../models/kgs_teacher_auth_response.dart';
import '../../models/kgs_teacher_login_input.dart';
import '../../repo/auth_repository.dart';

part 'kgs_teacher_login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepo) : super(LoginState.initial());
  final AuthRepository _authenticationRepo;

  void toggleShowPassword() => emit(
    state.copyWith(
      isPasswordVisible: !state.isPasswordHidden,
      loginStatus: LoginStatus.none,
    ),
  );

  void enableAutoValidateMode() =>
      emit(state.copyWith(isAutoValidate: true, loginStatus: LoginStatus.none));

  Future login(LoginInput loginInput, bool isKeepMeLoggedIn) async {
    emit(state.copyWith(loginStatus: LoginStatus.submitting));
    try {
      // String fcmToken = await _cloudMessagingApi.getFcmToken() ?? '';
      // String fcmToken = await _cloudMessagingApi.getFcmToken() ?? '';
      // print('Fcm token is ===== $fcmToken');
      loginInput.fcmToken = 'dmkdnsd';

      AuthResponse authResponse = await _authenticationRepo.login(
        loginInput,
        isKeepMeLoggedIn,
      );
      if (authResponse.result == ApiResult.success) {
        emit(state.copyWith(loginStatus: LoginStatus.success));
      } else {
        emit(
          state.copyWith(
            loginStatus: LoginStatus.failure,
            failure: HighPriorityException(authResponse.message),
          ),
        );
      }
    } on BaseFailure catch (exception) {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.failure,
          failure: HighPriorityException(exception.message),
        ),
      );
    } catch (e) {
      print(e.runtimeType);
      print(e.toString());
      emit(
        state.copyWith(
          loginStatus: LoginStatus.failure,
          failure: HighPriorityException(e.toString()),
        ),
      );
    }
  }
}
