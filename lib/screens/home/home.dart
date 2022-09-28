import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/category/components/category_item.dart';
import 'package:omni_mobile_app/share/components/banner/image_banner.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/most_popular.dart';
import 'package:omni_mobile_app/share/components/slider/slider.dart';
import 'package:omni_mobile_app/share/components/store_brand/store_brand.dart';
import 'package:omni_mobile_app/share/components/topbar.dart';

class Home extends StatelessWidget {
  const Home({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondayBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            ImageSlider(),
            CategoryItems(isHomePage: false),
            HorizontalSliderProducts(title: "Most Popular"),
            ImageBanner(),
            StoreBrand(title: "Brands"),
            HorizontalSliderProducts(title: "Based on your resent Search"),
          ],
        ),
      ),
    );
  }
}