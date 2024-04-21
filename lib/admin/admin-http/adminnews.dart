import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';

AdminPostNews(List<String> imagePaths, String title, String description) async {
  final dio = Dio();
  var secStore = SecureStorage();
  var token = await secStore.readSecureData('token');
  // var token = "30|X4bKNsMwZWDzXbLca6d9TKlEfgnKd9Cewi0xlyWC52c54ec6";
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
    "title": title,
    "content": description,
    "image[]": multipartImageFiles,
  });

  try {
    var response = await dio.post("https://api.semer.dev/api/news/create",
        data: formData, options: options);
    print(response);
    var success = response.data!['status'];
    if (success == "success") {
      Get.snackbar("Sucess:", "Your post is uploaded");
    } else if (success == "error") {
      Get.snackbar("Error:", response.data!['message']);
    }
  } catch (e) {
    print(e);
  }
}
