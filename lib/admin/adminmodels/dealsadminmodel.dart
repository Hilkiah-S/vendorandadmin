import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Deals {
  final int id;
  final String deal;
  final String owner_id;
  final String accepted;
  final Product? product;
  final String first_page_url;
  final String next_page_url;
  final int to;
  Deals({
    required this.id,
    required this.deal,
    required this.owner_id,
    required this.accepted,
    required this.product,
    required this.first_page_url,
    required this.next_page_url,
    required this.to,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'deal': deal,
      'owner_id': owner_id,
      'accepted': accepted,
      'product': product?.toMap(),
      'first_page_url': first_page_url,
      'next_page_url': next_page_url,
      'to': to,
    };
  }

  factory Deals.fromMap(Map<String, dynamic> map) {
    return Deals(
      id: map['id'] as int,
      deal: (map['deal'] as String?) ?? '',
      owner_id: (map['owner_id'] as String?) ?? '',
      accepted: (map['accepted'] as String?) ?? '',
      product: map['product'] != null
          ? Product.fromMap(map['product'] as Map<String, dynamic>)
          : null,
      first_page_url: (map['first_page_url'] as String?) ?? '',
      next_page_url: (map['next_page_url'] as String?) ?? '',
      to: (map['to'] as int?) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Deals.fromJson(String source) =>
      Deals.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Product {
  final int id;
  final String name;
  final String description;
  final String user_id;
  final String supplier_id;
  final String sku;
  final String category_id;
  final String sub_category;
  final String unit_price;
  final String discount;
  final String is_live;

  final List<Imgs> images;
  final User user;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.user_id,
    required this.supplier_id,
    required this.sku,
    required this.category_id,
    required this.sub_category,
    required this.unit_price,
    required this.discount,
    required this.is_live,
    required this.images,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'user_id': user_id,
      'supplier_id': supplier_id,
      'sku': sku,
      'category_id': category_id,
      'sub_category': sub_category,
      'unit_price': unit_price,
      'discount': discount,
      'is_live': is_live,
      'images': images.map((x) => x.toMap()).toList(),
      'user': user.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      user_id: map['user_id'] as String,
      supplier_id: map['supplier_id'] as String,
      sku: map['sku'] as String,
      category_id: map['category_id'] as String,
      sub_category: map['sub_category'] as String,
      unit_price: map['unit_price'] as String,
      discount: map['discount'] as String,
      is_live: map['is_live'] as String,
      images: List<Imgs>.from(
        (map['images'] as List<dynamic>).map<Imgs>(
          (x) => Imgs.fromMap(x as Map<String, dynamic>),
        ),
      ),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
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
      img_url: map['img_url'] as String,
      product_id: map['product_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Imgs.fromJson(String source) =>
      Imgs.fromMap(json.decode(source) as Map<String, dynamic>);
}

class User {
  final int id;
  final String name;
  final String email;
  final String username;
  final String user_type;
  final String phone_number;
  final dynamic email_verified_at;
  final Business? business;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.user_type,
    required this.phone_number,
    required this.email_verified_at,
    required this.business,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'user_type': user_type,
      'phone_number': phone_number,
      'email_verified_at': email_verified_at,
      'business': business?.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      user_type: map['user_type'] as String,
      phone_number: map['phone_number'] as String,
      email_verified_at: map['email_verified_at'] as dynamic,
      business:
          Business.fromMap(map['business'] as Map<String, dynamic>? ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Business {
  final int id;
  final String name;
  final String address;
  final String logo;
  final String user_id;
  final String uuid;
  Business({
    required this.id,
    required this.name,
    required this.address,
    required this.logo,
    required this.user_id,
    required this.uuid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'logo': logo,
      'user_id': user_id,
      'uuid': uuid,
    };
  }

  factory Business.fromMap(Map<String, dynamic> map) {
    return Business(
      id: (map['id'] as int?) ?? 0,
      name: (map['name'] as String?) ?? '',
      address: (map['address'] as String?) ?? '',
      logo: (map['logo'] as String?) ?? '',
      user_id: (map['user_id'] as String?) ?? '',
      uuid: (map['uuid'] as String?) ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Business.fromJson(String source) =>
      Business.fromMap(json.decode(source) as Map<String, dynamic>);
}
