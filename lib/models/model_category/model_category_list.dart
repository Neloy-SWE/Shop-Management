import 'dart:convert';

class CategoryListModel {
  CategoryListModel({
    this.status,
    this.categoryListData,
    this.paginate,
  });

  final bool? status;
  final List<CategoryListData>? categoryListData;
  final Paginate? paginate;

  factory CategoryListModel.fromJson(String str) =>
      CategoryListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryListModel.fromMap(Map<String, dynamic> json) =>
      CategoryListModel(
        status: json["status"],
        categoryListData: json["data"] == null
            ? null
            : List<CategoryListData>.from(json["data"].map((x) => CategoryListData.fromMap(x))),
        paginate: json["paginate"] == null
            ? null
            : Paginate.fromMap(json["paginate"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": categoryListData == null
            ? null
            : List<dynamic>.from(categoryListData!.map((x) => x.toMap())),
        "paginate": paginate == null ? null : paginate!.toMap(),
      };
}

class CategoryListData {
  CategoryListData({
    this.id,
    this.title,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  final String? id;
  final String? title;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory CategoryListData.fromJson(String str) => CategoryListData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryListData.fromMap(Map<String, dynamic> json) => CategoryListData(
        id: json["_id"],
        title: json["title"],
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
        "title": title,
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
