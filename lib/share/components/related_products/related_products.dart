import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/screens/category/components/loading/loading.dart';
import 'package:omni_mobile_app/screens/product_detail/product_detail.dart';
import 'package:omni_mobile_app/services/product/related_products.dart';
import 'package:omni_mobile_app/share/components/heart/heart.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/price_tag.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/product_title.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class RelatedProducts extends StatefulWidget {
  String title;
  String userId;
  String data;
  List<dynamic> products;
  List<dynamic> wishLists;

  RelatedProducts(
      {Key key,
      this.title,
      this.userId,
      this.products,
      this.wishLists,
      this.data})
      : super(key: key);

  @override
  State<RelatedProducts> createState() => _RelatedProductsState();
}

class _RelatedProductsState extends State<RelatedProducts> {
  @override
  Widget build(BuildContext context) {
    String calculatePrice(String price, int percentage) {
      if (percentage > 0) {
        double data = int.parse(price) + (int.parse(price) * percentage / 100);
        return data.toString();
      } else {
        double data = int.parse(price) - (int.parse(price) * percentage / 100);
        return data.toString();
      }
    }

    bool checkInWishList(List<dynamic> list, String productId) {
      for (int i = 0; i < list.length; i++) {
        if (list[i]["product_id"].toString() == productId) {
          return true;
        }
      }
      return false;
    }

    context.read<RelatedProductService>().fetchData(widget.data, widget.userId);
    var size = MediaQuery.of(context).size;
    return Consumer<RelatedProductService>(
      builder: ((context, value, child) {
        return value.map.isEmpty && !value.error
            ? Center(
                child: Loading(
                height: 330,
              ))
            : value.error
                ? Center(
                    child: Text(value.errorMessage),
                  )
                : SizedBox(
                    height: 330,
                    width: size.width,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductTitle(text: widget.title),
                          ),
                        ),
                        SizedBox(
                          height: 280,
                          child: ListView.builder(
                            itemCount: value.map["products"].length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: InkWell(
                                onTap: () {
                                  pushNewScreen(context,
                                      screen: ProductDetail(
                                        favItems: [],
                                        id: value.map["products"][index]["id"],
                                        title: value.map["products"][index]
                                            ["name"],
                                        price: calculatePrice(
                                            value.map["products"][index]
                                                ["price"],
                                            value.map["products"][index]
                                                ["percentage"]["percentage"]),
                                        itemDescription: value.map["products"]
                                            [index]["item_description"],
                                        category: value.map["products"][index]
                                            ["category"]["name"],
                                        images: value.map["products"][index]
                                            ["product_image"],
                                      ));
                                },
                                child: Container(
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 3.0,
                                            blurRadius: 5.0)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            width: size.width / 2.1,
                                            alignment: Alignment.centerRight,
                                            child: Heart(
                                              userId: widget.userId,
                                              productId: value.map["products"]
                                                      [index]["id"]
                                                  .toString(),
                                              wishLists: widget.wishLists,
                                              isWishList: checkInWishList(
                                                  value.map["whishlists"],
                                                  value.map["products"][index]
                                                          ["id"]
                                                      .toString()),
                                            )),
                                        ProductImage(
                                          imgUrl: ZtradeAPI.productImageUrl +
                                              value.map["products"][index]
                                                      ["product_image"][0]
                                                      ["thumbnails"]
                                                  .replaceAll('"', ''),
                                          isFav: false,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                              value.map["products"][index]
                                                  ["name"],
                                              // "zHi",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16.0,
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 5.0),
                                          child: PriceTag(
                                              price: calculatePrice(
                                                  value.map["products"][index]
                                                      ["price"],
                                                  value.map["products"][index]
                                                          ["percentage"]
                                                      ["percentage"])),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
      }),
    );
  }
}

class ProductImage extends StatelessWidget {
  bool isFav;
  String imgUrl;
  ProductImage({Key key, this.imgUrl, this.isFav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 8.0, bottom: 2.0),
      child: Container(
        width: isFav ? 120 : 150,
        height: isFav ? 120 : 150,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imgUrl), fit: BoxFit.contain)),
      ),
    );
  }
}
