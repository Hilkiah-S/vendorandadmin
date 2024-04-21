import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_fonts/google_fonts.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:vendorapp/admin/admin-http/adminnews.dart';

class Newsposting extends StatefulWidget {
  const Newsposting({super.key});

  @override
  State<Newsposting> createState() => _NewspostingState();
}

class _NewspostingState extends State<Newsposting> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List<String> adresses = [];
  List<String> items = [];
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
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "NEWS",
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: title,
                    decoration: InputDecoration(
                      // Add a label here
                      hintText: "Your News Title",
                      prefixIcon: const Icon(Icons.title),
                      fillColor: HexColor("#f0f3f1"),
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                    height: 15,
                  ),
                  TextField(
                    maxLines: 5,
                    controller: description,
                    decoration: InputDecoration(
                      // Add a label here
                      hintText: "Your News Content",
                      prefixIcon: const Icon(Icons.dock),
                      fillColor: HexColor("#f0f3f1"),
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                    height: 15,
                  ),
                  Container(
                    width: 300,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            imagefiles != null
                                ? Wrap(
                                    alignment: WrapAlignment.start,
                                    children: imagefiles!.map((imageone) {
                                      return Container(
                                          child: Card(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          height: 100,
                                          width: 100,
                                          child:
                                              Image.file(File(imageone.path)),
                                        ),
                                      ));
                                    }).toList(),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      child:
                                          Image.asset("assets/icons/box.png"),
                                    ),
                                  ),
                          ]),
                    ),
                  ),
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
                          // color: Color.fromRGBO(123, 120, 119, 0.694),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Browse",
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
                  GestureDetector(
                    onTap: () {
                      if (adresses != null &&
                          title.text != null &&
                          description.text != null) {
                        AdminPostNews(adresses, title.text, description.text);
                      } else {
                        Get.snackbar("Error", "All fields must be filled");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 14, 0, 10),
                        height: 55,
                        width: 275,
                        decoration: BoxDecoration(
                          // color: Color.fromRGBO(123, 120, 119, 0.694),
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Post",
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
                              Icons.send,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
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
}
