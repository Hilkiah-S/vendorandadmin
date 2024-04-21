import 'dart:convert';

class NewResponseM {
  final List<NewProducts> data;
  final String path;
  final int perPage;
  final dynamic nextCursor;
  final String? nextPageUrl;
  final dynamic prevCursor;
  final String? prevPageUrl;

  NewResponseM({
    required this.data,
    required this.path,
    required this.perPage,
    this.nextCursor,
    this.nextPageUrl,
    this.prevCursor,
    this.prevPageUrl,
  });

  factory NewResponseM.fromJson(String str) =>
      NewResponseM.fromMap(json.decode(str));

  factory NewResponseM.fromMap(Map<String, dynamic> json) => NewResponseM(
        data: List<NewProducts>.from(
            json["data"].map((x) => NewProducts.fromMap(x))),
        path: json["path"],
        perPage: json["per_page"],
        nextCursor: json["next_cursor"],
        nextPageUrl: json["next_page_url"],
        prevCursor: json["prev_cursor"],
        prevPageUrl: json["prev_page_url"],
      );
}

class NewProducts {
  final int id;
  final String name;
  final String description;
  final String userId;
  final String supplierId;
  final String sku;
  final String categoryId;
  final String subCategoryId;
  final String unitPrice;
  final String discount;
  final String isLive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Supplier? supplier;
  final List<Imgs> images;
  NewProducts({
    required this.id,
    required this.name,
    required this.description,
    required this.userId,
    required this.supplierId,
    required this.sku,
    required this.categoryId,
    required this.subCategoryId,
    required this.unitPrice,
    required this.discount,
    required this.isLive,
    required this.createdAt,
    required this.updatedAt,
    required this.supplier,
    required this.images,
  });

  factory NewProducts.fromJson(String str) =>
      NewProducts.fromMap(json.decode(str));

  // factory NewProducts.fromMap(Map<String, dynamic> json) => NewProducts(
  //       id: json["id"],
  //       name: json["name"],
  //       description: json["description"],
  //       userId: json["user_id"],
  //       supplierId: json["supplier_id"],
  //       sku: json["sku"],
  //       categoryId: json["category_id"],
  //       subCategoryId: json["sub_category"],
  //       unitPrice: json["unit_price"],
  //       discount: json["discount"],
  //       isLive: json["is_live"],
  //       createdAt: DateTime.parse(json["created_at"]),
  //       updatedAt: DateTime.parse(json["updated_at"]),
  //       supplier: Supplier.fromMap(json["supplier"]),
  //       images:
  //     );
  factory NewProducts.fromMap(Map<String, dynamic> json) => NewProducts(
        id: json["id"] as int? ?? 0,
        name: json["name"] as String? ?? '',
        description: json["description"] as String? ?? '',
        userId: json["user_id"] as String? ?? '',
        supplierId: json["supplier_id"] as String? ?? '',
        sku: json["sku"] as String? ?? '',
        categoryId: json["category_id"] as String? ?? '',
        subCategoryId: json["sub_category"] as String? ?? '',
        unitPrice: json["unit_price"] as String? ?? '',
        discount: json["discount"] as String? ?? '',
        isLive: json["is_live"] as String? ?? '',
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"] as String)
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"] as String)
            : DateTime.now(),
        supplier: json["supplier"] != null
            ? Supplier.fromMap(json["supplier"] as Map<String, dynamic>)
            : null,
        images: (json['images'] as List<dynamic>?)
                ?.map((item) => Imgs.fromMap(item as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

class Supplier {
  final int id;
  final String name;
  final String address;
  final String logo;
  final String userId;
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  Supplier({
    required this.id,
    required this.name,
    required this.address,
    required this.logo,
    required this.userId,
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Supplier.fromJson(String str) => Supplier.fromMap(json.decode(str));

  factory Supplier.fromMap(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        logo: json["logo"],
        userId: json["user_id"],
        uuid: json["uuid"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromMap(json["user"]),
      );
}

class User {
  final int id;
  final String name;
  final String email;
  final String username;
  final String userType;
  final String phoneNumber;
  final dynamic emailVerifiedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.userType,
    required this.phoneNumber,
    this.emailVerifiedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        userType: json["user_type"],
        phoneNumber: json["phone_number"],
        emailVerifiedAt: json["email_verified_at"],
      );
}

class Imgs {
  final int id;
  final String img_url;
  final String product_id;
  Imgs({
    required this.id,
    required this.img_url,
    required this.product_id,
  });

  factory Imgs.fromJson(String str) => Imgs.fromMap(json.decode(str));

  factory Imgs.fromMap(Map<String, dynamic> json) => Imgs(
        id: json["id"],
        img_url: json["img_url"],
        product_id: json["product_id"],
      );
}
