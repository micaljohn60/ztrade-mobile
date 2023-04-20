import 'package:flutter/material.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';

class ImageBanner extends StatelessWidget {
  String image;
  ImageBanner({ Key key , this.image}) : super(key: key);
  // String link = ZtradeAPI.baseUrl + "storage/banner_image/"+image;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: size.width,
        height: 150,
        decoration: BoxDecoration(
          
          image: DecorationImage(
            image: NetworkImage(ZtradeAPI.baseUrl + "storage/banner_image/"+image),
            fit: BoxFit.contain,
            
          )
        ),
      ),
    );
  }
}