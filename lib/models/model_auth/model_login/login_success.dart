import 'dart:convert';

class LoginSuccessModel {
  LoginSuccessModel({
    this.status,
    this.token,
  });

  final bool? status;
  final String? token;

  factory LoginSuccessModel.fromJson(String str) => LoginSuccessModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginSuccessModel.fromMap(Map<String, dynamic> json) => LoginSuccessModel(
    status: json["status"],
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "token": token,
  };
}
