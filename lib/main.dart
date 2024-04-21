import 'package:get/get.dart';
import 'package:vendorapp/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  // await Hive.initFlutter();
  // var box = Hive.openBox('UserBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'vendorapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.teal,
        fontFamily: "Montserrat",
      ),
      home: SplashScreen(),
    );
  }
}
