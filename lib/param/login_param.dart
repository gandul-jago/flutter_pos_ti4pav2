class LoginParam {
  final String? username;
  final String? password;

  // Constructor utama
  LoginParam({
    this.username,
    this.password,
  });

  // Factory constructor untuk mengubah Map (JSON) menjadi objek LoginParam
  factory LoginParam.fromJson(Map<String, dynamic> json) {
    return LoginParam(
      username: json['username'] as String?,
      password: json['password'] as String?,
    );
  }

  // Method untuk mengubah objek LoginParam menjadi Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}