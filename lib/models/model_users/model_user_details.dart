import 'dart:convert';

class UsersDetailsModel {
  UsersDetailsModel({
    this.status,
    this.userDetailsData,
  });

  final bool? status;
  final UserDetailsData? userDetailsData;

  factory UsersDetailsModel.fromJson(String str) =>
      UsersDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersDetailsModel.fromMap(Map<String, dynamic> json) =>
      UsersDetailsModel(
        status: json["status"],
        userDetailsData:
            json["data"] == null ? null : UserDetailsData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": userDetailsData == null ? null : userDetailsData!.toMap(),
      };
}

class UserDetailsData {
  UserDetailsData({
    this.id,
    this.name,
    this.email,
    this.address,
    this.city,
    this.country,
    this.role,
    this.profileImage,
    this.createdBy,
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
  final String? role;
  final String? profileImage;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory UserDetailsData.fromJson(String str) =>
      UserDetailsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDetailsData.fromMap(Map<String, dynamic> json) => UserDetailsData(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        country: json["country"],
        role: json["role"],
        profileImage: json["profile_image"],
        createdBy: json["created_by"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "email": email,
        "address": address,
        "city": city,
        "country": country,
        "role": role,
        "profile_image": profileImage,
        "created_by": createdBy,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "__v": v,
      };
}
