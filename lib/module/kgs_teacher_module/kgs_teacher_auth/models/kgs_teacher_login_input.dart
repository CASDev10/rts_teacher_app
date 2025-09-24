import 'dart:convert';

class LoginInput {
  String userId;
  String password;
  String? fcmToken;
  String entityCode;

  LoginInput({
    required this.userId,
    required this.password,
    this.fcmToken,
    required this.entityCode,
  });


  String toRawJson() => json.encode(toJson());



  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "Password": password,
    "FcmToken": fcmToken,
    "EntityCode": entityCode,
  };
}
