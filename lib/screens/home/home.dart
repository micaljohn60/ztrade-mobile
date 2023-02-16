import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/category/components/category_item.dart';

import 'package:omni_mobile_app/services/index/index_service.dart';
import 'package:omni_mobile_app/services/index/index_service_auth.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';
import 'package:omni_mobile_app/share/components/banner/image_banner.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/most_popular.dart';
import 'package:omni_mobile_app/share/components/slider/slider.dart';
import 'package:omni_mobile_app/share/components/store_brand/store_brand.dart';
import 'package:omni_mobile_app/share/components/topbar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  String token;
  Home({Key key, this.token}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  CustomSecureStorage css = CustomSecureStorage();
    String newValue = "n";
    bool isLoading = true;
    Future<void> readToken() async {
    final String value = await css.readValueName("session_id");
    setState(() {
      newValue = value;
      isLoading = false;
    });
  }

    @override
  void initState() {
    // TODO: implement initState

    readToken();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {  

    
    
    widget.token == null ?
    context.read<IndexService>().fetchData
    :
    context.read<IndexServiceAuth>().fetchData(newValue);

    return newValue == "n" ?

    Consumer<IndexService>(builder: ((context, value, child) {

      return value.map.length == 0 && !value.error
      ? const Center(
          child: CircularProgressIndicator(
            backgroundColor: primaryBackgroundColor,
          )
        )
      : value.error
          ? Column(
            children: [
              Center(
              child: Text(value.errorMessage),
            ),
            TextButton(onPressed: () {

                    
            context.read<IndexService>().fetchData;
          

            }, child: Text("Refresh"))
            ],
          )
          : Container(
              color: secondayBackgroundColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TopBar(),
                    ImageSlider(images: value.map["sliders"]),
                    CategoryItems(isHomePage: false,wishLists: value.map["wishlist"] ),
                    value.map["mostpopular"].length == 0 
                    ?
                    Container()
                    :
                    HorizontalSliderProducts(title: "Most Popular",products: value.map["mostpopular"],userId: newValue,wishLists: value.map["wishlist"]),

                    value.map["banners"].length == 0 
                    ?
                    Container()
                    :
                    ImageBanner(image: value.map["banners"][0]["image"],)
                    ,

                     value.map["topselling"].length == 0 
                    ?
                    Container()
                    :
                    HorizontalSliderProducts(title: "Top Selling Products",products: value.map["topselling"],wishLists: value.map["wishlist"] ?? [],),
                    
                    value.map["banners"].length == 2
                    ?
                    ImageBanner(image: value.map["banners"][1]["image"],)
                    :
                    Container()
                    ,

                    StoreBrand(title: "Brands"),

                    value.map["newarrival"].length == 0 
                    ?
                    Container()
                    :
                    HorizontalSliderProducts(
                        title: "New Arrival",products: value.map["newarrival"],wishLists: value.map["wishlist"] ?? []),

                    value.map["banners"].length == 3
                    ?
                    ImageBanner(image: value.map["banners"][2]["image"],)
                    :
                    Container()
                    ,
                    HorizontalSliderProducts(title: "Latest Upload",products: value.map["products"],wishLists: value.map["wishlist"] ?? []),

                  ],
                ),
              ),
            );
    }))
    :
    Consumer<IndexServiceAuth>(builder: ((context, value, child) {
      return value.map.length == 0 && !value.error
      ? const Center(
          child: CircularProgressIndicator(
            backgroundColor: primaryBackgroundColor,
          )
        )
      : value.error
          ? Column(
            children: [
              Center(
              child: Text(value.errorMessage),
            ),
            TextButton(onPressed: () {

            context.read<IndexServiceAuth>().fetchData(newValue);

            }, child: Text("Hahah"))
            ],
          )
          : Container(
              color: secondayBackgroundColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TopBar(),
                    ImageSlider(images: value.map["sliders"]),
                    CategoryItems(isHomePage: false,wishLists: value.map["wishlist"] ?? [],),
                    value.map["mostpopular"].length == 0 
                    ?
                    Container()
                    :
                    HorizontalSliderProducts(title: "Most Popular",products: value.map["mostpopular"],userId: newValue,wishLists: value.map["wishlist"]),

                    value.map["banners"].length == 0 
                    ?
                    Container()
                    :
                    ImageBanner(image: value.map["banners"][0]["image"],)
                    ,

                     value.map["topselling"].length == 0 
                    ?
                    Container()
                    :
                    HorizontalSliderProducts(title: "Top Selling Products",products: value.map["topselling"],userId: newValue,wishLists: value.map["wishlist"],),
                    
                    value.map["banners"].length == 2
                    ?
                    ImageBanner(image: value.map["banners"][1]["image"],)
                    :
                    Container()
                    ,

                    StoreBrand(title: "Brands"),

                    value.map["newarrival"].length == 0 
                    ?
                    Container()
                    :
                    HorizontalSliderProducts(
                        title: "New Arrival",products: value.map["newarrival"],userId: newValue,wishLists: value.map["wishlist"]),

                    value.map["banners"].length == 3
                    ?
                    ImageBanner(image: value.map["banners"][2]["image"],)
                    :
                    Container()
                    ,
                    HorizontalSliderProducts(title: "Latest Upload",products: value.map["products"],userId: newValue,wishLists: value.map["wishlist"]),

                  ],
                ),
              ),
            );
    }));
    
  }
}
