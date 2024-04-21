import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendorapp/admin/screens/adminmain.dart';
import 'package:vendorapp/auth/login_page.dart';
import 'package:vendorapp/main/main_page.dart';
import 'package:vendorapp/screens/app_properties.dart';
import 'package:vendorapp/screens/login/login.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  void navigationPage() {
    var getStorage = GetStorage();
    // if (getStorage.read('name') != null &&
    //     getStorage.read('user_type') == "supplier") {
    //   print("Inside Customer Logged in before");

    //   Navigator.of(context)
    //       .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
    // } else
    if (getStorage.read('name') != null &&
        getStorage.read('user_type') == "admin") {
      // Get.offAll(AdminMainPage());
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => AdminMainPage()));
    } else {
      // print("not a match");
      // print(getStorage.read('name') != null);
      // print("separate");
      // print(getStorage.read('user_type') == "supplier");

      // print(getStorage.read('user_type'));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    }
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
      child: Container(
        decoration:
            BoxDecoration(color: const Color.fromARGB(255, 108, 215, 111)),
        child: SafeArea(
          child: new Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Opacity(
                      opacity: opacity.value,
                      child: new Image.asset('assets/logo.png')),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: RichText(
                //     text: TextSpan(
                //         style: TextStyle(color: Colors.black),
                //         children: [
                //           TextSpan(text: 'Powered by '),
                //           TextSpan(
                //               text: 'int2.io',
                //               style: TextStyle(fontWeight: FontWeight.bold))
                //         ]),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
