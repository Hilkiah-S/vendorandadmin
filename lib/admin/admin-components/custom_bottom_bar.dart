import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vendorapp/main/main_page.dart';
import 'package:get_storage/get_storage.dart';

class AdminCustomBottomBar extends StatelessWidget {
  final TabController controller;

  const AdminCustomBottomBar({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // IconButton(
          //   icon: Image.asset(
          //     'assets/icons/output-onlinepngtools (5).png',
          //     fit: BoxFit.fitWidth,
          //   ),
          //   onPressed: () {
          //     controller.animateTo(0);
          //   },
          // ),
          IconButton(
              onPressed: () {
                controller.animateTo(0);
              },
              icon: Icon(
                Icons.home_outlined,
                size: 30,
              )),
          // IconButton(
          //   icon: Image.asset('assets/icons/post.png'),
          //   onPressed: () {
          //     controller.animateTo(1);
          //   },
          // ),

          IconButton(
            icon: Icon(
              Icons.account_balance_outlined,
              size: 30,
            ),
            onPressed: () {
              controller.animateTo(4);
            },
          ),
          IconButton(
              onPressed: () {
                controller.animateTo(1);
              },
              icon: Icon(
                Icons.analytics_outlined,
                size: 30,
              )),
          IconButton(
            icon: Icon(
              Icons.newspaper,
              size: 30,
            ),
            onPressed: () {
              controller.animateTo(2);
            },
          ),
          IconButton(
            icon: Icon(Icons.person_2_sharp,
                size: 30, color: Color.fromARGB(255, 63, 160, 68)),
            onPressed: () {
              controller.animateTo(3);
            },
          ),
          // IconButton(
          //   icon: Image.asset('assets/icons/output-onlinepngtools (6).png'),
          //   onPressed: () {
          //     controller.animateTo(2);
          //   },
          // ),
        ],
      ),
    );
  }
}
