import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:vendorapp/admin/screens/adminmain.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';

void sendDeleteproduct(BuildContext context, int item_number) async {
  final dio = Dio();
  var secStore = SecureStorage();
  var token = await secStore.readSecureData('token');
  final Options options = Options(
    headers: {
      "Authorization": "Bearer ${token}",
    },
  );
  try {
    Response<Map> response = await dio.post(
        'https://api.semer.dev/api/admin/product/delete/${item_number}',
        options: options);

    print(response);
    var success = response.data!['status'];
    if (success == "success") {
      Get.snackbar("Sucess:", response.data!['message']);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminMainPage()));
    } else if (success == "error") {
      Get.snackbar("Error:", response.data!['message']);
    }
  } on DioException catch (e) {
    print(e);
  }
}
