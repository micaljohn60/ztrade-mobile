import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/screens/category/components/loading/loading.dart';
import 'package:omni_mobile_app/services/brand/store_with_products.dart';
import 'package:omni_mobile_app/share/components/topbar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../static/ztradeAPI.dart';
import '../product_detail/product_detail.dart';

class StoreDetail extends StatelessWidget {
  String title;
  String storeId;
  StoreDetail({Key key, this.title,this.storeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.read<StoreWithProduct>().fetchData(storeId);

    return Scaffold(body: Consumer<StoreWithProduct>(
      builder: ((context, value, child) {
        return value.map.length == 0 && !value.error
            ? Center(
                child: Loading(height: 150,),
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

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0, top: 15.0),
                            child: Text(
                              title,
                              style: GoogleFonts.poppins(
                                  fontSize: 20.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                          GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: size.width > 600 ? 4 : 3,
                              childAspectRatio: size.width > 600 ? 1 : 0.7,
                              shrinkWrap: true,
                              children: value.map["data"]["product"]
                                  .map<Widget>((e) => listItem(
                                      Colors.white, "title", context, e))
                                  .toList())
                        ],
                      ),
                    ),
                  );
      }),
    ));
  }

  Widget listItem(Color color, String title, BuildContext context, dynamic e) =>
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          onTap: () {
            pushNewScreen(
                context,
                screen: ProductDetail(title: e["name"],itemDescription: e["item_description"],category: "No Data in API",images: e["product_image"],price: e["price"],),

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
                Text(e["name"])
              ],
            ),
          ),
        ),
      );
}
