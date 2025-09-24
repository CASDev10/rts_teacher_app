import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/repo/auth_repository.dart';

import '../../../../core/di/service_locator.dart';

class ParentFileInput {
  final AuthRepository _authRepository = sl<AuthRepository>();
  int? type;
  int offSet;
  int next;

  ParentFileInput({
    required this.type,
    required this.offSet,
    required this.next,
  });

  ParentFileInput copyWith({
    int? type,
    int? offSet,
    int? next,
  }) =>
      ParentFileInput(
        type: type ?? this.type,
        offSet: offSet ?? this.offSet,
        next: next ?? this.next,
      );

  Map<String, dynamic> toJson() => {
        "UC_LoginUserId": _authRepository.user.userId,
        // "UC_LoginUserId": 1,
        "Type": type,
        "OffSet": offSet,
        "Next": next,
      };
}
