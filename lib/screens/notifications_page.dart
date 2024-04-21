import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendorapp/global/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
// import 'package:vendorapp/http/ownershipresponse.dart';
import 'package:vendorapp/main/main_page.dart';
import 'package:vendorapp/screens/app_properties.dart';

import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:vendorapp/models/notificationsmodel.dart';
import 'package:dio/dio.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool test = true;
  void Ownershipresponse(int index, productid) async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');
    print("token on ownership response ${token}");
    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    var senddata = {"request_id": productid};
    Response response = await Dio().post(
        "https://api.semer.dev/api/supplier/transfer/ownership",
        data: senddata,
        options: options);

    if (response.statusCode == 200) {
      var responsedata = response.data?['data'];
      String message = responsedata['message'].toString();
      Get.snackbar("Successful", message);
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: ((context) => NotificationsPage())));
      // getNotifications();
      notifications.removeAt(index);
      setState(() {});
    } else {
      Get.snackbar("Error", "Unsuccessful");
    }
  }

  void getNotifications() async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');
    print("token on main page ${token}");
    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );

    Response response = await Dio().get(
        "https://api.semer.dev/api/supplier/ownership/requests",
        options: options);

    if (response.statusCode == 200) {
      // var data = response.data?['data'];
      String? next_page = response.data?['data']['next_page_url'];
      var getStorage = GetStorage();
      getStorage.write("nextpage", next_page);
      // print("nextpage url");
      // print(next_page);
      List<dynamic>? notify = response.data?['data']['data'];
      print("offers");
      print(response);
      notifications =
          notify!.map((e) => NotificationsModel.fromMap(e)).toList();
      print(notifications[0].deal);
      setState(() {
        test = false;
      });
    }
  }

  void getNextNotifications(String next) async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');
    print("token on main page ${token}");
    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );

    Response response = await Dio().get(next, options: options);

    if (response.statusCode == 200) {
      // var data = response.data?['data'];
      String? next_page = response.data?['data']['next_page_url'];
      var getStorage = GetStorage();
      getStorage.write("nextpage", next_page);
      print("nextpage url");
      print(next_page);
      List<dynamic>? notify = response.data?['data']['data'];

      notifications
          .addAll(notify!.map((e) => NotificationsModel.fromMap(e)).toList());

      print(notifications[0].deal);
      setState(() {
        test = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.only(top: kToolbarHeight),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            color: Colors.white,
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Offers',
                    style: TextStyle(
                      color: darkGrey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: test
                    ? Container(
                        child: Center(
                            child: CircularProgressIndicator(
                        color: Colors.teal,
                      )))
                    : ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (_, index) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        '${notifications[index].product?.images[0].img_url}',
                                      ),
                                      radius: 24,
                                    ),
                                    SizedBox(width: 16.0),
                                    Flexible(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Admin Offer',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          '${notifications[index].deal == "" ? "No offer request" : notifications[index].deal}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check_circle,
                                        size: 14,
                                        color: Colors.blue[700],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: TextButton(
                                          onPressed: () {
                                            Ownershipresponse(
                                                index, notifications[index].id);
                                          },
                                          child: Text(
                                            'Accept',
                                            style: TextStyle(
                                                color: Colors.blue[700]),
                                          ),
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size(50, 30),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            alignment: Alignment.centerLeft,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                index == notifications.length - 1
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton.icon(
                                            icon:
                                                const Icon(Icons.arrow_forward),
                                            label: const Text('Next'),
                                            onPressed: () {
                                              var getStorage = GetStorage();
                                              if (getStorage.read('nextpage') !=
                                                  null) {
                                                getNextNotifications(getStorage
                                                    .read('nextpage'));
                                                // getProductdetails2(
                                                //         others['next_page_url'])
                                                //     .then((result) {
                                                //   if (mounted) {
                                                //     // Check if the widget is still in the tree
                                                //     setState(() {

                                                //       // recievedProductsDetails =
                                                //       //     true;
                                                //     });
                                                //   }
                                                // }
                                              } else {
                                                null;
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors
                                                  .grey[300], // Button color
                                              foregroundColor:
                                                  Colors.black, // Text color
                                              shape:
                                                  const StadiumBorder(), // Pill shape
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 32,
                                                      vertical: 12),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          );
                        },
                      ),
              )
            ])),
      ),
    );
  }
}
