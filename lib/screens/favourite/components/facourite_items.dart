import 'package:flutter/material.dart';
import 'package:omni_mobile_app/screens/product_detail/product_detail.dart';
import 'package:omni_mobile_app/share/components/heart/heart.dart';
import 'package:omni_mobile_app/share/components/heart/heart_for_already_favourite.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/price_tag.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/product_title.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/most_popular.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FavouriteItems extends StatelessWidget {
  List<dynamic> products;
  String userID;
  FavouriteItems({
    Key key,
    this.products,
    this.userID
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String calculatePrice(String price, int percentage){

      if(percentage > 0){
       double data = int.parse(price) + (int.parse(price) * percentage / 100);
       return data.toString();
      }
      else{
       double data = int.parse(price) - (int.parse(price) * percentage / 100);
       return data.toString();
      }

    }



    return Container(
      height: MediaQuery.of(context).size.height/1.24,
      child: ListView.builder(
        itemCount: products.length,
      
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(6.0),
          child: InkWell(
            onTap: () {
                    pushNewScreen(context,
                        screen: ProductDetail(
                          title: products[index]["product"]["name"],
                          price: calculatePrice( products[index]["product"]["price"],products[index]["product"]["percentage"]["percentage"] ),
                          itemDescription: products[index]["product"]["item_description"],
                          category: products[index]["product"]["category"]["name"],
                          images: products[index]["product"]["product_image"],
                          favItems: products,
                          
                        ));
                  },
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
                        ProductImage(isFav: true,imgUrl: ZtradeAPI.productImageUrl + products[index]["product"]["product_image"][0]["thumbnails"].replaceAll('"', ''),),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
  
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width/2.3,
                                child: ProductTitle(text: products[index]["product"]["name"])),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PriceTag(price:  calculatePrice( products[index]["product"]["price"],products[index]["product"]["percentage"]["percentage"] )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              
                              child: SizedBox(
                                width: 150,
                                child: Text(        
                                                       
                                  products[index]["product"]["item_description"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            HeartForFavourite(
                              userId: userID,
                              productId: products[index]["product"]["id"].toString(),
                              wishLists: [],
                              isWishList: true,
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
      ),
    );
  }
}