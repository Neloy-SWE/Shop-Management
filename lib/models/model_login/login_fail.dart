import 'dart:convert';

class LoginFailModel {
  LoginFailModel({
    this.status,
    this.errors,
  });

  final bool? status;
  final Errors? errors;

  factory LoginFailModel.fromJson(String str) => LoginFailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginFailModel.fromMap(Map<String, dynamic> json) => LoginFailModel(
    status: json["status"],
    errors: json["errors"] == null ? null : Errors.fromMap(json["errors"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "errors": errors == null ? null : errors!.toMap(),
  };
}

class Errors {
  Errors({
    this.email,
    this.message,
  });

  final String? email;
  final String? message;

  factory Errors.fromJson(String str) => Errors.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Errors.fromMap(Map<String, dynamic> json) => Errors(
    email: json["email"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "message": message,
  };
}
