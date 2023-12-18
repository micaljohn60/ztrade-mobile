import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/services/category/category_with_product.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/price_tag.dart';
import 'package:omni_mobile_app/share/components/no_items/no_item.dart';
import 'package:omni_mobile_app/share/components/topbar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../providers/app_providers.dart';
import '../../static/ztradeAPI.dart';
import '../product_detail/product_detail.dart';

class CategoryDetail extends StatefulWidget {
  int id;
  String title;
  String categoryId;
  List<dynamic> wishLists;
  CategoryDetail(
      {Key key, this.id, this.title, this.categoryId, this.wishLists})
      : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  String calculatePrice(String price, int percentage) {
    if (percentage > 0) {
      double data = int.parse(price) + (int.parse(price) * percentage / 100);
      return data.toString();
    } else {
      double data = int.parse(price) - (int.parse(price) * percentage / 100);
      return data.toString();
    }
  }

  String _chosenValue = "1";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    context.read<CategoryWithProduct>().fetchData(widget.categoryId, "1");

    return WillPopScope(
      onWillPop: () {
        AppProviders.disposeCategoryWithProductProvider(context);
      },
      child: Scaffold(
          backgroundColor: secondayBackgroundColor,
          body: Consumer<CategoryWithProduct>(
            builder: ((context, value, child) {
              return value.map.length == 0 && !value.error
                  ? const Center(
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
                                const TopBar(),
                                value.map["data"].length == 0
                                    ? NoItem(
                                        errorText:
                                            "No Item for This Category : " +
                                                widget.title)
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            bottom: 8.0,
                                            top: 15.0),
                                        child: Text(
                                          "Category : " + widget.title,
                                          style: GoogleFonts.poppins(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .white, //background color of dropdown button
                                    border: Border.all(
                                        color: primaryBackgroundColor,
                                        width: 1), //border of dropdown button
                                    borderRadius: BorderRadius.circular(
                                        10), //border raiuds of dropdown button
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: DropdownButton(
                                      items: List<int>.generate(
                                              value.map["last_page"],
                                              (i) => i + 1)
                                          .map<DropdownMenuItem<String>>(
                                              (int value) {
                                        return DropdownMenuItem<String>(
                                          value: value.toString(),
                                          child: Text(
                                            value.toString(),
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      value: _chosenValue,
                                      onChanged: (String value) {
                                        setState(() {
                                          _chosenValue = value;
                                          context
                                              .read<CategoryWithProduct>()
                                              .fetchData(widget.categoryId,
                                                  _chosenValue);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.count(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      crossAxisCount: size.width > 600 ? 3 : 2,
                                      childAspectRatio:
                                          size.width > 600 ? 0.9 : 0.7,
                                      shrinkWrap: true,
                                      children: value.map["data"]
                                          .map<Widget>((e) => listItem(
                                              Colors.white,
                                              "title",
                                              context,
                                              e))
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
                id: e['id'],
                title: e["name"],
                itemDescription: e["item_description"],
                category: "No Data in API",
                images: e["product_image"],
                price:
                    calculatePrice(e["price"], e["percentage"]["percentage"]),
                favItems: widget.wishLists ?? [],
              ),
            );
            print('this is product id==>${e['id']}');
          },
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0)
            ], color: color, borderRadius: BorderRadius.circular(8.0)),
            height: 80.0,
            width: 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: NetworkImage(ZtradeAPI.productImageUrl +
                                e["product_image"][0]["thumbnails"]
                                    .replaceAll('"', "")),
                            fit: BoxFit.contain)),
                    height: 140.0,
                    width: 120,
                  ),
                ),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    e["name"] + " " + e["item_description"],
                    style: GoogleFonts.poppins(
                        fontSize: 15.0,
                        color: shadowColorLight,
                        fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
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
