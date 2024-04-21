import 'package:flutter/material.dart';

class AdminCreateCategory extends StatefulWidget {
  const AdminCreateCategory({super.key});

  @override
  State<AdminCreateCategory> createState() => _AdminCreateCategoryState();
}

class _AdminCreateCategoryState extends State<AdminCreateCategory>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
