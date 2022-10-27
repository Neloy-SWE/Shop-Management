import 'dart:convert';

class UsersListModel {
  UsersListModel({
    this.status,
    this.userListData,
    this.paginate,
  });

  final bool? status;
  final List<UserListData>? userListData;
  final Paginate? paginate;

  factory UsersListModel.fromJson(String str) => UsersListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersListModel.fromMap(Map<String, dynamic> json) => UsersListModel(
    status: json["status"],
    userListData: json["data"] == null ? null : List<UserListData>.from(json["data"].map((x) => UserListData.fromMap(x))),
    paginate: json["paginate"] == null ? null : Paginate.fromMap(json["paginate"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": userListData == null ? null : List<dynamic>.from(userListData!.map((x) => x.toMap())),
    "paginate": paginate == null ? null : paginate!.toMap(),
  };
}

class UserListData {
  UserListData({
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

  factory UserListData.fromJson(String str) => UserListData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserListData.fromMap(Map<String, dynamic> json) => UserListData(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    city: json["city"],
    country: json["country"],
    role: json["role"],
    profileImage: json["profile_image"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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

class Paginate {
  Paginate({
    this.totalItems,
    this.limit,
    this.currentPage,
    this.totalPage,
    this.prevPage,
    this.nextPage,
  });

  final int? totalItems;
  final int? limit;
  final int? currentPage;
  final int? totalPage;
  final int? prevPage;
  final int? nextPage;

  factory Paginate.fromJson(String str) => Paginate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Paginate.fromMap(Map<String, dynamic> json) => Paginate(
    totalItems: json["total_items"],
    limit: json["limit"],
    currentPage: json["current_page"],
    totalPage: json["total_page"],
    prevPage: json["prev_page"],
    nextPage: json["next_page"],
  );

  Map<String, dynamic> toMap() => {
    "total_items": totalItems,
    "limit": limit,
    "current_page": currentPage,
    "total_page": totalPage,
    "prev_page": prevPage,
    "next_page": nextPage,
  };
}
