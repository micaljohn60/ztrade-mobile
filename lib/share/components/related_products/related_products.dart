import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/screens/category/components/loading/loading.dart';
import 'package:omni_mobile_app/screens/product_detail/product_detail.dart';
import 'package:omni_mobile_app/services/product/product.dart';
import 'package:omni_mobile_app/share/components/heart/heart.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/price_tag.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/product_title.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class RelatedProducts extends StatefulWidget {
  String title;
  String userId;
  List<dynamic> products;
  List<dynamic> wishLists;

  RelatedProducts(
      {Key key, this.title, this.userId, this.products, this.wishLists})
      : super(key: key);

  @override
  State<RelatedProducts> createState() => _RelatedProductsState();
}

class _RelatedProductsState extends State<RelatedProducts> {
  @override
  Widget build(BuildContext context) {
    bool checkInWishList(List<dynamic> list, String productId) {
      for (int i = 0; i < list.length; i++) {
        if (list[i]["product_id"].toString() == productId) {
          return true;
        }
      }
      return false;
    }

    context.read<ProductService>().fetchData;
    var size = MediaQuery.of(context).size;
    return Consumer<ProductService>(
      builder: ((context, value, child) {
        return value.map.length == 0 && !value.error
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
                          width: size.width,
                          child: ListView.builder(
                            itemCount: value.map.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: InkWell(
                                onTap: () {
                                  pushNewScreen(context,
                                      screen: ProductDetail(
                                        favItems: [],
                                        title: value.map[index]["name"],
                                        price: value.map[index]["price"],
                                        itemDescription: value.map[index]
                                            ["item_description"],
                                        category: value.map[index]["category"]
                                            ["name"],
                                        images: value.map[index]
                                            ["product_image"],
                                      ));
                                },
                                child: Container(
                                  width: 160,
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
                                      children: [
                                        Container(
                                            width: size.width / 2.1,
                                            alignment: Alignment.centerRight,
                                            child: Heart(
                                              userId: widget.userId,
                                              productId: value.map[index]["id"]
                                                  .toString(),
                                              wishLists: widget.wishLists,
                                              isWishList: checkInWishList(
                                                  widget.wishLists,
                                                   value.map[index]["id"]
                                                      .toString()),
                                            )),
                                        ProductImage(
                                          imgUrl: ZtradeAPI.productImageUrl +
                                              value.map[index]["product_image"]
                                                      [0]["thumbnails"]
                                                  .replaceAll('"', ''),
                                          isFav: false,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                  value.map[index]["name"],
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16.0,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 5.0),
                                          child: PriceTag(
                                              price: value.map[index]["price"]),
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
                image: NetworkImage(imgUrl), fit: BoxFit.cover)),
      ),
    );
  }
}
