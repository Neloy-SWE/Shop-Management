// To parse this JSON data, do
//
//     final shopInfoModel = shopInfoModelFromMap(jsonString);

import 'dart:convert';

class ShopInfoModel {
  ShopInfoModel({
    this.status,
    this.shopInfoData,
  });

  final bool? status;
  final ShopInfoData? shopInfoData;

  factory ShopInfoModel.fromJson(String str) => ShopInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShopInfoModel.fromMap(Map<String, dynamic> json) => ShopInfoModel(
    status: json["status"],
    shopInfoData: json["data"] == null ? null : ShopInfoData.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": shopInfoData == null ? null : shopInfoData!.toMap(),
  };
}

class ShopInfoData {
  ShopInfoData({
    this.id,
    this.name,
    this.email,
    this.address,
    this.city,
    this.country,
    this.emailVerified,
    this.role,
    this.profileImage,
    this.coverImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final bool? emailVerified;
  final String? role;
  final String? profileImage;
  final String? coverImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory ShopInfoData.fromJson(String str) => ShopInfoData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShopInfoData.fromMap(Map<String, dynamic> json) => ShopInfoData(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    city: json["city"],
    country: json["country"],
    emailVerified: json["email_verified"],
    role: json["role"],
    profileImage: json["profile_image"],
    coverImage: json["cover_image"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "email": email,
    "address": address,
    "city": city,
    "country": country,
    "email_verified": emailVerified,
    "role": role,
    "profile_image": profileImage,
    "cover_image": coverImage,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "__v": v,
  };
}
