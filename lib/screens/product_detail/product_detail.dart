import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/product_detail/components/product_description.dart';
import 'package:omni_mobile_app/screens/product_detail/components/product_image.dart';
import 'package:omni_mobile_app/screens/product_detail/components/product_price_tag.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/product_title.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/most_popular.dart';
import 'package:omni_mobile_app/share/components/related_products/related_products.dart';
import 'package:omni_mobile_app/share/components/topbar.dart';

class ProductDetail extends StatefulWidget {
  String title;
  List<dynamic> images;
  String price;
  String itemDescription;
  String category;
  List<dynamic> favItems;
  ProductDetail({Key key,this.title,this.price,this.itemDescription,this.images,this.category,this.favItems}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  CustomSecureStorage css = CustomSecureStorage();
  String newValue = "n";
  bool isLoading = true;
  Future<void> readToken() async {
    final String value = await css.readValueName("session_id");
    setState(() {
      newValue = value;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    readToken();
    super.initState();
  }

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
                        text: widget.title,
                      ),
                      ProductDetailImage(images: widget.images),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProductPriceTag(price: widget.price,),
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
                            ProductTitle(text: widget.title),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                  widget.itemDescription
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
                      
                      RelatedProducts(title: "Related Products",products: [],wishLists: widget.favItems ?? [],userId: newValue,data: widget.title,)
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
