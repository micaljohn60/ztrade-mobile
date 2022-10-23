import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:unicons/unicons.dart';

class ProductPriceTag extends StatelessWidget {
  const ProductPriceTag({ Key key }) : super(key: key);

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
              child: Text("100,000 - 150,000 Ks",style: GoogleFonts.poppins(fontSize: 16.0,color: secondayTextColor),),
            )
          ],
      ),
        ),
      ),
    );
  }
}