import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:vendorapp/admin/admin-components/admindeals.dart';
import 'package:vendorapp/admin/admin-components/custom_background.dart';
import 'package:vendorapp/admin/admin-components/custom_bottom_bar.dart';
import 'package:vendorapp/admin/admin-components/displaygraph.dart';
import 'package:vendorapp/admin/admin-components/newspost.dart';
import 'package:vendorapp/admin/admin-components/notifications_page.dart';
import 'package:vendorapp/admin/admin-components/search_pageadmin.dart';
import 'package:vendorapp/admin/adminmodels/NewProduct.dart';
import 'package:vendorapp/admin/adminmodels/ProductsNew.dart';
import 'package:vendorapp/admin/adminmodels/Recievedproducts.dart';
import 'package:vendorapp/admin/pages/adminproductitems.dart';
import 'package:vendorapp/admin/pages/viewcategories.dart';
import 'package:vendorapp/components/custom_bottom_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vendorapp/components/product_list.dart';
import 'package:vendorapp/components/profile_page.dart';
import 'package:vendorapp/components/tab_view.dart';
import 'package:vendorapp/custom_background.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:vendorapp/models/product_category.dart';
import 'package:vendorapp/models/product_details.dart';
import 'package:vendorapp/models/subCategories.dart';
import 'package:vendorapp/screens/app_properties.dart';
import 'package:vendorapp/screens/create_post.dart';
import 'package:dio/dio.dart';
import 'package:vendorapp/screens/notifications_page.dart';
import 'package:vendorapp/global/global_variables.dart';
import 'dart:convert';

