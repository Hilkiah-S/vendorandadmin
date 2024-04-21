import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
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
import 'package:flutter/services.dart';

class ProductFinalDisplay extends StatefulWidget {
  ProductDetails myproducts;
  ProductFinalDisplay({required this.myproducts});

  @override
  State<ProductFinalDisplay> createState() => _ProductFinalDisplayState();
}

class _ProductFinalDisplayState extends State<ProductFinalDisplay> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List<String> adresses = [];
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController discount = TextEditingController();
  bool _canPop = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = widget.myproducts.name;
    description.text = widget.myproducts.description;
    price.text = widget.myproducts.unit_price;
    quantity.text = widget.myproducts.sku;
    discount.text = widget.myproducts.discount != null
        ? widget.myproducts.discount!
        : "null";
  }

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();

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
            Get.off(MainPage());
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
                                Get.off(MainPage()),
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
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          openImages();
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Upload",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.image,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        TextField(
                          controller: title,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.add_box),
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
                              labelText: "Item Name"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: price,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "${widget.myproducts.unit_price}",
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
                            labelText: "Price",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: quantity,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "${widget.myproducts.sku}",
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
                            labelText: "Quantity",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: discount,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d{0,2}(?:\.\d{0,2})?$')),
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              if (newValue.text.isEmpty) {
                                return newValue;
                              }
                              final double? value =
                                  double.tryParse(newValue.text);
                              if (value != null && value >= 0 && value <= 100) {
                                return newValue;
                              }
                              return oldValue;
                            }),
                          ],
                          decoration: InputDecoration(
                            hintText: "${widget.myproducts.discount}",
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
                            labelText: "Discount",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          maxLines: 4,
                          controller: description,
                          decoration: InputDecoration(
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
                            labelText: "Description",
                          ),
                        ),
                        //                   updateImages(List<String> imagePaths, String Category, String title,
                        // String description, int price, int quantity, int product_id)
                        GestureDetector(
                          onTap: () {
                            updateImages(
                              adresses,
                              widget.myproducts.sub_category,
                              title.text,
                              description.text,
                              int.parse(price.text),
                              int.parse(quantity.text),
                              widget.myproducts.id,
                              int.parse(discount.text),
                            );
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
                                "Update",
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
                            Deleteapi(widget.myproducts.id);
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
}
