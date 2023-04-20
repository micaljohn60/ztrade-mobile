import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/product_detail/product_detail.dart';
import 'package:omni_mobile_app/share/components/heart/heart.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/price_tag.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LatestProducts extends StatelessWidget {
  String userId;
  List<dynamic> products;
  List<dynamic> wishLists;
  LatestProducts({Key key, this.products, this.userId, this.wishLists})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: size.width > 600 ? 3 : 2,
      childAspectRatio: size.width > 600 ? 0.9 : 0.65,
      shrinkWrap: true,
      children: products
              .map<Widget>((e) => listItem(
                  Colors.white, "title", context, e))
              .toList()
    );
  }

  Widget listItem(Color color, String title, BuildContext context, dynamic e) =>
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          onTap: () {
            pushNewScreen(
              context,
              screen: ProductDetail(
                title: e["name"],
                itemDescription: e["item_description"],
                category: "No Data in API",
                images: e["product_image"],
                price:
                    calculatePrice(e["price"], e["percentage"]["percentage"]),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0)
            ], color: color, borderRadius: BorderRadius.circular(8.0)),
            height: 160.0,
            width: 100,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width /2.1,
                  alignment: Alignment.centerRight,
                  child: Heart(
            userId: userId,
                productId: e["id"].toString(),
                wishLists: wishLists,
                isWishList: checkInWishList(wishLists, e["id"].toString())
          ),
                ),
                Container(
                  decoration: BoxDecoration(
                      
                      image: DecorationImage(
                          image: NetworkImage(ZtradeAPI.productImageUrl +
                              e["product_image"][0]["thumbnails"]
                                  .replaceAll('"', "")),
                          fit: BoxFit.cover)),
                  height: 110.0,
                  width: 160,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    e["name"] + " " + e["item_description"],
                    style: GoogleFonts.poppins(
                        fontSize: 15.0,
                        color: shadowColorLight,
                        fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PriceTag(
                    price: calculatePrice(
                        e["price"], e["percentage"]["percentage"]),
                  ),
                ))
              ],
            ),
          ),
        ),
      );
}
