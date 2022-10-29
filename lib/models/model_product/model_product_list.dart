import 'dart:convert';

class ProductListModel {
  ProductListModel({
    this.status,
    this.productListData,
    this.paginate,
  });

  final bool? status;
  final List<ProductListData>? productListData;
  final Paginate? paginate;

  factory ProductListModel.fromJson(String str) => ProductListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductListModel.fromMap(Map<String, dynamic> json) => ProductListModel(
    status: json["status"],
    productListData: json["data"] == null ? null : List<ProductListData>.from(json["data"].map((x) => ProductListData.fromMap(x))),
    paginate: json["paginate"] == null ? null : Paginate.fromMap(json["paginate"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": productListData == null ? null : List<dynamic>.from(productListData!.map((x) => x.toMap())),
    "paginate": paginate == null ? null : paginate!.toMap(),
  };
}

class ProductListData {
  ProductListData({
    this.id,
    this.category,
    this.title,
    this.price,
    this.quantity,
    this.image,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  final String? id;
  final Category? category;
  final String? title;
  final int? price;
  final int? quantity;
  final String? image;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory ProductListData.fromJson(String str) => ProductListData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductListData.fromMap(Map<String, dynamic> json) => ProductListData(
    id: json["_id"],
    category: json["category"] == null ? null : Category.fromMap(json["category"]),
    title: json["title"],
    price: json["price"],
    quantity: json["quantity"],
    image: json["image"],
    createdBy: json["created_by"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "category": category == null ? null : category!.toMap(),
    "title": title,
    "price": price,
    "quantity": quantity,
    "image": image,
    "created_by": createdBy,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "__v": v,
  };
}

class Category {
  Category({
    this.id,
    this.title,
  });

  final String? id;
  final String? title;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["_id"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "title": title,
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
