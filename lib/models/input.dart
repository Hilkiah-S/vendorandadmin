import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

List<Internet> recievedList = [];
void _sendCode() async {
  var token = "27|Pchr9xHv5ORJlem3yxGmRL5yMX9JjQzmALKAClqg5583b37b";
  final Options options = Options(
    headers: {
      "Authorization": "Bearer ${token}",
    },
  );
  // Response<List> response = await Dio().post(
  //     "https://api/",
  //     data: {
  //       "username": ,
  //       "password": ,
  //     },
  //     options:options
  //         );

  // recievedList = response.data!
  //     .map((e) => Internet.fromMap(e as Map<String, dynamic>))
  //     .toList();
  // print(recievedList[0].name);

  int? price = recievedList[0].price?.isEmpty == true
      ? null
      : int.tryParse(recievedList[0].price!);
  print(price);
}

class Internet {
  List? products;
  String? name;
  String? description;
  String? price;
  Internet({
    required this.products,
    required this.name,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'products': products,
      'description': description,
      'price': price,
    };
  }

  factory Internet.fromMap(Map<String, dynamic> map) {
    return Internet(
      name: map['question'] != null ? map['name'] as String : null,
      products: map['products'] != null ? map['products'] as List : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Internet.fromJson(String source) =>
      Internet.fromMap(json.decode(source) as Map<String, dynamic>);
}
