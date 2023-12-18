import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/category/components/category_item.dart';
import 'package:omni_mobile_app/share/components/topbar.dart';

class Category extends StatefulWidget {
  bool isHomePage;
  Category({Key key, this.isHomePage}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondayBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [TopBar(), CategoryItems(isHomePage: widget.isHomePage)],
        ),
      ),
    );
  }
}
