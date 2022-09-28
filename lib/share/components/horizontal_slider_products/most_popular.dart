import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/share/components/heart/heart.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/price_tag.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/product_title.dart';

class HorizontalSliderProducts extends StatelessWidget {
  String title;
  HorizontalSliderProducts({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        Container(
                            width: size.width / 2.1,
                            alignment: Alignment.centerRight,
                            child: Heart()),
                        ProductImage(isFav: false,),
                        Text("Product title",style: GoogleFonts.poppins(fontSize:16.0,)),
                        PriceTag()
                      ],
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
  ProductImage({
    Key key,
    this.isFav
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0,right: 8.0,bottom: 2.0),
      child: Container(
        width: isFav ? 120 : 150,
        height: isFav ? 120 : 150,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://cmhlprodblobstorage1.blob.core.windows.net/sys-master-cmhlprodblobstorage1/h64/hcf/9025486946334/cmhl_1000000001505_2_hero.jpg_Default-WorkingFormat_110Wx110H"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
