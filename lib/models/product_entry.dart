import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(
  json.decode(str).map((x) => ProductEntry.fromJson(x)),
);

List<ProductEntry> productEntryListFromDynamic(dynamic data) =>
    List<ProductEntry>.from(
      (data as List<dynamic>).map((x) => ProductEntry.fromJson(x)),
    );

String productEntryToJson(List<ProductEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
  String id;
  String name;
  int price;
  String description;
  String thumbnail;
  String category;
  bool isFeatured;
  int quantity;
  String size;
  double rating;
  int? userId;
  String? ownerUsername;

  ProductEntry({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.quantity,
    required this.size,
    required this.rating,
    required this.userId,
    this.ownerUsername,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    thumbnail: json["thumbnail"],
    category: json["category"],
    isFeatured: json["is_featured"],
    quantity: json["quantity"],
    size: json["size"],
    rating: (json["rating"] as num).toDouble(),
    userId: _parseUserId(json["user_id"] ?? json["userId"]),
    ownerUsername: json["owner_username"] ?? json["ownerUsername"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
    "thumbnail": thumbnail,
    "category": category,
    "is_featured": isFeatured,
    "quantity": quantity,
    "size": size,
    "rating": rating,
    "user_id": userId,
    "owner_username": ownerUsername,
  };
}

int? _parseUserId(dynamic raw) {
  if (raw == null) return null;
  if (raw is int) return raw;
  if (raw is num) return raw.toInt();
  if (raw is String) return int.tryParse(raw);
  return null;
}
