// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminProducts {
  final List<ProductNew> data;
  final String? path;
  final int? perPage;
  final dynamic? nextCursor;
  final String? nextPageUrl;
  // final dynamic? prevCursor;
  // final String? prevPageUrl;

  AdminProducts({
    required this.data,
    required this.path,
    required this.perPage,
    this.nextCursor,
    this.nextPageUrl,
    // this.prevCursor,
    // this.prevPageUrl,
  });

  factory AdminProducts.fromJson(String str) =>
      AdminProducts.fromMap(json.decode(str));

  factory AdminProducts.fromMap(Map<String, dynamic> json) => AdminProducts(
        data: json["data"] == null
            ? [] // Provide an empty list if null
            : List<ProductNew>.from(
                json["data"].map((x) => ProductNew.fromMap(x))),
        path: json["path"] ?? '', // Provide a default empty string if null
        perPage: json["per_page"] ?? 0, // Provide a default value if null
        nextCursor: json[
            "next_cursor"], // Already nullable, no need for a default value
        nextPageUrl: json[
            "next_page_url"], // Already nullable, no need for a default value
        // Assuming you might uncomment and use these later, handle them similarly:
        // prevCursor: json["prev_cursor"],
        // prevPageUrl: json["prev_page_url"],
      );
}

class ProductNew {
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
  final Supplier supplier;
  final List<Imgs> images;
  ProductNew({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'userId': userId,
      'supplierId': supplierId,
      'sku': sku,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'unitPrice': unitPrice,
      'discount': discount,
      'isLive': isLive,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'supplier': supplier.toMap(),
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductNew.fromMap(Map<String, dynamic> map) {
    return ProductNew(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      userId: map['userId'] as String,
      supplierId: map['supplierId'] as String,
      sku: map['sku'] as String,
      categoryId: map['categoryId'] as String,
      subCategoryId: map['subCategoryId'] as String,
      unitPrice: map['unitPrice'] as String,
      discount: map['discount'] as String,
      isLive: map['isLive'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      supplier: Supplier.fromMap(map['supplier'] as Map<String, dynamic>),
      images: List<Imgs>.from(
        (map['images'] as List<int>).map<Imgs>(
          (x) => Imgs.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductNew.fromJson(String source) =>
      ProductNew.fromMap(json.decode(source) as Map<String, dynamic>);
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'logo': logo,
      'userId': userId,
      'uuid': uuid,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'user': user.toMap(),
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'] as int,
      name: map['name'] as String,
      address: map['address'] as String,
      logo: map['logo'] as String,
      userId: map['userId'] as String,
      uuid: map['uuid'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Supplier.fromJson(String source) =>
      Supplier.fromMap(json.decode(source) as Map<String, dynamic>);
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
    required this.emailVerifiedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'userType': userType,
      'phoneNumber': phoneNumber,
      'emailVerifiedAt': emailVerifiedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      userType: map['userType'] as String,
      phoneNumber: map['phoneNumber'] as String,
      emailVerifiedAt: map['emailVerifiedAt'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'img_url': img_url,
      'product_id': product_id,
    };
  }

  factory Imgs.fromMap(Map<String, dynamic> map) {
    return Imgs(
      id: map['id'] as int,
      img_url: (map['img_url'] as String?) ?? '',
      product_id: (map['product_id'] as String?) ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Imgs.fromJson(String source) =>
      Imgs.fromMap(json.decode(source) as Map<String, dynamic>);
}
