import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/category/components/category_item.dart';

import 'package:omni_mobile_app/services/index/index_service.dart';
import 'package:omni_mobile_app/services/index/index_service_auth.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';
import 'package:omni_mobile_app/share/components/banner/image_banner.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/product_title.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/most_popular.dart';
import 'package:omni_mobile_app/share/components/latest_products/latest_products.dart';
import 'package:omni_mobile_app/share/components/slider/slider.dart';
import 'package:omni_mobile_app/share/components/store_brand/store_brand.dart';
import 'package:omni_mobile_app/share/components/topbar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/add_to_cart/add_to_cart_provider.dart';

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
  String token = "";
  Future<void> readToken() async {
    final String value = await css.readValueName("session_id");
    final String _token = await css.readValue();

    setState(() {
      newValue = value;
      isLoading = false;
      token = _token;
    });
    final provider = Provider.of<AddToCartNotifier>(context, listen: false);
    provider.getCartsFromAPI(token);
  }

  @override
  void initState() {
    readToken();
    super.initState();
  }

  Widget phoneNumber(String data) {
    var phones = data.split(",");
    print(phones);
    phones.map((e) => (TextButton(
          onPressed: () async {
            await launchUrl(Uri.parse("tel://" + e));
          },
          child: Text(e),
        )));
  }

  @override
  Widget build(BuildContext context) {
    // final instance = Provider.of<CartLengthNotifier>(context);
    //
    // print("this is from home==> $token  ${instance.getLength()}");
    widget.token == null
        ? context.read<IndexService>().fetchData
        : context.read<IndexServiceAuth>().fetchData(newValue);

    return newValue == "n"
        ? Consumer<IndexService>(builder: ((context, value, child) {
            return value.map.length == 0 && !value.error
                ? const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: primaryBackgroundColor,
                  ))
                : value.error
                    ? Column(
                        children: [
                          Center(
                            child: Text(value.errorMessage),
                          ),
                          TextButton(
                              onPressed: () {
                                context.read<IndexService>().fetchData;
                              },
                              child: const Text("Refresh"))
                        ],
                      )
                    : Scaffold(
                        floatingActionButton: FloatingActionButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      value.map["siteSetting"][0]["phonenumber"]
                                          .split(",")
                                          .map<Widget>((e) => TextButton(
                                                onPressed: () async {
                                                  await launchUrl(
                                                      Uri.parse("tel://" + e));
                                                },
                                                child: Text(e),
                                              ))
                                          .toList(),
                                ),
                              ),
                            ),
                          ),
                          backgroundColor: primaryBackgroundColor,
                          child: const Icon(Icons.phone_in_talk_outlined),
                        ),
                        body: Container(
                          color: secondayBackgroundColor,
                          child: SingleChildScrollView(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                newValue == 'n'
                                    ? await context
                                        .read<IndexService>()
                                        .fetchData
                                    : await context
                                        .read<IndexServiceAuth>()
                                        .fetchData(newValue);
                              },
                              child: Column(
                                children: [
                                  TopBar(userId: newValue),
                                  ImageSlider(images: value.map["sliders"]),
                                  CategoryItems(
                                      userID: newValue,
                                      isHomePage: false,
                                      wishLists: value.map["wishlist"]),
                                  value.map["mostpopular"].length == 0
                                      ? Container()
                                      : HorizontalSliderProducts(
                                          title: "Most Popular",
                                          products: value.map["mostpopular"],
                                          userId: newValue,
                                          wishLists: value.map["wishlist"]),
                                  value.map["banners"].length == 0
                                      ? Container()
                                      : ImageBanner(
                                          image: value.map["banners"][0]
                                              ["image"],
                                        ),
                                  value.map["topselling"].length == 0
                                      ? Container()
                                      : HorizontalSliderProducts(
                                          title: "Top Selling Products",
                                          products: value.map["topselling"],
                                          wishLists:
                                              value.map["wishlist"] ?? [],
                                        ),
                                  value.map["banners"].length == 2
                                      ? ImageBanner(
                                          image: value.map["banners"][1]
                                              ["image"],
                                        )
                                      : Container(),
                                  StoreBrand(
                                    title: "Brands",
                                    userID: newValue,
                                  ),
                                  value.map["newarrival"].length == 0
                                      ? Container()
                                      : HorizontalSliderProducts(
                                          title: "New Arrival",
                                          products: value.map["newarrival"],
                                          wishLists:
                                              value.map["wishlist"] ?? []),
                                  value.map["banners"].length == 3
                                      ? ImageBanner(
                                          image: value.map["banners"][2]
                                              ["image"],
                                        )
                                      : Container(),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          ProductTitle(text: "Latest Uplode"),
                                    ),
                                  ),
                                  LatestProducts(
                                      products: value.map["products"],
                                      userId: newValue,
                                      wishLists: value.map["wishlist"]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
          }))
        : Consumer<IndexServiceAuth>(builder: ((context, value, child) {
            return value.map.length == 0 && !value.error
                ? const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: primaryBackgroundColor,
                  ))
                : value.error
                    ? Column(
                        children: [
                          Center(
                            child: Text(value.errorMessage),
                          ),
                          TextButton(
                              onPressed: () {
                                context
                                    .read<IndexServiceAuth>()
                                    .fetchData(newValue);
                              },
                              child: const Text("Refresh"))
                        ],
                      )
                    : Scaffold(
                        floatingActionButton: FloatingActionButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      value.map["siteSetting"][0]["phonenumber"]
                                          .split(",")
                                          .map<Widget>((e) => TextButton(
                                                onPressed: () async {
                                                  await launchUrl(
                                                      Uri.parse("tel://" + e));
                                                },
                                                child: Text(e),
                                              ))
                                          .toList(),
                                ),
                              ),
                            ),
                          ),
                          backgroundColor: primaryBackgroundColor,
                          child: const Icon(Icons.phone_in_talk_outlined),
                        ),
                        body: RefreshIndicator(
                          onRefresh: () async {
                            newValue == 'n'
                                ? await context.read<IndexService>().fetchData
                                : await context
                                    .read<IndexServiceAuth>()
                                    .fetchData(newValue);
                          },
                          child: Container(
                            color: secondayBackgroundColor,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TopBar(
                                    userId: newValue,
                                  ),
                                  ImageSlider(images: value.map["sliders"]),
                                  CategoryItems(
                                    userID: newValue,
                                    isHomePage: false,
                                    wishLists: value.map["wishlist"] ?? [],
                                  ),
                                  value.map["banners"].length >= 4
                                      ? ImageBanner(
                                          image: value.map["banners"][3]
                                              ["image"],
                                        )
                                      : Container(),
                                  value.map["mostpopular"].length == 0
                                      ? Container()
                                      : HorizontalSliderProducts(
                                          title: "Most Popular",
                                          products: value.map["mostpopular"],
                                          userId: newValue,
                                          wishLists: value.map["wishlist"]),

                                  value.map["banners"].length == 0
                                      ? Container()
                                      : ImageBanner(
                                          image: value.map["banners"][0]
                                              ["image"],
                                        ),

                                  value.map["topselling"].length == 0
                                      ? Container()
                                      : HorizontalSliderProducts(
                                          title: "Top Selling Products",
                                          products: value.map["topselling"],
                                          userId: newValue,
                                          wishLists: value.map["wishlist"],
                                        ),

                                  value.map["banners"].length >= 2
                                      ? ImageBanner(
                                          image: value.map["banners"][1]
                                              ["image"],
                                        )
                                      : Container(),

                                  StoreBrand(
                                    title: "Brands",
                                    userID: newValue,
                                  ),

                                  value.map["newarrival"].length == 0
                                      ? Container()
                                      : HorizontalSliderProducts(
                                          title: "New Arrival",
                                          products: value.map["newarrival"],
                                          userId: newValue,
                                          wishLists: value.map["wishlist"]),

                                  value.map["banners"].length >= 3
                                      ? ImageBanner(
                                          image: value.map["banners"][2]
                                              ["image"],
                                        )
                                      : Container(),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          ProductTitle(text: "Latest Uplode"),
                                    ),
                                  ),
                                  LatestProducts(
                                      products: value.map["products"],
                                      userId: newValue,
                                      wishLists: value.map["wishlist"])
                                  // HorizontalSliderProducts(title: "Latest Upload",products: value.map["products"],userId: newValue,wishLists: value.map["wishlist"]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
          }));
  }
}
