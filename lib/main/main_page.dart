import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:vendorapp/components/custom_bottom_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vendorapp/components/displaystats.dart';
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
import 'package:vendorapp/screens/newnotifications.dart';
import 'package:vendorapp/screens/notifications_page.dart';
import 'package:vendorapp/global/global_variables.dart';
import 'dart:convert';

import 'package:vendorapp/screens/postcomment.dart';
import 'package:vendorapp/screens/search_pagevendor.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  bool recievedTabs = false;
  bool recievedProducts = false;
  bool recievedProductsDetails = false;
  late bool tabsAndProucts = recievedProducts && recievedTabs;
  late TabController tabController;
  late TabController bottomTabController;
  int numberOfCategory = 5;

  void getTabs() async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');
    print("token on main page ${token}");
    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    Response<Map> response = await Dio()
        .get("https://api.semer.dev/api/admin/category", options: options);

    if (!(response.data == null)) {
      setState(() {
        recievedTabs = true;
      });
    }
    List<dynamic> dataList = response.data?['data'];

    productCategories =
        dataList.map((e) => ProductCategory.fromMap(e)).toList();
    print("CAtegories");
    print(productCategories.map((e) => e.name));
    //loop
    // List<Widget> dropdowns
    // for (var product in productCategories) {

    // }
    setState(() {
      numberOfCategory = productCategories.length;
    });
  }

  void getmyProducts() async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');
    print("token on main page ${token}");
    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    Response<Map> response =
        await Dio().get("https://api.semer.dev/api/supplier", options: options);

    if (!(response.data == null)) {
      setState(() {
        recievedProducts = true;
      });
    }
    List<dynamic> dataList = response.data?['data'];

    // productCategories =
    //     dataList.map((e) => ProductCategory.fromMap(e)).toList();

    // print(productCategories.map((e) => e.name));
    //loop
    // List<Widget> dropdowns
    // for (var product in productCategories) {

    // }
  }

  void getProductdetails() async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');
    print("token on main page ${token}");
    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    Response<Map> response =
        await Dio().get("https://api.semer.dev/api/supplier", options: options);

    List<dynamic> product_Details = response.data?['data'];
    print(product_Details.runtimeType);
    productDetailList =
        product_Details.map((e) => ProductDetails.fromMap(e)).toList();
    print("Product Details");
    print(productDetailList.map((e) => e.name));
    print(productDetailList.map((e) => e.description));
    print(productDetailList.map((e) => e.images[0].img_url));
    if (!(response.data == null)) {
      setState(() {
        recievedProductsDetails = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getTabs();
    getmyProducts();
    getProductdetails();

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
          IconButton(
              onPressed: () => {
                    Get.off(NewNotifications()),
                  },
              icon: Icon(Icons.notifications)),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      recievedProducts = false;
                    });
                    getTabs();
                    getmyProducts();
                    getProductdetails();
                  },
                  icon: Icon(Icons.refresh)),
              IconButton(
                  onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => SearchPageVendor())),
                      },
                  icon: SvgPicture.asset('assets/icons/search_icon.svg')),
            ],
          )
        ],
      ),
    );
    Widget tabBar = TabBar(
      tabs: [
        ...productCategories.map((e) => Tab(text: '${e.name}')).toList(),
      ],
      labelStyle: TextStyle(fontSize: 16.0),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: tabController,
    );
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: recievedProducts && recievedTabs && recievedProductsDetails
          ? CustomPaint(
              painter: MainBackground(),
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
                          // SliverToBoxAdapter(
                          //   child: ProductList(),
                          // ),
                          SliverToBoxAdapter(
                            child: tabBar,
                          )
                        ];
                      },
                      body: TabView(
                        tabController: tabController,
                        myproducts: productDetailList,
                      ),
                    ),
                  ),
                  CreatePost(),
                  ProfilePage(),
                  NotificationsPage(),
                  DashboardStatisticsVendor(),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.teal,
              ))),
    );
  }
}
