import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:vendorapp/admin/admin-components/custom_background.dart';
import 'package:vendorapp/admin/admin-components/custom_bottom_bar.dart';
import 'package:vendorapp/admin/admin-components/displaygraph.dart';
import 'package:vendorapp/admin/admin-components/newspost.dart';
import 'package:vendorapp/admin/admin-components/notifications_page.dart';
import 'package:vendorapp/admin/admin-components/search_pageadmin.dart';
import 'package:vendorapp/admin/adminmodels/Recievedproducts.dart';
import 'package:vendorapp/admin/adminmodels/dealsadminmodel.dart';
import 'package:vendorapp/admin/pages/adminproductitems.dart';
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

class AdminDeals extends StatefulWidget {
  const AdminDeals({super.key});

  @override
  State<AdminDeals> createState() => _AdminDealsState();
}

class _AdminDealsState extends State<AdminDeals> {
  bool recievedTabs = false;
  bool recievedProducts = false;
  bool recievedProductsDetails = false;
  late bool tabsAndProucts = recievedProducts && recievedTabs;
  late TabController tabController;
  late TabController bottomTabController;
  int numberOfCategory = 5;

  List<ProductDetails> productDetailList = [];

  void getDeals() async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');
    print("token on main page ${token}");
    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    Response<Map> response = await Dio()
        .get("https://api.semer.dev/api/admin/deals", options: options);
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
    if (response.statusCode == 200) {
      adminalldeals = dataList!.map((e) => Deals.fromMap(e)).toList();
    }
    setState(() {});
    // alldata = response.data?['data']['data'];

    print("List of response");
  }

  @override
  void initState() {
    super.initState();

    getDeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: adminalldeals.length == 0
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.teal,
              )))
          : Container(
              child: ListView.builder(
                  itemCount: adminalldeals.length,
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: ((context) =>
                        //             AdminProductFinalDisplay(
                        //                 myproducts:
                        //                     widget.myproducts[index]))));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width: 80.0, // Adjust the image size
                                        height: 80.0, // Adjust the image size
                                        decoration: BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Makes the container circular
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "${adminalldeals[index].product?.user.business?.logo == '' ? 'https://d30y9cdsu7xlg0.cloudfront.net/png/140281-200.png' : adminalldeals[index].product?.user.business?.logo}"),
                                            fit: BoxFit
                                                .cover, // Ensures the image covers the container
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 4.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              " ${adminalldeals[index].deal == '' ? "No detail found" : adminalldeals[index].deal}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "DEAL WITH:  ${adminalldeals[index].product?.user.business?.name == '' ? "No detail found" : adminalldeals[index].product?.user.business?.name}",
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
    );
  }
}
