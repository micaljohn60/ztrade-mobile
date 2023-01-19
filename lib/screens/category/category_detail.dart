import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/services/category/category_with_product.dart';
import 'package:omni_mobile_app/share/components/no_items/no_item.dart';
import 'package:omni_mobile_app/share/components/topbar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../providers/app_providers.dart';
import '../../static/ztradeAPI.dart';
import '../product_detail/product_detail.dart';

class CategoryDetail extends StatelessWidget {
  String title;
  String categoryId;
  List<dynamic> wishLists;
  CategoryDetail({Key key, this.title,this.categoryId,this.wishLists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    var size = MediaQuery.of(context).size;
    context.read<CategoryWithProduct>().fetchData(categoryId);

    return WillPopScope(
      onWillPop: (){
        
        AppProviders.disposeCategoryWithProductProvider(context);
      },
      child: Scaffold(
        backgroundColor: secondayBackgroundColor,
        body: Consumer<CategoryWithProduct>(
        builder: ((context, value, child) {
          return value.map.length == 0 && !value.error
              ? Center(
                  child: Text("Loading"),
                )
              : value.error
                  ? Center(
                      child: Text(value.errorMessage),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TopBar(),
                            value.map["product"].length == 0 ?
                            NoItem(errorText : "No Item for This Category : " + title)
                            :
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0, top: 15.0),
                              child: Text(
                                "Category : " + title,
                                style: GoogleFonts.poppins(
                                    fontSize: 20.0, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisCount: size.width > 600 ? 4 : 3,
                                  childAspectRatio: size.width > 600 ? 1 : 0.7,
                                  shrinkWrap: true,
                                  children: value.map["product"]
                                      .map<Widget>((e) => listItem(
                                          Colors.white, "title", context, e))
                                      .toList()),
                            )
                          ],
                        ),
                      ),
                    );
        }),
      )),
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
                  price: e["price"],
                  favItems: wishLists ?? [],
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: NetworkImage(
                                ZtradeAPI.productImageUrl+e["product_image"][0]["thumbnails"].replaceAll('"',"")),
                            fit: BoxFit.contain)),
                    height: 110.0,
                    width: 100,
                  ),
                ),
                Flexible(child: Text(e["name"],maxLines: 1,overflow: TextOverflow.ellipsis,))
              ],
            ),
          ),
        ),
      );
}
