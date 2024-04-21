import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:vendorapp/global/global_variables.dart';
import 'package:vendorapp/http/imageupload.dart';
import 'package:vendorapp/http/signup.dart';
import 'package:vendorapp/models/product_category.dart';
import 'package:vendorapp/screens/dropdownmenu.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vendorapp/main/main_page.dart';
import 'package:flutter/services.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final dio = Dio();

  final ImagePicker imgpicker = ImagePicker();
  int sendsubcategoryindex = 0;
  List<XFile>? imagefiles;
  List<String> adresses = [];
  List<String> items = [];
  List<List<String>> allSubcategories = [];
  List<List<String>> subcategories = [];
  List<String> categories = ["Category"];
  List<String> nosubcategoriescategories = ["No-Sub Categories"];

  String selecteddropdownValue = "";
  String selectedSubcategoryValue = "";
  TextEditingController title = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  List<String> initial = [""];
  bool _canPop = true;
  int categoryindex = 0;
  int SubCategoryIndex = 1;
  int selectedsubvategorysendindex = 0;
  List<String> getCategoriesNames(List<ProductCategory> products) {
    return products.map((product) => product.name).toList();
  }

  List<List<String>> getSubcategoriesNames(List<ProductCategory> products) {
    return products.map((product) {
      return product.subcategory.map((subCat) => subCat.name).toList();
    }).toList();
  }

  // checkIndex(String selected) {
  //   for (int i = 0; i < items.length; i++) {
  //     if (items[i] == selected) {
  //       print("found category match");
  //       if (allSubcategories[i].isEmpty) {
  //         print("IT's sub-category is Empty");
  //         setState(() {
  //           // allSubcategories[categoryindex].clear();
  //           allSubcategories[categoryindex] = nosubcategoriescategories;
  //           if (allSubcategories[categoryindex].length > 0) {
  //             selectedSubcategoryValue = allSubcategories[categoryindex][0];
  //           } else {
  //             selectedSubcategoryValue = "";
  //           }
  //         });
  //       } else {
  //         print("It's subcategory is not Empty");
  //         setState(() {
  //           categoryindex = i;
  //           // selectedSubcategoryValue = allSubcategories[categoryindex][0];
  //           if (allSubcategories[categoryindex].length > 0) {
  //             selectedSubcategoryValue = allSubcategories[categoryindex][0];
  //           } else {
  //             selectedSubcategoryValue = "";
  //           }
  //         });
  //       }
  //     }
  //   }
  // }

  void checkIndex(String selected) {
    for (int i = 0; i < items.length; i++) {
      if (items[i] == selected) {
        print("found category match");
        setState(() {
          categoryindex = i;
          if (allSubcategories[i].isEmpty) {
            print("IT's sub-category is Empty");
            selectedSubcategoryValue = "";
          } else {
            print("It's subcategory is not Empty");

            selectedSubcategoryValue =
                allSubcategories[categoryindex].isNotEmpty
                    ? allSubcategories[categoryindex][0]
                    : "";
          }
        });
      }
    }
    for (int j = 0; j < productCategories.length; j++) {
      for (int inner = 0;
          inner < productCategories[j].subcategory.length;
          inner++) {
        if (selectedSubcategoryValue ==
            productCategories[j].subcategory[inner].name) {
          setState(() {
            selectedsubvategorysendindex =
                productCategories[j].subcategory[inner].id;
          });
          break;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    items = getCategoriesNames(productCategories);
    allSubcategories = getSubcategoriesNames(productCategories);
    subcategories.add(initial);

    selecteddropdownValue = items.length > 0 ? items[0] : "";
    selectedSubcategoryValue = allSubcategories[categoryindex].length > 0
        ? allSubcategories[categoryindex][0]
        : "";
    print(selectedSubcategoryValue);
    print(allSubcategories);
    discount.text = "0";
    checkIndex(selectedSubcategoryValue);
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            if (_canPop) {
              Get.off(() => MainPage());
              return true;
            } else {
              return false;
            }
          },
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              print("Home clicked");

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => MainPage())));
                            },
                            icon: Icon(
                              Icons.home,
                              size: 30,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 300,
                                child: TextField(
                                  controller: title,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.add_box),
                                    hintText: "Title for your Product",
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
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 300,
                                child: TextField(
                                  maxLines: 4,
                                  controller: description,
                                  decoration: InputDecoration(
                                    hintText: "Description for your Product",
                                    prefixIcon: const Icon(Icons.description),
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
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Category: ",
                                  style: TextStyle(
                                      color: HexColor("#8d8d8d"), fontSize: 15),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: Text(
                                      'Select Category',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: items.map((String item) {
                                      print('debug item $item');
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      );
                                    }).toList(),
                                    value: selecteddropdownValue,
                                    onChanged: (String? value) {
                                      print('debug onchage called $value');
                                      setState(() {
                                        selecteddropdownValue = value!;
                                      });
                                      checkIndex(selecteddropdownValue);
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: HexColor("#f0f3f1"),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: MenuItemStyleData(
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sub-Category: ",
                                  style: TextStyle(
                                      color: HexColor("#8d8d8d"), fontSize: 15),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: Text(
                                      'Select Sub-Category',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: allSubcategories[categoryindex]
                                        .map((String item) {
                                      print('debug item $item');
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      );
                                    }).toList(),
                                    value: selectedSubcategoryValue,
                                    onChanged: (String? value) {
                                      print('debug onchage called $value');
                                      setState(() {
                                        selectedSubcategoryValue = value!;
                                        // SubCategoryIndex=allSubcategories[categoryindex].find() selectedSubcategoryValue
                                      });
                                      checkIndex(selectedSubcategoryValue);
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: HexColor("#f0f3f1"),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: MenuItemStyleData(
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 300,
                                child: TextField(
                                  controller: price,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Price for your Product",
                                    prefixIcon:
                                        const Icon(Icons.currency_bitcoin),
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
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 300,
                                child: TextField(
                                  controller: quantity,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Qunantity of this product",
                                    prefixIcon: const Icon(
                                        Icons.production_quantity_limits),
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
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 300,
                                child: TextField(
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
                                      if (value != null &&
                                          value >= 0 &&
                                          value <= 100) {
                                        return newValue;
                                      }
                                      return oldValue;
                                    }),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: "Discount (Percent)",
                                    prefixIcon:
                                        const Icon(Icons.discount_outlined),
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
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  openImages();
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 14, 0, 10),
                                    height: 55,
                                    width: 275,
                                    decoration: BoxDecoration(
                                      color:
                                          Color.fromRGBO(123, 120, 119, 0.694),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          SizedBox(
                            height: 5,
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
                                            children:
                                                imagefiles!.map((imageone) {
                                              return Container(
                                                  child: Card(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  height: 100,
                                                  width: 100,
                                                  child: Image.file(
                                                      File(imageone.path)),
                                                ),
                                              ));
                                            }).toList(),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              child: Image.asset(
                                                  "assets/icons/box.png"),
                                            ),
                                          ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (!adresses.isEmpty &&
                                      title.text != "" &&
                                      description.text != "" &&
                                      price.text != "" &&
                                      quantity.text != "") {
                                    showCustomDialog(context);
                                    uploadImages(
                                            adresses,
                                            selecteddropdownValue,
                                            title.text,
                                            description.text,
                                            int.parse(price.text),
                                            int.parse(quantity.text),
                                            int.parse(discount.text),
                                            selectedsubvategorysendindex)
                                        .then(
                                            (value) => Navigator.pop(context));
                                  } else {
                                    Get.snackbar(
                                        "Error", "All fields must be filled");
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 14, 0, 10),
                                    height: 55,
                                    width: 275,
                                    decoration: BoxDecoration(
                                      color: HexColor('#44564a'),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      "Post",
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // This prevents closing the dialog by tapping outside.
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async =>
              false, // This prevents closing the dialog with the back button.
          child: Dialog(
            child: Container(
              width: 300, // Fixed width
              height: 200, // Fixed height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  Center(
                      child: CircularProgressIndicator(
                    color: Colors.teal,
                  )),
                  SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: () =>
                  //       Navigator.of(context).pop(), // Close the dialog
                  //   child: Text('Close'),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
