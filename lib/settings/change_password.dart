import 'package:get/get.dart' hide Response;
import 'package:vendorapp/custom_background.dart';
import 'package:vendorapp/screens/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:vendorapp/settings/legal_about.dart';
import 'package:vendorapp/settings/notifications_settings.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:dio/dio.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  void changePasswordApi() async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');
    final Options options = Options(
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    try {
      var senddata = {
        "password": oldPasswordController.text,
        "current_password": newPasswordController.text
      };
      Response response = await Dio().post(
          "https://api.semer.dev/api/update_password",
          data: senddata,
          options: options);

      if (response.data['status'] == 'success') {
        Get.snackbar("Success", "Successfully changed");
      } else {
        Get.snackbar("Error", response.data['message']);
      }
    } catch (e) {
      print("Error fetching data: $e");
      // Handle the error properly
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    LinearGradient mainButtonGradient = LinearGradient(
      colors: [
        Color.fromARGB(255, 66, 74, 69),
        Color.fromARGB(255, 66, 74, 69)
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    TextStyle buttonTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
    );

    Color darkGrey = Color(0xFF313A44);

    Widget changePasswordButton = InkWell(
      onTap: () {
        if (oldPasswordController.text != "" &&
            newPasswordController.text != "" &&
            confirmNewPasswordController.text != "") {
          if (newPasswordController.text == confirmNewPasswordController.text) {
            changePasswordApi();
            print("Inside changepassword");
          } else {
            Get.snackbar("Message", "Passwords must match");
          }
        } else {
          Get.snackbar("Message", "All fields are required");
        }
      },
      child: Container(
        height: 60,
        width: width / 1.5,
        decoration: BoxDecoration(
          gradient: mainButtonGradient,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.circular(9.0),
        ),
        child: Center(
          child: Text("Confirm Change", style: buttonTextStyle),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildSectionTitle('Change Password'),
                          _buildTextFieldSection(
                            title: 'Enter your current password',
                            hint: 'Existing Password',
                            controller: oldPasswordController,
                          ),
                          _buildTextFieldSection(
                            title: 'Enter new password',
                            hint: 'New Password',
                            controller: newPasswordController,
                          ),
                          _buildTextFieldSection(
                            title: 'Retype new password',
                            hint: 'Retype Password',
                            controller: confirmNewPasswordController,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            bottom: bottomPadding != 20 ? 20 : bottomPadding,
                          ),
                          child: changePasswordButton,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 48.0, top: 16.0),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
    );
  }

  Widget _buildTextFieldSection(
      {String? title, String? hint, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24, bottom: 12.0),
          child: Text(
            title!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(fontSize: 12.0),
            ),
          ),
        ),
      ],
    );
  }
}
