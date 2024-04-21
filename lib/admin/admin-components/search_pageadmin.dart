// import 'package:vendorapp/global/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Response;
import 'package:rubber/rubber.dart';
import 'package:vendorapp/admin/adminmodels/searchadmin.dart';
import 'package:vendorapp/global/global_variables.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';

class SearchPageAdmin extends StatefulWidget {
  @override
  _SearchPageStateAdmin createState() => _SearchPageStateAdmin();
}

class _SearchPageStateAdmin extends State<SearchPageAdmin> {
  String capitalize(String s) => s.isNotEmpty ? '${s.toUpperCase()}' : s;

  getSearches() async {
    print(searchController.text);
    try {
      var secStore = SecureStorage();
      var token = await secStore.readSecureData('token');
      final Options options = Options(
        headers: {
          "Authorization": "Bearer ${token}",
        },
      );
      Response<Map> response = await Dio().post(
          "https://api.semer.dev/api/admin/deals/search",
          data: {"search": searchController.text},
          options: options);
      print(response);
      if (response.statusCode == 200) {
        List<dynamic> dataList = response.data?['data']['data'];
        adminsearch = dataList.map((e) => Transaction.fromMap(e)).toList();
        setState(() {});
      } else {
        Get.snackbar("Error", "Something went wrong");
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  TextEditingController searchController = TextEditingController();

  late RubberAnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _expand() {
    _controller.expand();
  }

  Widget _getLowerLayer() {
    return Container(
      margin: const EdgeInsets.only(top: kToolbarHeight),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CloseButton()
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black, width: 1))),
            child: TextField(
              controller: searchController,
              onSubmitted: (value) {
                getSearches();
              },
              onChanged: (value) {
                // if (value.isNotEmpty) {
                //   List<Product> tempList = [];
                //   products.forEach((product) {
                //     if (product.name.toLowerCase().contains(value)) {
                //       tempList.add(product);
                //     }
                //   });
                //   setState(() {
                //     searchResults.clear();
                //     searchResults.addAll(tempList);
                //   });
                //   return;
                // } else {
                //   setState(() {
                //     searchResults.clear();
                //     searchResults.addAll(products);
                //   });
                // }
              },
              cursorColor: Colors.grey[600],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                prefixIcon: SvgPicture.asset(
                  'assets/icons/search_icon.svg',
                  fit: BoxFit.scaleDown,
                ),
                suffix: TextButton(
                  onPressed: () {
                    searchController.clear();
                    // searchResults.clear();
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: adminsearch.length == 0
                ? Container(
                    color: Colors.white,
                  )
                : Container(
                    color: Colors.white,
                    child: ListView.builder(
                        itemCount: adminsearch.length,
                        itemBuilder: (_, index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Card(
                              elevation: 5, // Adds shadow under the card
                              margin: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal:
                                      16), // Provides spacing between cards
                              child: Padding(
                                padding: EdgeInsets.all(
                                    16.0), // Padding inside the card
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          adminsearch[index]
                                              .product
                                              .supplier
                                              .logo),
                                      radius:
                                          30.0, // Adjusted for a balanced look
                                    ),
                                    SizedBox(
                                        width:
                                            16), // Spacing between the avatar and the text
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Aligns the text to the start
                                        children: <Widget>[
                                          Text(
                                            adminsearch[index].product.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  8), // Spacing between the name and the description or any other detail
                                          Text(
                                            'By:${adminsearch[index].product.user.name}', // Placeholder for any other detail you want to show
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.arrow_forward_ios),
                                      onPressed:
                                          () {}, // Placeholder for action
                                      color: Colors.grey[600], // Icon color
                                    ),
                                  ],
                                ),
                              ),
                            ))),
                  ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
//          bottomSheet: ClipRRect(
//            borderRadius: BorderRadius.only(
//                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
//            child: BottomSheet(
//                onClosing: () {},
//                builder: (_) => Container(
//                      padding: EdgeInsets.all(16.0),
//                      child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[Text('Filters')]),
//                      color: Colors.white,
//                      width: MediaQuery.of(context).size.height,
//                    )),
//          ),
          body: _getLowerLayer(),
          //     body: RubberBottomSheet(
          //   lowerLayer: _getLowerLayer(), // The underlying page (Widget)
          //   upperLayer: _getUpperLayer(), // The bottomsheet content (Widget)
          //   animationController: _controller, // The one we created earlier
          // )
        ),
      ),
    );
  }
}
