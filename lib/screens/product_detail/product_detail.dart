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
  const ProductDetail({Key key}) : super(key: key);

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
                        text: "I Phone 13 Pro Max",
                      ),
                      ProductDetailImage(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProductPriceTag(),
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
                            ProductTitle(text: "Product Description"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
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
