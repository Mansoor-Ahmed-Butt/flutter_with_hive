class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  // Convert to JSON (useful for APIs)
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }

  // Create from JSON (useful if you save/restore login info)
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json["email"] ?? "",
      password: json["password"] ?? "",
    );
  }
}
