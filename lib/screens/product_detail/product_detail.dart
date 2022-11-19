import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/product_detail/components/product_description.dart';
import 'package:omni_mobile_app/screens/product_detail/components/product_image.dart';
import 'package:omni_mobile_app/screens/product_detail/components/product_price_tag.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/product_title.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/most_popular.dart';
import 'package:omni_mobile_app/share/components/topbar.dart';

class ProductDetail extends StatelessWidget {
  String title;
  List<dynamic> images;
  String price;
  String itemDescription;
  String category;
  ProductDetail({Key key,this.title,this.price,this.itemDescription,this.images,this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: secondayBackgroundColor,
          body: Column(
            children: [
              TopBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductTitle(
                        text: title,
                      ),
                      ProductDetailImage(images: images),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProductPriceTag(price: price,),
                        ],
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
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ProductTitle(text: title),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                  itemDescription
                                  ,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.0
                                  ),
                                  textAlign: TextAlign.justify,
                                  maxLines: 10,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      HorizontalSliderProducts(title: "Related Products",)
                    ],
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
