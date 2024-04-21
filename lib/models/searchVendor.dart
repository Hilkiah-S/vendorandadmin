import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SearchVendorClass {
  final int id;
  final String? deal;
  final String productId;
  final String ownerId;
  final String accepted;
  final String createdAt;
  final String updatedAt;
  final ProductVendorData product;
  SearchVendorClass({
    required this.id,
    this.deal,
    required this.productId,
    required this.ownerId,
    required this.accepted,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'deal': deal,
      'productId': productId,
      'ownerId': ownerId,
      'accepted': accepted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'product': product.toMap(),
    };
  }

  factory SearchVendorClass.fromMap(Map<String, dynamic> map) {
    return SearchVendorClass(
      id: map['id'] as int,
      deal: map['deal'] != null ? map['deal'] as String : '',
      productId: map['productId'] ?? '',
      ownerId: map['ownerId'] ?? '',
      accepted: map['accepted'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      product: ProductVendorData.fromMap(
          map['product'] as Map<String, dynamic>? ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchVendorClass.fromJson(String source) =>
      SearchVendorClass.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductVendorData {
  final int id;
  final String name;
  final String description;
  final String userId;
  final String supplierId;
  final String sku;
  final String categoryId;
  final String subCategory;
  final String unitPrice;
  final String discount;
  final String isLive;
  final String createdAt;
  final String updatedAt;
  final User user;
  final Supplier supplier;
  ProductVendorData({
    required this.id,
    required this.name,
    required this.description,
    required this.userId,
    required this.supplierId,
    required this.sku,
    required this.categoryId,
    required this.subCategory,
    required this.unitPrice,
    required this.discount,
    required this.isLive,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.supplier,
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
      'subCategory': subCategory,
      'unitPrice': unitPrice,
      'discount': discount,
      'isLive': isLive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user.toMap(),
      'supplier': supplier.toMap(),
    };
  }

  factory ProductVendorData.fromMap(Map<String, dynamic> map) {
    return ProductVendorData(
      id: map['id'] as int? ??
          0, // Assuming 'id' should always be present; provide a default value of 0 if null.
      name: map['name'] as String? ??
          '', // Providing default empty string if null.
      description: map['description'] as String? ??
          '', // Providing default empty string if null.
      userId: map['userId'] as String? ??
          '', // Providing default empty string if null.
      supplierId: map['supplierId'] as String? ??
          '', // Providing default empty string if null.
      sku: map['sku'] as String? ??
          '', // Providing default empty string if null.
      categoryId: map['categoryId'] as String? ??
          '', // Providing default empty string if null.
      subCategory: map['subCategory'] as String? ??
          '', // Providing default empty string if null.
      unitPrice: map['unitPrice'] as String? ??
          '', // Providing default empty string if null.
      discount: map['discount'] as String? ??
          '', // Providing default empty string if null.
      isLive: map['isLive'] as String? ??
          '', // Providing default empty string if null.
      createdAt: map['createdAt'] as String? ??
          '', // Providing default empty string if null.
      updatedAt: map['updatedAt'] as String? ??
          '', // Providing default empty string if null.
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      supplier: Supplier.fromMap(map['supplier'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductVendorData.fromJson(String source) =>
      ProductVendorData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class User {
  final int id;
  final String name;
  final String email;
  final String username;
  final String userType;
  final String phoneNumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.userType,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'userType': userType,
      'phoneNumber': phoneNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int? ?? 0, // Providing a default value of 0 if null.
      name: map['name'] as String? ??
          '', // Providing default empty string if null.
      email: map['email'] as String? ??
          '', // Providing default empty string if null.
      username: map['username'] as String? ??
          '', // Providing default empty string if null.
      userType: map['userType'] as String? ??
          '', // Providing default empty string if null.
      phoneNumber: map['phoneNumber'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Supplier {
  final int id;
  final String name;
  final String address;
  final String logo;
  final String userId;
  final String uuid;
  final String createdAt;
  final String updatedAt;
  Supplier({
    required this.id,
    required this.name,
    required this.address,
    required this.logo,
    required this.userId,
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'logo': logo,
      'userId': userId,
      'uuid': uuid,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'] as int? ?? 0, // Providing a default value of 0 if null.
      name: map['name'] as String? ??
          '', // Providing default empty string if null.
      address: map['address'] as String? ??
          '', // Providing default empty string if null.
      logo: map['logo'] as String? ??
          '', // Providing default empty string if null.
      userId: map['userId'] as String? ??
          '', // Providing default empty string if null.
      uuid: map['uuid'] as String? ??
          '', // Providing default empty string if null.
      createdAt: map['createdAt'] as String? ??
          '', // Providing default empty string if null.
      updatedAt: map['updatedAt'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Supplier.fromJson(String source) =>
      Supplier.fromMap(json.decode(source) as Map<String, dynamic>);
}
