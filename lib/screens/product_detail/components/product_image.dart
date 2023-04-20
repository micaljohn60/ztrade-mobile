import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';

class ProductDetailImage extends StatefulWidget {
  List<dynamic> images;
  ProductDetailImage({ Key key, this.images }) : super(key: key);

  @override
  State<ProductDetailImage> createState() => _ProductDetailImageState();

  
}

class _ProductDetailImageState extends State<ProductDetailImage> {
   String image = '';
  // List<String> images = [
  //   "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iPhone-13-Pro_iPhone-13-Pro-Max_09142021_inline.jpg.large.jpg",
  //   "https://static.toiimg.com/thumb/resizemode-4,msid-79729969,width-1200,height-900/79729969.jpg",
  //   "https://i.ebayimg.com/images/g/wkUAAOSwlvthQ5FM/s-l1600.jpg"
  // ];

  @override
  void initState() {
    // TODO: implement initState
    image = ZtradeAPI.productImageUrl+widget.images[0]["thumbnails"].replaceAll('"', '');
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 250.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(image,),
                fit: BoxFit.contain
              )
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            itemBuilder: (BuildContext context,int index){
              
            return InkWell(
              onTap: (){
                setState(() {
                  image = ZtradeAPI.productImageUrl+widget.images[index]["thumbnails"].replaceAll('"', '');
                });
              },
              child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                  width: 100,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: primaryBackgroundColor,width: 2.0),
                      image: DecorationImage(
                        image: NetworkImage(ZtradeAPI.productImageUrl+widget.images[index]["thumbnails"].replaceAll('"', '')),
                        fit: BoxFit.cover
                      )
                  ),
                ),
                    ),
            );
          }),
        ),

      ],
    );
  }
}