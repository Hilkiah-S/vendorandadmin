// import 'package:vendorapp/auth/login_page.dart';
import 'package:vendorapp/custom_background.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:vendorapp/screens/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:vendorapp/settings/change_password.dart';
import 'package:vendorapp/settings/legal_about.dart';
import 'package:vendorapp/settings/notifications_settings.dart';
import 'package:vendorapp/screens/login/login.dart';
// import 'package:hive/hive.dart';
import 'package:get_storage/get_storage.dart';

class SettingsPage extends StatelessWidget {
  final getStorage = GetStorage();
  var secStore = SecureStorage();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          // brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: darkGrey),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
              builder: (builder, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'General',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            // ListTile(
                            //     title: Text('Notifications'),
                            //     leading: Image.asset(
                            //         'assets/icons/notifications.png'),
                            //     onTap: () => {}
                            //     // Navigator.of(context).push(
                            //     //     MaterialPageRoute(
                            //     //         builder: (_) =>
                            //     //             NotificationSettingsPage())),
                            //     ),
                            ListTile(
                              title: Text('Legal & About'),
                              leading: Image.asset('assets/icons/legal.png'),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => LegalAboutPage())),
                            ),
                            // ListTile(
                            //   title: Text('About Us'),
                            //   leading: Image.asset('assets/icons/about_us.png'),
                            //   onTap: () {},
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                'Account',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: Text('Change Password'),
                              leading:
                                  Image.asset('assets/icons/change_pass.png'),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ChangePasswordPage())),
                            ),
                            ListTile(
                                title: Text('Sign out'),
                                leading:
                                    Image.asset('assets/icons/sign_out.png'),
                                onTap: () async {
                                  await secStore.deleteSecureData('token');
                                  getStorage.erase();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginScreen()),
                                    (route) => false,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
