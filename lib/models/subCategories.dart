// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubCat {
  int id;
  String name;
  int parent_id;
  String? icon;

  SubCat({
    required this.id,
    required this.name,
    required this.parent_id,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parent_id': parent_id,
      'icon': icon,
    };
  }

  factory SubCat.fromMap(Map<String, dynamic> map) {
    return SubCat(
      id: map['id'] as int,
      name: map['name'] as String,
      parent_id: int.parse(map['parent_id']),
      icon: map['icon'] != null ? map['icon'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCat.fromJson(String source) =>
      SubCat.fromMap(json.decode(source) as Map<String, dynamic>);
}
