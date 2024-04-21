import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_fonts/google_fonts.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:vendorapp/screens/login/components/my_button.dart';
import 'package:flutter/services.dart';

class ForgottenPassword extends StatefulWidget {
  const ForgottenPassword({super.key});

  @override
  State<ForgottenPassword> createState() => _ForgottenPasswordState();
}

class _ForgottenPasswordState extends State<ForgottenPassword> {
  final List<TextEditingController> _controllers =
      List.generate(5, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());
  int otp = 0;

  TextEditingController phonenumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool primaryauth = true;
  bool secondaryauth = true;

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  Widget _buildOTPField({required int index}) {
    return Container(
      width: 40,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        autofocus: index == 0, // Auto-focus the first field
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "", // Hide the counter text
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          // On change, move the focus to the next field
          if (value.length == 1 && index != _controllers.length - 1) {
            _focusNodes[index + 1].requestFocus();
          }
          if (value.isEmpty && index != 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Only allow digits
        ],
      ),
    );
  }

  void sendOTPrequest() async {
    try {
      Response<Map> response = await Dio().get(
          "https://api.semer.dev/api/password/reset",
          data: {"phone_number": phonenumber.text},
          options: new Options(contentType: "application/json"));

      print(response);
      var success = response.data?['status'];
      if (success == "success") {
        Get.snackbar("Sucess:", response.data?['data']['message']);
        setState(() {
          otp = response.data?['data']['otp'];
          primaryauth = false;
        });
        print(primaryauth);
        print(secondaryauth);
        print(otp);
      } else if (success == "error") {
        Get.snackbar("Error:", response.data!['message']);
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  void checkotp() {
    if (_controllers.length == 5) {
      int checkedindex = 0;
      String newotp = otp.toString();
      for (int i = 0; i < _controllers.length; i++) {
        if (_controllers[i].text.toString() == newotp[i]) {
          checkedindex += 1;
          if (checkedindex == _controllers.length) {
            Get.snackbar("Success", "OTP Confirmed");
            setState(() {
              secondaryauth = false;
            });
          }
        } else {
          print(otp);
          print(_controllers[0]);
          Get.snackbar("Error", "OTP doesn't match");
        }
      }
    } else {
      Get.snackbar("Alert", "Your OTP should be exactly 5 digits");
    }
  }

  void sendnewPassword() async {
    try {
      var senddata = {
        "password": password.text,
        "password_confirmation": password.text,
        "otp": otp.toString()
      };
      Response<Map> response = await Dio().post(
          "https://api.semer.dev/api/password/reset",
          data: senddata,
          options: new Options(contentType: "application/json"));
      print(response);
      var success = response.data?['status'];
      if (success == "success") {
        Get.snackbar("Successs", response.data?['data']['message']);
        Navigator.pop(context);
      } else {
        Get.snackbar("Error", response.data?['message']);
      }
    } on DioException catch (e) {
      Get.snackbar("Error", e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: secondaryauth
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 13, right: 13),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Forgot Password",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: HexColor("#44564a"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: primaryauth
                            ? Column(
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    controller: phonenumber,
                                    cursorColor: HexColor("#4f4f4f"),
                                    decoration: InputDecoration(
                                      hintText: "Phone Number",
                                      fillColor: HexColor("#f0f3f1"),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 20),
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      prefixIcon: Icon(Icons.phone),
                                      prefixIconColor: HexColor("#4f4f4f"),
                                      filled: true,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      sendOTPrequest();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 10, 10),
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 14, 0, 10),
                                        height: 55,
                                        width: 275,
                                        decoration: BoxDecoration(
                                          color: HexColor('#44564a'),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Text(
                                          'Send OTP',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Input OTP",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: HexColor("#44564a"),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              5,
                                              (index) =>
                                                  _buildOTPField(index: index)),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            checkotp();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 10, 10),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 14, 0, 10),
                                              height: 55,
                                              width: 275,
                                              decoration: BoxDecoration(
                                                color: HexColor('#44564a'),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                'Confirm OTP',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                      )
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.only(
                      top: 40.0,
                      right: 13,
                      left: 13), // Added padding for the overall container
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the start
                    children: [
                      Text(
                        "Set New Password",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: HexColor("#44564a"),
                        ),
                      ),
                      SizedBox(
                          height: 20), // Added some space for visual separation
                      TextField(
                        controller: password,
                        cursorColor: HexColor("#4f4f4f"),
                        obscureText: true, // Ensure password is obscured
                        decoration: InputDecoration(
                          hintText: "New Password",
                          fillColor: HexColor("#f0f3f1"),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            color: HexColor("#8d8d8d"),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.lock_outline),
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: confirmpassword,
                        cursorColor: HexColor("#4f4f4f"),
                        obscureText: true, // Ensure password is obscured
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          fillColor: HexColor("#f0f3f1"),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            color: HexColor("#8d8d8d"),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.lock_outline),
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        // Center the submit button
                        child: GestureDetector(
                          onTap: () {
                            if (password.text.isNotEmpty &&
                                confirmpassword.text.isNotEmpty) {
                              if (password.text == confirmpassword.text) {
                                sendnewPassword();
                              } else {
                                Get.snackbar("Error", "Passwords must match");
                              }
                            } else {
                              Get.snackbar("Error", "All fields are required");
                            }
                          },
                          child: Container(
                            height: 55,
                            width: 275,
                            alignment:
                                Alignment.center, // Center text alignment
                            decoration: BoxDecoration(
                              color: HexColor('#44564a'),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              'Submit',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
