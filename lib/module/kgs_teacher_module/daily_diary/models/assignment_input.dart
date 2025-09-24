import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/repo/auth_repository.dart';

import '../../../../core/di/service_locator.dart';

class AssignmentInput {
  AuthRepository _repository = sl<AuthRepository>();

  int? type;
  int offSet;
  int next;

  AssignmentInput({
    this.type,
    required this.offSet,
    required this.next,
  });

  AssignmentInput copyWith({
    int? type,
    int? offSet,
    int? next,
  }) =>
      AssignmentInput(
        type: type ?? this.type,
        offSet: offSet ?? this.offSet,
        next: next ?? this.next,
      );

  Map<String, dynamic> toJson() => {
        "UC_LoginUserId": _repository.user.userId,
        "Type": type,
        "OffSet": offSet,
        "Next": next,
      };
}
