import 'dart:convert';

class ResetModel {
  ResetModel({
    this.status,
    this.message,
  });

  final bool? status;
  final String? message;

  factory ResetModel.fromJson(String str) => ResetModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResetModel.fromMap(Map<String, dynamic> json) => ResetModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
  };
}
