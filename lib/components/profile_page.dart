import 'package:flutter/material.dart';
import 'package:vendorapp/custom_background.dart';
import 'package:vendorapp/screens/app_properties.dart';
import 'package:vendorapp/settings/settings_page.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  var getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 48,
                  backgroundImage: AssetImage('assets/background.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getStorage.read('name'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: transparentYellow,
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  height: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.local_shipping,
                                  size: 35,
                                ),
                                // Image.asset('assets/icons/checkgreen.png'),
                                onPressed: () => {}
                                //  Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //         builder: (_) => TrackingPage())),
                                ),
                            Text(
                              'Requests',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     IconButton(
                        //       icon: Image.asset('assets/icons/card.png'),
                        //       onPressed: () => Navigator.of(context).push(
                        //           MaterialPageRoute(
                        //               builder: (_) => PaymentPage())),
                        //     ),
                        //     Text(
                        //       'Payment',
                        //       style: TextStyle(fontWeight: FontWeight.bold),
                        //     )
                        //   ],
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              // icon: Image.asset(
                              //     'assets/icons/output-onlinepngtools (7).png'),
                              icon: Icon(
                                Icons.support_agent_rounded,
                                size: 35,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              'Support',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                    title: Text('Settings'),
                    subtitle: Text('Privacy and logout'),
                    leading: Image.asset(
                      'assets/icons/settings_icon.png',
                      fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.green),
                    onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SettingsPage())),
                        }),
                Divider(),
                // ListTile(
                //   title: Text('Help & Support'),
                //   subtitle: Text('Help center and legal support'),
                //   leading: Image.asset('assets/icons/support.png'),
                //   trailing: Icon(
                //     Icons.chevron_right,
                //     color: Colors.green,
                //   ),
                // ),
                Divider(),
                // ListTile(
                //   title: Text('FAQ'),
                //   subtitle: Text('Questions and Answer'),
                //   leading: Image.asset('assets/icons/faq.png'),
                //   trailing: Icon(Icons.chevron_right, color: yellow),
                //   onTap: () =>
                //    Navigator.of(context)
                //       .push(MaterialPageRoute(builder: (_) => FaqPage())),
                // ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
