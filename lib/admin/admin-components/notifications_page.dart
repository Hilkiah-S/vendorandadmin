import 'package:vendorapp/admin/adminmodels/notifiationsadmin.dart';
import 'package:vendorapp/admin/screens/adminmain.dart';
import 'package:vendorapp/global/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:vendorapp/http/ownershipresponse.dart';
import 'package:vendorapp/main/main_page.dart';
import 'package:vendorapp/screens/app_properties.dart';

import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:vendorapp/models/notificationsmodel.dart';
import 'package:dio/dio.dart';

class NotificationsPageAdmin extends StatefulWidget {
  @override
  State<NotificationsPageAdmin> createState() => _NotificationsPageStateAdmin();
}

class _NotificationsPageStateAdmin extends State<NotificationsPageAdmin> {
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

    Response response = await Dio().post(
        "https://api.semer.dev/api/admin/notifications",
        options: options);
    print("response");
    print(response);
    if (response.statusCode == 200) {
      // var data = response.data?['data'];
      print(response);
      List<dynamic>? notify = response.data?['data']['data'];

      adminnotifications =
          notify!.map((e) => Notificationdata.fromMap(e)).toList();

      setState(() {});
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
          color: Colors.grey[100],
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Notification',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CloseButton(
                  onPressed: () {
                    Get.off(() => AdminMainPage());
                  },
                )
              ],
            ),
            Flexible(
              child: adminnotifications.length == 0
                  ? Container(
                      child: Center(
                          child: CircularProgressIndicator(
                      color: Colors.teal,
                    )))
                  : ListView.builder(
                      itemCount: adminnotifications.length,
                      itemBuilder: (_, index) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        ' ${adminnotifications[index].payload}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      // RichText(
                                      //   text: TextSpan(
                                      //       style: TextStyle(
                                      //         fontFamily: 'Montserrat',
                                      //         color: Colors.black,
                                      //       ),
                                      //       children: [
                                      //         TextSpan(
                                      //           text:
                                      //               ' ${adminnotifications[index].data.payload}',
                                      //           style: TextStyle(
                                      //             fontWeight: FontWeight.bold,
                                      //           ),
                                      //         ),
                                      //       ]),
                                      // ),
                                    ),
                                  )
                                ],
                              ),
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
