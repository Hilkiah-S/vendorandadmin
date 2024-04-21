import 'package:flutter/material.dart';

const Color yellow = Color(0xffFDC054);
const Color mediumYellow = Color(0xffFDB846);
const Color darkYellow = Color(0xffE99E22);
// const Color transparentYellow = Color.fromARGB(255, 108, 215, 111);
const Color transparentYellow = Colors.white;
const Color darkGrey = Color(0xff202020);

const LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(236, 60, 3, 1),
  Color.fromRGBO(234, 60, 3, 1),
  Color.fromRGBO(216, 78, 16, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const LinearGradient registerButtonColor = LinearGradient(colors: [
  Color.fromRGBO(29, 204, 6, 1),
  Color.fromRGBO(71, 217, 8, 1),
  Color.fromRGBO(32, 212, 12, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);
const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}
