// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:vendorapp/admin/screens/adminmain.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:vendorapp/main/main_page.dart';
import 'package:vendorapp/screens/login/components/login_body.dart';
import 'package:get_storage/get_storage.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  // FileModel? _imageFile;
  // FileModel? get imageFile => _imageFile;
  // void setImageFile(FileModel? file) {
  //   _imageFile = file;
  //   debugPrint("Updated ImageFile: ${imageFile!.filename}");
  //   update();
  // }

  // FileModel? _resumeFile;
  // FileModel? get resumeFile => _resumeFile;
  // void setResumeFile(FileModel? file) {
  //   _resumeFile = file;
  //   debugPrint("Updated ResumeFile: ${resumeFile!.filename}");
  //   update();
  // }

  String? _userType = "Student";
  String? get userType => _userType;
  void setUserType(String? text) {
    _userType = text;
    debugPrint("Updated userType: $userType");
    update();
  }

  String? _name;
  String? get name => _name;
  void setName(String? text) {
    _name = text;
    debugPrint("Updated name: $name");
    update();
  }

  String? _email;
  String? get email => _email;
  void setEmail(String? text) {
    _email = text;
    debugPrint("Updated email: $email");
    update();
  }

  String? _password;
  String? get password => _password;
  void setPassword(String? text) {
    _password = text;
    debugPrint("Updated password: $password");
    update();
  }

  String? _mobileNumber;
  String? get mobileNumber => _mobileNumber;
  void setMobileNumber(String? text) {
    _mobileNumber = text;
    debugPrint("Updated mobileNumber: $mobileNumber");
    update();
  }

  String? _collegeName;
  String? get collegeName => _collegeName;
  void setCollegeName(String? text) {
    _collegeName = text;
    debugPrint("Updated collegeName: $collegeName");
    update();
  }

  String? _admissionYear;
  String? get admissionYear => _admissionYear;
  void setAdmissionYear(String? text) {
    _admissionYear = text;
    debugPrint("Updated admissionYear: $admissionYear");
    update();
  }

  String? _passOutYear;
  String? get passOutYear => _passOutYear;
  void setPassOutYear(String? text) {
    _passOutYear = text;
    debugPrint("Updated passOutYear: $passOutYear");
    update();
  }

  String? _adminmessage;
  String? get adminmessage => _adminmessage;
  void setAdminMessage(String? text) {
    _adminmessage = text;
    debugPrint("Updated adminmessage: $adminmessage");
    update();
  }

  String? _adminsellingprice;
  String? get adminsellingprice => _adminsellingprice;
  void setAdminSellingPrice(String? text) {
    _adminsellingprice = text;
    debugPrint("Updated adminsellingPrice: $adminsellingprice");
    update();
  }
//   Future postSignUpDetails() async {
//     String newDocId =
//         FirebaseAuth.instance.currentUser?.uid ?? ''; // ID dokumen yang baru

// // Membuat dokumen baru dengan ID baru
//     DocumentReference newDocRef =
//         FirebaseFirestore.instance.collection('user').doc(newDocId);

//     String imageUrl = await uploadImageFile(); // Upload image and get URL

// // Menyimpan data ke dokumen baru
//     await newDocRef.set({
//       'docId': newDocId,
//       'uid': FirebaseAuth.instance.currentUser!.uid,
//       'userType': userType,
//       'name': name,
//       'email': email,
//       'password': password,
//       'mobileNumber': mobileNumber,
//       'collegeName': collegeName,
//       'imageUrl': imageUrl,
//     });

