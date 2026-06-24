class LoginDataResponse {
  final String? token;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  LoginDataResponse({
    required this.token,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory LoginDataResponse.fromJson(Map<String, dynamic> json) {
    return LoginDataResponse(
      token: json['token'],
      id: json['id'],
      firstName: json['firstName'], // Sesuaikan dengan key JSON API-mu (firstName / first_name)
      lastName: json['lastName'],   // Sesuaikan dengan key JSON API-mu (lastName / last_name)
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}