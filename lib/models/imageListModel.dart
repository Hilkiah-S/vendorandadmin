// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class imageListModel {
  int id;
  String img_url;
  imageListModel({
    required this.id,
    required this.img_url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'img_url': img_url,
    };
  }

  factory imageListModel.fromMap(Map<String, dynamic> map) {
    return imageListModel(
      id: map['id'] as int,
      img_url: map['img_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory imageListModel.fromJson(String source) =>
      imageListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
