import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void sendOwnershiprequest(BuildContext context) async {
  try {
    Response<Map> response =
        await Dio().post("https://api.semer.dev/api/auth/register",
            data: {
              "name": "SEMER NUR",
              "email": "semernur@gmail.com",
              "username": "semernurali",
              "password": "password",
              "phone_number": "0926760003"
            },
            options: new Options(contentType: "application/json"));

    print(response);
  } on DioException catch (e) {
    print(e);
  }
}
