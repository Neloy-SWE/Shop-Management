import 'dart:convert';

class RegistrationSuccessModel {
  RegistrationSuccessModel({
    this.status,
    this.message,
    this.token,
  });

  final bool? status;
  final String? message;
  final String? token;

  factory RegistrationSuccessModel.fromJson(String str) =>
      RegistrationSuccessModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegistrationSuccessModel.fromMap(Map<String, dynamic> json) =>
      RegistrationSuccessModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "token": token,
      };
}
