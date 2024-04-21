import 'package:flutter/material.dart';

class BundleT {
  List<String>? pics;
  String? title;
  String? description;
  int? price;

  BundleT({this.pics, this.title, this.description, this.price});

  factory BundleT.fromMap(Map<String, dynamic> map) {
    return BundleT(
      pics: map['pics'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
    );
  }
}
