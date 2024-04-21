import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:vendorapp/main/main_page.dart';

void Deleteapi(int productid) async {
  print("Delete activated");
  var secStore = SecureStorage();
  var token = await secStore.readSecureData('token');
  final Options options = Options(
    headers: {
      "Authorization": "Bearer ${token}",
    },
  );
  try {
    Response<Map> response = await Dio().post(
        "https://api.semer.dev/api/product/delete/${productid}",
        options: options);

    print(response.data);
    var success = response.data!['status'];

    print(success);

    if (success == "error") {
      Get.snackbar("Error:", response.data!['message']);
    } else if (success == "success") {
      Get.snackbar("Success", "Delete Successful");
      Get.off(MainPage());
    }
  } on DioException catch (e) {
    Get.snackbar("Error", "Check your internet connection");
  }
}
