import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:unicons/unicons.dart';

class ProductPriceTag extends StatelessWidget {
  String price;
  ProductPriceTag({ Key key,this.price }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 220.0,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(20.0),
          color: primaryBackgroundColor
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
          children: [
            Icon(UniconsLine.pricetag_alt,color: secondayBackgroundColor,size: 18.0,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(price.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + " MMK",style: GoogleFonts.poppins(fontSize: 16.0,color: secondayTextColor),),
            )
          ],
      ),
        ),
      ),
    );
  }
}