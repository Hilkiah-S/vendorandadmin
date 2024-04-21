import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vendorapp/admin/admin-http/deleteproduct.dart';
import 'package:vendorapp/admin/adminmodels/NewProduct.dart';
import 'package:vendorapp/admin/adminmodels/ProductsNew.dart';
import 'package:vendorapp/admin/adminmodels/Recievedproducts.dart';
import 'package:vendorapp/admin/screens/adminmain.dart';
import 'package:vendorapp/http/delete.dart';
import 'package:vendorapp/http/imageupdate.dart';
import 'package:vendorapp/main/main_page.dart';
import 'package:vendorapp/models/bundle_item.dart';
import 'package:vendorapp/models/imageListModel.dart';
import 'package:vendorapp/models/product_details.dart';
import 'package:vendorapp/screens/login/components/my_button.dart';
import 'package:vendorapp/screens/login/components/my_textfield.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendorapp/controller/sign_up_controller.dart';

class AdminProductFinalDisplay extends StatefulWidget {
  NewProducts myproducts;
  AdminProductFinalDisplay({required this.myproducts});

  @override
  State<AdminProductFinalDisplay> createState() =>
      _AdminProductFinalDisplayState();
}

class _AdminProductFinalDisplayState extends State<AdminProductFinalDisplay> {
  final messageController = TextEditingController().obs;

  SignUpController signUpController = Get.put(SignUpController());
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List<String> adresses = [];
  TextEditingController title = TextEditingController();
  // TextEditingController message = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController suggestedprice = TextEditingController();
  bool _canPop = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = widget.myproducts.name;
    description.text = widget.myproducts.description;
    price.text = widget.myproducts.unitPrice;
    quantity.text = widget.myproducts.sku;
    discount.text = widget.myproducts.discount;
  }

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;

        setState(() {});
        adresses.clear();
        adresses = imagefiles!.map((imageone) => imageone.path).toList();
        print(adresses);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_canPop) {
            Get.off(AdminMainPage());
            return true;
          } else {
            return false;
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => {
                                Get.off(AdminMainPage()),
                              },
                          icon: Icon(Icons.arrow_back)),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 4),
                        viewportFraction: 1.0,
                      ),
                      items: widget.myproducts.images.map<Widget>((image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: BoxDecoration(),
                              child: Image.network(
                                image.img_url,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                      // [Image.network(widget.myproducts.supplier.logo)],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        TextField(
                          enabled: false,
                          controller: title,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            // Add a label here
                            hintText: "${widget.myproducts.supplier?.name}",
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
                            filled: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          enabled: false,
                          controller: title,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.add_box),
                            // Add a label here
                            hintText: "${widget.myproducts.name}",
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
                            filled: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          enabled: false,
                          controller: price,
                          decoration: InputDecoration(
                            // Add a label here
                            hintText: "${widget.myproducts.unitPrice} ETB",
                            prefixIcon: const Icon(Icons.currency_bitcoin),
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
                            filled: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          enabled: false,
                          controller: quantity,
                          decoration: InputDecoration(
                            // Add a label here
                            hintText: "${widget.myproducts.sku} Products",
                            prefixIcon:
                                const Icon(Icons.production_quantity_limits),
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
                            filled: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          enabled: false,
                          controller: discount,
                          decoration: InputDecoration(
                            // Add a label here
                            hintText:
                                "${widget.myproducts.discount} ETB Discount",
                            prefixIcon: const Icon(Icons.discount),
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
                            filled: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          enabled: false,
                          maxLines: 4,
                          controller: description,
                          decoration: InputDecoration(
                            // Add a label here
                            hintText: "${widget.myproducts.description}",
                            prefixIcon: const Icon(Icons.description),
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
                            filled: true,
                          ),
                        ),
                        //                   updateImages(List<String> imagePaths, String Category, String title,
                        // String description, int price, int quantity, int product_id)
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          onChanged: (value) {
                            signUpController.setAdminMessage(value);
                          },
                          maxLines: 3,
                          controller: messageController.value,
                          decoration: InputDecoration(
                            // Add a label here
                            hintText:
                                "Enter a message including your suggested price",
                            prefixIcon: const Icon(Icons.message_outlined),
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
                            filled: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: suggestedprice,
                          onChanged: (value) {
                            signUpController.setAdminSellingPrice(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.currency_bitcoin,
                              color: Colors.teal,
                            ),
                            // Add a label here
                            hintText: "Re-enter the price only",
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
                            filled: true,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (suggestedprice.text != "") {
                              signUpController.sendOwnershiprequest(
                                  context, widget.myproducts.id);
                            } else {
                              Get.snackbar(
                                  "Message", "Selling price is required");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 14, 0, 10),
                              height: 55,
                              width: 275,
                              decoration: BoxDecoration(
                                color: HexColor('#44564a'),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                "Send",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print(widget.myproducts.id);
                            // Deleteapi(widget.myproducts.id);
                            // sendDeleteproduct(context, widget.myproducts.id);
                            showDeleteConfirmationDialog(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 14, 0, 10),
                              height: 55,
                              width: 275,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                "Delete",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Repost(String title, String description, int price, int quantity, int subcat,
  //     int discount) async {
  //   final dio = Dio();
  //   var secStore = SecureStorage();
  //   var token = await secStore.readSecureData('token');
  //   final Options options = Options(
  //     headers: {
  //       "Authorization": "Bearer ${token}",
  //     },
  //   );

  //   try {
  //     var response = await dio.post(
  //         "https://api.semer.dev/api/product/update/${widget.myproducts.id}",
  //         data: {
  //           "name": title,
  //           "unit_price": price,
  //           "description": description,
  //           "sku": quantity,
  //           "sub_category": subcat,
  //           "discount": discount,
  //         },
  //         options: options);
  //     print(response.data);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // This function can be called when the delete button is clicked.
  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    // Show the dialog
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // The user must tap a button to dismiss the dialog.
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                sendDeleteproduct(context, widget.myproducts.id);
              },
            ),
          ],
        );
      },
    );
  }
}
