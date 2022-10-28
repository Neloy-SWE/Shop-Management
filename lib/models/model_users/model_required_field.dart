import 'dart:convert';

class UserUpdateRequiredFieldModel {
  UserUpdateRequiredFieldModel({
    this.status,
    this.errors,
  });

  final bool? status;
  final Errors? errors;

  factory UserUpdateRequiredFieldModel.fromJson(String str) =>
      UserUpdateRequiredFieldModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserUpdateRequiredFieldModel.fromMap(Map<String, dynamic> json) =>
      UserUpdateRequiredFieldModel(
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
    this.name,
    this.email,
    this.address,
    this.city,
    this.country,
  });

  final String? name;
  final String? email;
  final String? address;
  final String? city;
  final String? country;

  factory Errors.fromJson(String str) => Errors.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Errors.fromMap(Map<String, dynamic> json) => Errors(
        name: json["name"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "address": address,
        "city": city,
        "country": country,
      };
}
