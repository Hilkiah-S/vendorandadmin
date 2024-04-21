import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vendorapp/main/main_page.dart';

class CustomBottomBar extends StatelessWidget {
  final TabController controller;

  const CustomBottomBar({
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            onPressed: () {
              controller.animateTo(0);
            },
          ),

          IconButton(
            icon: Icon(
              Icons.account_balance_outlined,
              size: 30,
            ),
            onPressed: () {
              controller.animateTo(3);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.analytics_outlined,
              size: 30,
            ),
            onPressed: () {
              controller.animateTo(4);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.list_alt_outlined,
              size: 30,
            ),
            onPressed: () {
              controller.animateTo(1);
            },
          ),
          // IconButton(
          //   icon: Image.asset(
          //     'assets/icons/output-onlinepngtools (7).png',
          //     width: 25,
          //     height: 25,
          //   ),
          //   onPressed: () {
          //     controller.animateTo(3);
          //   },
          // ),
          IconButton(
            icon: Icon(
              Icons.person_2,
              size: 30,
              color: Color.fromARGB(255, 63, 160, 68),
            ),
            onPressed: () {
              controller.animateTo(2);
            },
          ),
        ],
      ),
    );
  }
}
