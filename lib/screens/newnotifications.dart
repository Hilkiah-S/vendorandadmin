import 'package:vendorapp/global/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:vendorapp/http/ownershipresponse.dart';
import 'package:vendorapp/main/main_page.dart';
import 'package:vendorapp/models/newnotifications.dart';
import 'package:vendorapp/screens/app_properties.dart';

import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:vendorapp/models/notificationsmodel.dart';
import 'package:dio/dio.dart';

class NewNotifications extends StatefulWidget {
  @override
  State<NewNotifications> createState() => _NewNotificationsState();
}

class _NewNotificationsState extends State<NewNotifications> {
  bool test = true;
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
        "https://api.semer.dev/api/supplier/notifications",
        options: options);

    if (response.statusCode == 200) {
      // var data = response.data?['data'];

      List<dynamic>? notify = response.data?['data']['data'];

      newnotifications =
          notify!.map((e) => VendorNotificationData.fromMap(e)).toList();
      print(newnotifications[0].payload);
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
      body: Container(
          margin: const EdgeInsets.only(top: kToolbarHeight),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          color: Colors.white,
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Notifications',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CloseButton(
                  onPressed: () {
                    Get.off(() => MainPage());
                  },
                )
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
                      itemCount: newnotifications.length,
                      itemBuilder: (_, index) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal:
                                  16.0), // Add horizontal margin for better spacing
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(8.0), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.2), // Shadow color with some transparency
                                spreadRadius: 1, // Spread radius
                                blurRadius: 6, // Blur radius
                                offset: Offset(0,
                                    3), // changes position of shadow, 3 units down from the container
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align text to the start of the container
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  '${newnotifications[index].type}'
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize:
                                        14.0, // Adjust font size as needed
                                    fontWeight: FontWeight
                                        .bold, // Bold font weight for the notification type
                                    color: Colors
                                        .black87, // Darker text for better readability
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    left: 16.0,
                                    right: 16.0,
                                    bottom:
                                        16.0), // Add padding to the payload text
                                child: Text(
                                  '${newnotifications[index].payload}',
                                  style: TextStyle(
                                    fontSize:
                                        14.0, // Adjust font size as needed
                                    color: Colors
                                        .black54, // Slightly lighter text for the payload
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
            )
          ])),
    );
  }
}