//     uploadResumeFile();
//     await Get.offAll(const HomeScreen());
//   }

  // Future<String> uploadImageFile() async {
  //   var uploadTask = await FirebaseStorage.instance
  //       .ref('files/${imageFile!.filename}')
  //       .putData(imageFile!.fileBytes);

  //   var downloadURL = await uploadTask.ref.getDownloadURL();
  //   return downloadURL.toString(); // Return the download URL
  // }

  // Future uploadResumeFile() async {
  //   await FirebaseStorage.instance
  //       .ref('files/${resumeFile!.filename}')
  //       .putData(resumeFile!.fileBytes);
  // }

  // Future<bool> registerUser(String email, String password) async {
  //   try {
  //     var response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     return true;
  //   } catch (error) {
  //     if (error is FirebaseAuthException) {
  //       Get.showSnackbar(GetSnackBar(
  //         message: error.toString(),
  //       ));
  //     }
  //   }
  //   return false;
  // }
  void sendCode(BuildContext context) async {
    try {
      Response<Map> response =
          await Dio().post("https://api.semer.dev/api/auth/register",
              data: {
                "name": name,
                "email": email,
                "username": collegeName,
                "password": password,
                "phone_number": mobileNumber,
              },
              options: new Options(contentType: "application/json"));

      print(response.data);
      var success = response.data!['status'];
      print(success);

      if (success == "error") {
        Get.snackbar("Error: ", response.data!['message']);
      } else if (success == "success") {
        Get.snackbar("Success: ", "Registered Successfully");
        // Get.offAll(LoginBodyScreen);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginBodyScreen()));
      }
    } on DioException catch (e) {
      // String errormsg = "${e}";
      // _showErrorDialog(errormsg);
      Get.snackbar("Error: ", "Check your internet connection");
    }
  }

  void sendOwnershiprequest(BuildContext context, product_id) async {
    try {
      var secStore = SecureStorage();
      var token = await secStore.readSecureData('token');
      final Options options = Options(
        headers: {
          "Authorization": "Bearer ${token}",
        },
      );
      Response<Map> response =
          await Dio().post("https://api.semer.dev/api/admin/request/ownership",
              data: {
                "deal": adminmessage,
                "selling_price": int.parse(adminsellingprice!),
                "product_id": product_id
              },
              options: options);

      print(response.data);
      var success = response.data!['status'];
      print(success);

      if (success == "error") {
        Get.snackbar("Error: ", response.data!['message']);
      } else if (success == "success") {
        Get.snackbar("Success ", "your operation is successful");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminMainPage()));
        Get.offAll(LoginBodyScreen);
      }
    } on DioException catch (e) {
      // String errormsg = "${e}";
      // _showErrorDialog(errormsg);
      Get.snackbar("Error: ", "Check your internet connection");
    }
  }

  void Loginapi() async {
    print("Login activated");
    try {
      Response<Map> response =
          await Dio().post("https://api.semer.dev/api/auth/login",
              data: {
                "username": collegeName,
                "password": password,
              },
              options: new Options(contentType: "application/json"));

      print(response.data);
      var success = response.data!['status'];

      if (success == "error") {
        print("ERROE ENTERED");
        Get.snackbar("Error:", response.data!['message']);
      } else if (success == "success") {
        var token = response.data!['data']['token'];
        var useremail = response.data!['data']['email'];
        var userphone = response.data!['data']['phone_number'];
        var username = response.data!['data']['name'];
        var customertype = response.data!['data']['user_type'];
        print(customertype);
        print(success);
        print("toekn ${token}");
        var secStore = SecureStorage();
        var getStorage = GetStorage();
        getStorage.write('name', username);
        getStorage.write('user_type', customertype);
        await secStore.writeSecureData('token', token);
        await secStore.writeSecureData('email', useremail);
        await secStore.writeSecureData('phone', userphone);
        print(await secStore.readSecureData('token'));
        print(await secStore.readSecureData('email'));
        print(await secStore.readSecureData('phone'));
        print("User TYPE");
        print(getStorage.read('user_type'));
        if (getStorage.read('user_type') == "supplier") {
          print("INSIDE IF CUSTOMER");
          Get.offAll(MainPage());
          // Get.offAll(AdminMainPage());
        }
        if (getStorage.read('user_type') == "admin") {
          print("INSIDE IF Admin");

          Get.offAll(AdminMainPage());
        }
      }
    } on DioException catch (e) {
      Get.snackbar("Error", "Check your internet connection");
    }
  }
}
