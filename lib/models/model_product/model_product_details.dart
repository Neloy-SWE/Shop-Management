import 'dart:convert';

class ProductDetailsModel {
  ProductDetailsModel({
    this.status,
    this.productDetailsData,
  });

  final bool? status;
  final ProductDetailsData? productDetailsData;

  factory ProductDetailsModel.fromJson(String str) => ProductDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDetailsModel.fromMap(Map<String, dynamic> json) => ProductDetailsModel(
    status: json["status"],
    productDetailsData: json["data"] == null ? null : ProductDetailsData.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": productDetailsData == null ? null : productDetailsData!.toMap(),
  };
}

class ProductDetailsData {
  ProductDetailsData({
    this.id,
    this.category,
    this.title,
    this.price,
    this.quantity,
    this.description,
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
  final String? description;
  final String? image;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory ProductDetailsData.fromJson(String str) => ProductDetailsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDetailsData.fromMap(Map<String, dynamic> json) => ProductDetailsData(
    id:json["_id"],
    category: json["category"] == null ? null : Category.fromMap(json["category"]),
    title: json["title"],
    price: json["price"],
    quantity: json["quantity"],
    description: json["description"],
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
    "description": description,
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
