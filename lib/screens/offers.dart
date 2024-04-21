// import 'package:ecommerce_int2/models/category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vendorapp/admin/admin-components/adminproductfinal_display.dart';
import 'package:vendorapp/admin/adminmodels/NewProduct.dart';
import 'package:vendorapp/admin/adminmodels/ProductsNew.dart';
import 'package:vendorapp/admin/adminmodels/Recievedproducts.dart';
import 'package:vendorapp/components/category_card.dart';
import 'package:vendorapp/models/category.dart';
import 'package:vendorapp/models/bundle_item.dart';
import 'package:vendorapp/models/product_details.dart';
import 'package:vendorapp/screens/productfinal_display.dart';

class AdminTabView extends StatefulWidget {
  final List<NewProducts> myproducts;

  AdminTabView({
    required this.myproducts,
  });

  @override
  State<AdminTabView> createState() => _TabViewState();
}

class _TabViewState extends State<AdminTabView> {
  int productnumber = 0;
  late bool ListisEmpty;

  List<BundleT> entryitems = [];
  int total = 0;

  @override
  void initState() {
    total = widget.myproducts.length;
    if (total == 0) {
      ListisEmpty = true;
    } else {
      ListisEmpty = false;
    }
    ListisEmpty = false;
    print("List Of Internet ${ListisEmpty}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return ListisEmpty
        ? Container(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Container(
                  child: Center(
                      child:
                          // Text(
                          //   "You have not uploaded any product yet",
                          //   style: GoogleFonts.poppins(
                          //     fontSize: 40,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.black,
                          //   ),
                          // ),
                          CircularProgressIndicator(
                    color: Colors.black,
                  )),
                )
              ]))
        : Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                Flexible(
                    child: ListView.builder(
                        itemCount: widget.myproducts.length,
                        // gridDelegate:
                        //     const SliverGridDelegateWithMaxCrossAxisExtent(
                        //   maxCrossAxisExtent: 200,
                        //   childAspectRatio: 0.55,
                        //   crossAxisSpacing: 10,
                        //   mainAxisSpacing: 20,
                        // ),
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          AdminProductFinalDisplay(
                                              myproducts:
                                                  widget.myproducts[index]))));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 0,
                                            blurRadius: 10,
                                            offset: Offset(0,
                                                4), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width:
                                                  80.0, // Adjust the image size
                                              height:
                                                  80.0, // Adjust the image size
                                              decoration: BoxDecoration(
                                                shape: BoxShape
                                                    .circle, // Makes the container circular
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "${widget.myproducts[index].supplier?.logo}"),
                                                  fit: BoxFit
                                                      .cover, // Ensures the image covers the container
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 4.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    " ${widget.myproducts[index].name}",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    " ${widget.myproducts[index].supplier?.name}",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
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
                          );
                        })),
              ],
            ),
          );
  }
}
