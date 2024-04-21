import 'dart:convert';

import 'package:vendorapp/models/imageListModel.dart';

class ProductDetails {
  int id;
  String name;
  String description;
  String user_id;
  String supplier_id;
  String sku;
  String category_id;
  String sub_category;
  String unit_price;
  String? discount;
  List<imageListModel> images;
  ProductDetails({
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
    required this.images,
  });
  bool matchesCategoryAndSubcategory(int categoryID) {
    return int.parse(category_id) == categoryID;
  }

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
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductDetails.fromMap(Map<String, dynamic> map) {
    return ProductDetails(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      user_id: map['user_id'] as String,
      supplier_id: map['supplier_id'] as String,
      sku: map['sku'] as String,
      category_id: map['category_id'] as String,
      sub_category: map['sub_category'] as String,
      unit_price: map['unit_price'] as String,
      discount: map['discount'] != null ? map['discount'] as String : null,
      images: List<imageListModel>.from(
        (map['images'] as List<dynamic>).map<imageListModel>(
          (x) => imageListModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetails.fromJson(String source) =>
      ProductDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
