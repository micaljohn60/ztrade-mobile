import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/providers/check_out_provider/check_out_provider.dart';
import 'package:omni_mobile_app/screens/product_detail/components/product_description.dart';
import 'package:omni_mobile_app/screens/product_detail/components/product_image.dart';
import 'package:omni_mobile_app/screens/product_detail/components/product_price_tag.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';
import 'package:omni_mobile_app/share/app_style.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/product_title.dart';
import 'package:omni_mobile_app/share/components/related_products/related_products.dart';
import 'package:omni_mobile_app/share/flutter_toast/flutter_toast.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../providers/add_to_cart/add_to_cart_provider.dart';
import '../../share/components/topbar.dart';

class ProductDetail extends StatefulWidget {
  String userId;
  int id;
  String title;
  List<dynamic> images;
  String price;
  String itemDescription;
  String category;
  List<dynamic> favItems;
  ProductDetail(
      {Key key,
      this.userId,
      this.title,
      this.price,
      this.itemDescription,
      this.images,
      this.category,
      this.id,
      this.favItems})
      : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String _token = "";

  CustomSecureStorage css = CustomSecureStorage();

  String newValue = "n";
  bool isLoading = true;
  Future<void> readToken() async {
    final String value = await css.readValueName("session_id");
    final String token = await css.readValue();
    setState(() {
      newValue = value;
      isLoading = false;
      _token = token;
    });
    final provider = Provider.of<AddToCartNotifier>(context, listen: false);
    provider.getCartsFromAPI(_token);
  }

  @override
  void initState() {
    readToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    print("this is height  ====>$height");
    bool isLogin = newValue == null && newValue == "n";
    print("user login ===>$isLogin");
    final provider = Provider.of<AddToCartNotifier>(context);
    print("cart data list from detail ===>${provider.cartDataList}");

    return Container(
      color: primaryBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: secondayBackgroundColor,
          body: Stack(
            children: [
              Column(
                children: [
                  TopBar(
                    userId: widget.userId,
                  ),
                  Container(
                    height: (widget.userId != null)
                        ? height * 0.675
                        : height * 0.775,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: secondayBackgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductDetailImage(images: widget.images),
                          ProductPriceTag(
                            price: widget.price,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ProductDescription(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductTitle(text: widget.title),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.itemDescription,
                                    style: GoogleFonts.poppins(fontSize: 15.0),
                                    textAlign: TextAlign.justify,
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RelatedProducts(
                            title: "Related Products",
                            products: [],
                            wishLists: widget.favItems ?? [],
                            userId: newValue,
                            data: widget.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: widget.userId != null,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    child: Selector<AddToCartNotifier, int>(
                      selector: (_, notifier) => notifier.quantity,
                      builder: (_, notifier, __) => Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    final instance =
                                        context.read<AddToCartNotifier>();
                                    instance.reduceCount();
                                  },
                                  color: primaryBackgroundColor,
                                  iconSize: 30,
                                  icon: const Icon(UniconsLine.minus_circle),
                                ),
                                Text(
                                  "$notifier",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 20),
                                ),
                                IconButton(
                                  onPressed: () {
                                    final instance =
                                        context.read<AddToCartNotifier>();
                                    instance.plusCount();
                                  },
                                  iconSize: 30,
                                  color: primaryBackgroundColor,
                                  icon: const Icon(UniconsLine.plus_circle),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              print(
                                  "this is user token =====>$_token ${widget.id} $notifier");
                              final instance =
                                  context.read<AddToCartNotifier>();
                              final provider = Provider.of<CheckOutProvider>(
                                  context,
                                  listen: false);
                              if (notifier == 0) {
                                showToastMessage(
                                    "You need to add Quantity amount");
                              }
                              if (notifier > 0) {
                                instance.addToCart(widget.id, notifier, _token);
                                instance.getCartsFromAPI(_token);
                                provider.getAddress(_token);
                                // setState(() {
                                //   instance.cartDataList;
                                // });

                                showToastMessage(
                                    "${widget.title} is successfully adding to cart");
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  color: primaryBackgroundColor),
                              child: Text(
                                "Add To Cart",
                                style:
                                    appStyle(18, FontWeight.w600, Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
