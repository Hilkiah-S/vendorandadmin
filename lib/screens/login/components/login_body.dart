import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vendorapp/screens/forgotpassword.dart';
import 'package:vendorapp/screens/login/components/my_button.dart';
import 'package:vendorapp/screens/login/components//my_textfield.dart';
import 'package:vendorapp/controller/sign_up_controller.dart';
import '../../signup/sign_up.dart';
import 'package:get/get.dart';

class LoginBodyScreen extends StatefulWidget {
  const LoginBodyScreen({super.key});

  @override
  State<LoginBodyScreen> createState() => _LoginBodyScreenState();
}

class _LoginBodyScreenState extends State<LoginBodyScreen> {
  SignUpController signUpController = Get.put(SignUpController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {}

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  String _errorMessage = "";

  void validateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Username cannot be empty";
      });
    }
    // else if (!EmailValidator.validate(val, true)) {
    //   // Validasi jika email tidak valid
    //   setState(() {
    //     _errorMessage = "Email address is not valid";
    //   });
    // }
    else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 108, 215, 111),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
          shrinkWrap: true,
          reverse: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 550,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: HexColor("#ffffff"),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Log In",
                                    style: GoogleFonts.poppins(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor("#4f4f4f"),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 0, 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Username",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                      onChanged: (v) {
                                        signUpController.setCollegeName(
                                            emailController.text);
                                      },
                                      controller: emailController,
                                      hintText: "username",
                                      obscureText: false,
                                      prefixIcon: const Icon(Icons.person),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Text(
                                        _errorMessage,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Password",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: HexColor("#8d8d8d"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MyTextField(
                                      onChanged: (v) {
                                        signUpController.setPassword(
                                            passwordController.text);
                                      },
                                      controller: passwordController,
                                      hintText: "**************",
                                      obscureText: true,
                                      prefixIcon:
                                          const Icon(Icons.lock_outline),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MyButton(
                                      onPressed: () {
                                        print(signUpController.collegeName);
                                        print(signUpController.password);
                                        if (signUpController.collegeName !=
                                                null &&
                                            signUpController.password != null) {
                                          signUpController.Loginapi();
                                        } else {
                                          Get.snackbar("Error",
                                              "All field are required!");
                                        }
                                      },
                                      buttonText: 'Submit',
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Text("Don't have an account?",
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: HexColor("#8d8d8d"),
                                              )),
                                          TextButton(
                                            child: Text(
                                              "Sign up",
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: HexColor("#44564a"),
                                              ),
                                            ),
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUpScreen(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          child: Text(
                                            "Forgot password?",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgottenPassword(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -253),
                      child: Image.asset(
                        'assets/logo.png',
                        scale: 1.5,
                        width: double.infinity,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
