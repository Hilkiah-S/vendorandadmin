import 'package:vendorapp/auth/register_page.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';
import 'package:vendorapp/screens/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:vendorapp/main/main_page.dart';
import 'package:dio/dio.dart';

class WelcomeBackPage extends StatefulWidget {
  @override
  _WelcomeBackPageState createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  TextEditingController email = TextEditingController();
  // final _mybox = Hive.box('UserBox');
  TextEditingController password = TextEditingController();
  // @override
  // void initState() {
  // TODO: implement initState
  // super.initState();
  // if (_mybox.get(2) != null) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) => MainPage()));
  // }
  // }

  @override
  Widget build(BuildContext context) {
    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Center(
            child: Text(
          'Login to your account ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        )));

    Widget loginButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 40,
      child: InkWell(
        onTap: () async {
          _sendCode();
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: new Text("Login",
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(29, 204, 6, 1),
                    Color.fromRGBO(71, 217, 8, 1),
                    Color.fromRGBO(32, 212, 12, 1),
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    Widget loginForm = Container(
      height: 240,
      child: Stack(
        children: <Widget>[
          Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Username",
                    ),
                    controller: email,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    controller: password,
                    style: TextStyle(fontSize: 16.0),
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          loginButton,
        ],
      ),
    );

    Widget forgotPassword = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Forgot your password? ',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'Reset password',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Not Registered? ',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => RegisterPage()));
                },
                child: Text(
                  'Signup',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
              color: transparentYellow,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 3),
                subTitle,
                Spacer(flex: 2),
                loginForm,
                Spacer(flex: 2),
                forgotPassword
              ],
            ),
          )
        ],
      ),
    );
  }

  void _sendCode() async {
    if (!password.text.isEmpty && !email.text.isEmpty) {
      try {
        Response<Map> response =
            await Dio().post("https://api.semer.dev/api/auth/login",
                data: {
                  "username": email.text,
                  "password": password.text,
                },
                options: new Options(contentType: "application/json"));

        print(response.data);
        var success = response.data!['status'];
        var token = response.data!['data']['token'];
        print(success);
        print("toekn ${token}");
        if (success == "error") {
          _showErrorDialog(response.data!['message']);
        } else if (success == "success") {
          var secStore = SecureStorage();
          await secStore.writeSecureData('token', token);
          print(await secStore.readSecureData('token'));
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => MainPage()));
          _showMyDialog();
        }
      } on DioException catch (e) {
        String errormsg = "${e}";
        _showErrorDialog(errormsg);
      }
    } else
      _showErrorDialog("Password doesn't match");
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext fcontext) {
        return AlertDialog(
          title: const Text('Login Successful'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Icon(
                  Icons.check_box_rounded,
                  color: Colors.green,
                  size: 120,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (_) => MainPage()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext fcontext) {
        return AlertDialog(
          title: Text(message),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 120,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
