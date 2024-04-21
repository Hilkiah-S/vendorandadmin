import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:vendorapp/screens/notifications_page.dart';

void Ownershipresponse(BuildContext context, productid) async {
  var secStore = SecureStorage();
  var token = await secStore.readSecureData('token');
  print("token on ownership response ${token}");
  final Options options = Options(
    headers: {
      "Authorization": "Bearer ${token}",
    },
  );
  var senddata = {"request_id": productid};
  Response response = await Dio().post(
      "https://api.semer.dev/api/supplier/transfer/ownership",
      data: senddata,
      options: options);

  if (response.statusCode == 200) {
    var responsedata = response.data?['data'];
    String message = responsedata['message'].toString();
    Get.snackbar("Successful", message);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: ((context) => NotificationsPage())));
  } else {
    Get.snackbar("Error", "Unsuccessful");
  }
}
