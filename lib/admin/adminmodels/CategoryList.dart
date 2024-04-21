import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AdminCatagoryListModel {
  final int id;
  final String name;
  final List<AdminSubCatagoryListModel> subcategory;
  AdminCatagoryListModel({
    required this.id,
    required this.name,
    required this.subcategory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'subcategory': subcategory.map((x) => x.toMap()).toList(),
    };
  }

  factory AdminCatagoryListModel.fromMap(Map<String, dynamic> map) {
    return AdminCatagoryListModel(
      id: map['id'] as int,
      name: map['name'] as String,
      subcategory: List<AdminSubCatagoryListModel>.from(
        (map['subcategory'] as List<dynamic>).map<AdminSubCatagoryListModel>(
          (x) => AdminSubCatagoryListModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminCatagoryListModel.fromJson(String source) =>
      AdminCatagoryListModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class AdminSubCatagoryListModel {
  final int id;
  final String name;
  final String parent_id;
  AdminSubCatagoryListModel({
    required this.id,
    required this.name,
    required this.parent_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parent_id': parent_id,
    };
  }

  factory AdminSubCatagoryListModel.fromMap(Map<String, dynamic> map) {
    return AdminSubCatagoryListModel(
      id: map['id'] as int,
      name: map['name'] as String,
      parent_id: map['parent_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminSubCatagoryListModel.fromJson(String source) =>
      AdminSubCatagoryListModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
