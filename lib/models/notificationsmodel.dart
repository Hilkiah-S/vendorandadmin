// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:vendorapp/models/product_details.dart';

class NotificationsModel {
  int id;
  String owner_id;
  String accepted;
  String deal;
  int? selling_price;
  ProductDetails? product;
  NotificationsModel({
    required this.id,
    required this.owner_id,
    required this.accepted,
    required this.deal,
    required this.product,
    required this.selling_price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'owner_id': owner_id,
      'accepted': accepted,
      'deal': deal,
      'selling_price': selling_price,
      'product': product?.toMap(),
    };
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      id: map['id'] as int,
      owner_id: map['owner_id'] as String,
      accepted: map['accepted'] as String,
      deal: (map['deal'] as String?) ?? '',
      selling_price:
          map['selling_price'] != null ? map['selling_price'] as int : null,
      product: map['product'] != null
          ? ProductDetails.fromMap(map['product'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsModel.fromJson(String source) =>
      NotificationsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
