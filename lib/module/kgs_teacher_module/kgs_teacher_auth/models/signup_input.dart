class SignupInput {
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String password;

  SignupInput({
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
      'password': password,
    };
  }

  factory SignupInput.fromJson(Map<String, dynamic> json) {
    return SignupInput(
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      password: json['password'] ?? '',
    );
  }
}
