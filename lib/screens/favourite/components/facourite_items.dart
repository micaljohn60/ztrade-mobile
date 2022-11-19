import 'package:flutter/material.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/price_tag.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/product_title.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/most_popular.dart';

class FavouriteItems extends StatelessWidget {
  const FavouriteItems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.24,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
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
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      ProductImage(isFav: true,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ProductTitle(text: "Product Title"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PriceTag(price: "1"),
                          ),
                          const Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("data"),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}