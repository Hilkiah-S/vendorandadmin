// ignore_for_file: public_member_api_docs, sort_constructors_first
//  {"status":"success",
//  "data":[{
//   "id":1,
//  "name":"catgeory One",
//  "icon":null,
//  "subcategory":[{"id":1,"name":"subcatgeory One","parent_id":"1","icon":null},{"id":2,"name":"SEMER NUR","parent_id":"1","icon":null}]
//  }
//  ]
//  }
import 'dart:convert';

import 'package:vendorapp/models/subCategories.dart';

class ProductCategory {
  final int id;
  final String name;
  final String? icon;
  final List<SubCat> subcategory;
  ProductCategory({
    required this.id,
    required this.name,
    this.icon,
    required this.subcategory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'icon': icon,
      'subcategory': subcategory.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      id: map['id'] as int,
      name: map['name'] as String,
      icon: map['icon'] != null ? map['icon'] as String : null,
      subcategory: List<SubCat>.from(
        (map['subcategory']).map<SubCat>(
          (x) => SubCat.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromJson(String source) =>
      ProductCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}
