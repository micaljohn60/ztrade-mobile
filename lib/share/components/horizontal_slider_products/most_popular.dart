import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/category/components/loading/loading.dart';
import 'package:omni_mobile_app/screens/product_detail/product_detail.dart';
import 'package:omni_mobile_app/services/product/product.dart';
import 'package:omni_mobile_app/share/components/heart/heart.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/price_tag.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/product_title.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HorizontalSliderProducts extends StatelessWidget {
  String title;
  String userId;
  List<dynamic> products;
  List<dynamic> wishLists;
  HorizontalSliderProducts(
      {Key key, this.title, this.products, this.userId, this.wishLists})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String calculatePrice(String price, int percentage) {
      double data = int.parse(price) + (int.parse(price) * percentage / 100);
      return data.toString();
    }

    bool checkInWishList(List<dynamic> list, String productId) {
      for (int i = 0; i < list.length; i++) {
        if (list[i]["product_id"].toString() == productId) {
          return true;
        }
      }
      return false;
    }

    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 330,
      width: size.width,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductTitle(text: title),
            ),
          ),
          SizedBox(
            height: 280,
            width: size.width,
            child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(6.0),
                child: InkWell(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: ProductDetail(
                        id: products[index]["id"],
                        title: products[index]["name"],
                        price: calculatePrice(products[index]["price"],
                            products[index]["percentage"]["percentage"]),
                        itemDescription: products[index]["item_description"],
                        category: products[index]["category"]["name"],
                        images: products[index]["product_image"],
                        favItems: wishLists,
                      ),
                    );
                    print(
                        "this is product id =======>${products[index]["id"]}");
                  },
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(7.0),
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
                                userId: userId,
                                productId: products[index]["id"].toString(),
                                wishLists: wishLists,
                                isWishList: checkInWishList(wishLists,
                                    products[index]["id"].toString()),
                              )),
                          ProductImage(
                            imgUrl: ZtradeAPI.productImageUrl +
                                products[index]["product_image"][0]
                                        ["thumbnails"]
                                    .replaceAll('"', ''),
                            isFav: false,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: checkInWishList(wishLists,
                                          products[index]["id"].toString())
                                      ? Text(products[index]["name"],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16.0,
                                              color: shadowColorLight,
                                              fontWeight: FontWeight.w700))
                                      : Text(products[index]["name"],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16.0,
                                          )),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                            child: PriceTag(
                                price: calculatePrice(
                                    products[index]["price"],
                                    products[index]["percentage"]
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
  }
}

class ProductImage extends StatelessWidget {
  bool isFav;
  String imgUrl;
  ProductImage({Key key, this.imgUrl, this.isFav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFav ? 120 : 160,
      height: isFav ? 120 : 160,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imgUrl), fit: BoxFit.contain)),
    );
  }
}