import 'package:vendorapp/screens/postcomment.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage>
    with TickerProviderStateMixin<AdminMainPage> {
  bool recievedTabs = false;
  bool recievedProducts = false;
  bool recievedProductsDetails = false;
  late bool tabsAndProucts = recievedProducts && recievedTabs;
  late TabController tabController;
  late TabController bottomTabController;
  int numberOfCategory = 5;
  List<Product> alldata = [];

  List<ProductDetails> productDetailList = [];
  @override
  void initState() {
    super.initState();
    // void getTabs() async {
    //   var secStore = SecureStorage();
    //   var token = await secStore.readSecureData('token');
    //   print("token on main page ${token}");
    //   final Options options = Options(
    //     headers: {
    //       "Authorization": "Bearer ${token}",
    //     },
    //   );
    //   Response<Map> response = await Dio()
    //       .get("https://api.semer.dev/api/admin/category", options: options);

    //   if (!(response.data == null)) {
    //     setState(() {
    //       recievedTabs = true;
    //     });
    //   }
    //   List<dynamic> dataList = response.data?['data'];

    //   productCategories =
    //       dataList.map((e) => ProductCategory.fromMap(e)).toList();
    //   print("CAtegories");
    //   print(productCategories.map((e) => e.name));
    //loop
    // List<Widget> dropdowns
    // for (var product in productCategories) {

    // }
    //   setState(() {
    //     numberOfCategory = productCategories.length;
    //   });
    // }

    void getmyProducts() async {
      var secStore = SecureStorage();
      var token = await secStore.readSecureData('token');
      print("token on main page ${token}");
      final Options options = Options(
        headers: {
          "Authorization": "Bearer ${token}",
        },
      );
      Response<Map> response = await Dio().get(
          "https://api.semer.dev/api/admin/products?type=live",
          options: options);
      print(response);
      if (response.data != null && response.data?['status'] == 'success') {
        print(response);
        setState(() {
          recievedProducts = true;
        });
      }
      List<dynamic> dataList = response.data?['data']['data'];
      print("Printing dataList");
      print(dataList[0]);
      if (dataList != null) {
        // alldata = dataList.map((e) => ResponseModel.fromMap(e)).toList();
        // alldata = dataList.map((productMap) {
        //   return ResponseModel.fromMap(productMap);
        // }).toList();
      }
      setState(() {
        this.alldata = alldata;
      });
      // alldata = response.data?['data']['data'];

      print("List of response");
      // print(alldata[0].data[0].name);
      // productCategories =
      //     dataList.map((e) => ProductCategory.fromMap(e)).toList();

      // print(productCategories.map((e) => e.name));
      //loop
      // List<Widget> dropdowns
      // for (var product in productCategories) {

      // }
    }

    void getmyProducts2() async {
      var secStore = SecureStorage();
      var token = await secStore.readSecureData('token');
      final Options options = Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      try {
        Response response = await Dio()
            .get("https://api.semer.dev/api/admin/products", options: options);

        if (response.data != null && response.data['status'] == 'success') {
          var responseData = response.data['data'];

          if (responseData != null && responseData['data'] != null) {
            List<dynamic> productList = responseData['data'];

            List<Product> alldata = productList.map((productMap) {
              return Product.fromMap(productMap);
            }).toList();

            setState(() {
              this.alldata = alldata;
              recievedProducts = true;
            });

            print("First Product Name: ${alldata[0].name}");
          }
        }
      } catch (e) {
        print("Error fetching data: $e");
        // Handle the error properly
      }
    }

    // void getmyProducts3() async {
    //   var secStore = SecureStorage();
    //   var token = await secStore.readSecureData('token');
    //   final Options options = Options(
    //     headers: {
    //       "Authorization": "Bearer $token",
    //     },
    //   );

    //   try {
    //     Response<Map> response = await Dio()
    //         .get("https://api.semer.dev/api/admin/products", options: options);

    //     if (response.data != null && response.data!['status'] == 'success') {
    //       var responseData = response.data?['data'];
    //       List<dynamic> productList = responseData['data'];

    //       adminproducts = productList.map((productMap) {
    //         return ProductNew.fromMap(productMap);
    //       }).toList();

    //       setState(() {
    //         recievedProducts = true;
    //       });

    //       print("First Product Name: ${alldata[0].name}");
    //     }
    //   } catch (e) {
    //     print("Error fetching data: $e");
    //     // Handle the error properly
    //   }
    // }
    // void getProductdetails() async {
    //   var secStore = SecureStorage();
    //   var token = await secStore.readSecureData('token');
    //   print("token on main page ${token}");
    //   final Options options = Options(
    //     headers: {
    //       "Authorization": "Bearer ${token}",
    //     },
    //   );
    //   Response<Map> response = await Dio()
    //       .get("https://api.semer.dev/api/supplier", options: options);

    //   List<dynamic> product_Details = response.data?['data'];
    //   print(product_Details.runtimeType);
    //   productDetailList =
    //       product_Details.map((e) => ProductDetails.fromMap(e)).toList();
    //   print("Product Details");
    //   print(productDetailList.map((e) => e.name));
    //   print(productDetailList.map((e) => e.description));
    //   print(productDetailList.map((e) => e.images[0].img_url));
    //   if (!(response.data == null)) {
    //     setState(() {
    //       recievedProductsDetails = true;
    //     });
    //   }
    // }

    void getmyProducts4() async {
      var secStore = SecureStorage();
      var token = await secStore.readSecureData('token');
      final Options options = Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      try {
        Response response = await Dio()
            .get("https://api.semer.dev/api/admin/products", options: options);

        if (response.data != null && response.data['status'] == 'success') {
          var responseData = response.data['data'];

          if (responseData != null && responseData['data'] != null) {
            List<dynamic> productList = responseData['data'];

            adminproducts = productList.map((productMap) {
              return NewProducts.fromMap(productMap);
            }).toList();

            setState(() {
              // this.alldata = alldata;

              recievedProducts = true;
            });

            print("First Product Name: ${alldata[0].name}");
          }
        }
      } catch (e) {
        print("Error fetching data: $e");
        // Handle the error properly
      }
    }

    // getmyProducts2();
    getmyProducts4();
    // getTabs();
    // getmyProducts();
    // getProductdetails();

    // getTabs();

    tabController = TabController(length: numberOfCategory, vsync: this);
    bottomTabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              IconButton(
                  onPressed: () => {
                        // Get.off(() => NotificationsPageAdmin()),
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NotificationsPageAdmin())),
                      },
                  icon: Icon(Icons.notifications)),
              SizedBox(
                width: 5,
              ),
              IconButton(
                  onPressed: () => {
                        // Get.off(() => NotificationsPageAdmin()),
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AdminViewCategories())),
                      },
                  icon: Icon(Icons.settings)),
            ],
          ),
          IconButton(
              onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchPageAdmin())),
                  },
              icon: SvgPicture.asset('assets/icons/search_icon.svg'))
        ],
      ),
    );

    Widget stats = DashboardStatistics();
    Widget details = AdminTabView(myproducts: adminproducts);
    // GridView.builder(
    //   padding: const EdgeInsets.all(6),
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2, // Number of columns
    //     crossAxisSpacing: 4, // Horizontal space between items
    //     mainAxisSpacing: 8, // Vertical space between items
    //     childAspectRatio: 0.7, // Aspect ratio of each item
    //   ),
    //   itemCount: 4, // Number of items in the grid
    //   itemBuilder: (context, index) {
    //     // For each cell in the grid, return an animated chart or other widget
    //     return

    //     Container(
    //       margin: EdgeInsets.all(16.0),
    //       padding: EdgeInsets.all(24.0),
    //       constraints: BoxConstraints(maxWidth: 600),
    //       decoration: BoxDecoration(
    //         color: Colors.teal[300],
    //         borderRadius: BorderRadius.circular(20), // Border radius added here
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.black.withOpacity(0.1),
    //             spreadRadius: 5,
    //             blurRadius: 7,
    //             offset: Offset(0, 3),
    //           ),
    //         ],
    //       ),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Icon(Icons.web,
    //               size: 50, color: Colors.white), // Icon for modern look
    //           SizedBox(height: 16),
    //           Text(
    //             'Full Stack Web Development',
    //             style: TextStyle(
    //               fontWeight: FontWeight.bold,
    //               fontSize: 24,
    //               color: Colors.white,
    //             ),
    //           ),
    //           SizedBox(height: 8),
    //           Text(
    //             'I build scalable and secure web applications using the latest technologies. '
    //             'I have experience with a variety of programming languages and frameworks, '
    //             'so I can create an application that meets your needs, regardless of your '
    //             'budget or timeframe. I also work with you to design and develop a user '
    //             'interface that is both attractive and functional.',
    //             style: TextStyle(
    //               fontSize: 16,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );

    return Scaffold(
      bottomNavigationBar:
          AdminCustomBottomBar(controller: bottomTabController),
      body: true
          ? CustomPaint(
              painter: AdminMainBackground(),
              child: TabBarView(
                controller: bottomTabController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SafeArea(
                    child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        // These are the slivers that show up in the "outer" scroll view.
                        return <Widget>[
                          SliverToBoxAdapter(
                            child: appBar,
                          ),
                          // SliverToBoxAdapter(
                          //   child: topHeader,
                          // ),
                        ];
                      },
                      body: details,
                    ),
                  ),
                  SafeArea(
                    child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverToBoxAdapter(
                            child: appBar,
                          ),
                          // SliverToBoxAdapter(
                          //   child: topHeader,
                          // ),
                        ];
                      },
                      body: Padding(
                        padding: const EdgeInsets.only(bottom: 55.0),
                        child: stats,
                      ),
                    ),
                  ),
                  Newsposting(),
                  ProfilePage(),
                  AdminDeals(),
                  // Comments(),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(child: CircularProgressIndicator())),
    );
  }
}
