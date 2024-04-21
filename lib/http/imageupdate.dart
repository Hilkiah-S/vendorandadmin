import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';

updateImages(
    List<String> imagePaths,
    String Category,
    String title,
    String description,
    int price,
    int quantity,
    int product_id,
    int discount) async {
  final dio = Dio();
  var secStore = SecureStorage();
  var token = await secStore.readSecureData('token');
  final Options options = Options(
    headers: {
      "Authorization": "Bearer ${token}",
    },
  );
  List<MultipartFile> multipartImageFiles = [];

  for (var path in imagePaths) {
    multipartImageFiles.add(await MultipartFile.fromFile(path));
  }

  var formData = FormData.fromMap({
    "name": title,
    "product_img[]": multipartImageFiles,
    "unit_price": price,
    "description": description,
    "sku": quantity,
    "sub_category": int.parse(Category),
    "discount": discount,
  });

  try {
    var response = await dio.post(
        "https://api.semer.dev/api/product/update/${product_id}",
        data: formData,
        options: options);
    print(response);
    var success = response.data!['status'];
    if (success == "success") {
      Get.snackbar("Sucess:", "Your post is uploaded");
    } else if (success == "error") {
      Get.snackbar("Error:", "Something went wrong");
    }
  } catch (e) {
    print(e);
  }
}
