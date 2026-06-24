import 'package:pmp12project/response/login_data_response.dart';

class LoginResponse {
  final String? message;
  final LoginDataResponse? data;

  LoginResponse({
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      data: json['data'] != null ? LoginDataResponse.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.toJson(), // Mengubah objek data kembali menjadi Map JSON
    };
  }
}