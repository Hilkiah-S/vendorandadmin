// import 'package:ecommerce_int2/models/category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vendorapp/components/category_card.dart';
import 'package:vendorapp/models/category.dart';
import 'package:vendorapp/models/bundle_item.dart';
import 'package:vendorapp/models/product_details.dart';
import 'package:vendorapp/screens/productfinal_display.dart';
import 'package:vendorapp/global/global_variables.dart';
// import 'category_card.dart';
// import 'recommended_list.dart';

class TabView extends StatefulWidget {
  final TabController tabController;
  final List<ProductDetails> myproducts;

  TabView({
    required this.tabController,
    required this.myproducts,
  });

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int productnumber = 0;
  late bool ListisEmpty;
  List<String> items = ["bag_1.png", "bag_2.png", "bag_3.png"];

  List<BundleT> entryitems = [];
  int total = 0;
  List<Category> categories = [
    Category(
      Color(0xffFCE183),
      'Gadgets',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffF749A2),
      'Clothes',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff5189EA),
      'Fashion',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff632376),
      'Home',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff36E892),
      'Beauty',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffF123C4),
      'Appliances',
      'assets/jeans_5.png',
    ),
  ];
  List<ProductDetails> getFilteredProducts(int id) {
    print("Print ID");
    print(id);
    return productDetailList
        .where((product) => product.matchesCategoryAndSubcategory(id))
        .toList();
  }

  @override
  void initState() {
    total = widget.myproducts.length;
    if (total == 0) {
      ListisEmpty = true;
    } else {
      ListisEmpty = false;
    }
    print("List Of Internet ${ListisEmpty}");

    entryitems.add(BundleT.fromMap({
      'pics': items,
      'title': "Bag",
      'description': "High end leather Bag",
      'price': 2000
    }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: widget.tabController,
        children: productCategories.map((e) {
          var listOfCategoryProduct = getFilteredProducts(e.id);
          return listOfCategoryProduct.length == 0
              ? Container(
                  child: Center(
                    child: Text("No product Uploaded"),
                  ),
                )
              : Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 16.0,
                      ),
                      Flexible(
                          child: GridView.builder(
                              itemCount: listOfCategoryProduct.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 0.55,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 8,
                              ),
                              itemBuilder: (_, index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print("One Box");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductFinalDisplay(
                                                          myproducts:
                                                              listOfCategoryProduct[
                                                                  index])));
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 250,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                offset: Offset(0, 4),
                                                blurRadius: 6,
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex:
                                                    2, // Adjusted flex ratio for image to text content
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              20)),
                                                  child: Image.network(
                                                    "${listOfCategoryProduct[index].images[0].img_url}",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 12.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        " ${listOfCategoryProduct[index].name}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        " ${listOfCategoryProduct[index].unit_price} ETB",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                    ],
                  ),
                );
        }).toList()
        // <Widget>[
        //   ListisEmpty
        //       ? Container(
        //           child:
        //               Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        //           Center(
        //             child: Text(
        //               "You have not uploaded any product yet",
        //               style: GoogleFonts.poppins(
        //                 fontSize: 40,
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.black,
        //               ),
        //             ),
        //           )
        //         ]))
        //       : Container(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: <Widget>[

        //               SizedBox(
        //                 height: 16.0,
        //               ),
        //               Flexible(
        //                   child: GridView.builder(
        //                       itemCount: widget.myproducts.length,
        //                       gridDelegate:
        //                           const SliverGridDelegateWithMaxCrossAxisExtent(
        //                         maxCrossAxisExtent: 200,
        //                         childAspectRatio: 0.55,
        //                         crossAxisSpacing: 10,
        //                         mainAxisSpacing: 8,
        //                       ),
        //                       itemBuilder: (_, index) {
        //                         return Container(
        //                           child: Column(
        //                             children: [
        //                               GestureDetector(
        //                                 onTap: () {
        //                                   print("One Box");
        //                                   Navigator.push(
        //                                       context,
        //                                       MaterialPageRoute(
        //                                           builder: (context) =>
        //                                               ProductFinalDisplay(
        //                                                   myproducts:
        //                                                       widget.myproducts[
        //                                                           index])));
        //                                 },
        //                                 child: Container(
        //                                   width: 150,
        //                                   height: 250,
        //                                   decoration: BoxDecoration(
        //                                     borderRadius: BorderRadius.all(
        //                                         Radius.circular(20)),
        //                                     color: Colors.white,
        //                                     boxShadow: [
        //                                       BoxShadow(
        //                                         color: Colors.grey
        //                                             .withOpacity(0.5),
        //                                         offset: Offset(0, 4),
        //                                         blurRadius: 6,
        //                                         spreadRadius: 0,
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   child: Column(
        //                                     children: [
        //                                       Expanded(
        //                                         flex:
        //                                             2, // Adjusted flex ratio for image to text content
        //                                         child: ClipRRect(
        //                                           borderRadius:
        //                                               BorderRadius.vertical(
        //                                                   top: Radius.circular(
        //                                                       20)),
        //                                           child: Image.network(
        //                                             "${widget.myproducts[index].images[0].img_url}",
        //                                             fit: BoxFit.cover,
        //                                           ),
        //                                         ),
        //                                       ),
        //                                       Expanded(
        //                                         child: Padding(
        //                                           padding: const EdgeInsets
        //                                               .symmetric(
        //                                               horizontal: 8.0,
        //                                               vertical: 12.0),
        //                                           child: Column(
        //                                             mainAxisAlignment:
        //                                                 MainAxisAlignment
        //                                                     .spaceAround,
        //                                             crossAxisAlignment:
        //                                                 CrossAxisAlignment
        //                                                     .start,
        //                                             children: [
        //                                               Text(
        //                                                 " ${widget.myproducts[index].name}",
        //                                                 style: TextStyle(
        //                                                   fontSize: 16,
        //                                                   fontWeight:
        //                                                       FontWeight.bold,
        //                                                 ),
        //                                                 maxLines: 1,
        //                                                 overflow: TextOverflow
        //                                                     .ellipsis,
        //                                               ),
        //                                               Text(
        //                                                 " ${widget.myproducts[index].unit_price} ETB",
        //                                                 style: TextStyle(
        //                                                   fontSize: 15,
        //                                                   color:
        //                                                       Colors.grey[600],
        //                                                 ),
        //                                               ),
        //                                             ],
        //                                           ),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         );
        //                       })),
        //             ],
        //           ),
        //         ),

        // ]

        );
  }
}
