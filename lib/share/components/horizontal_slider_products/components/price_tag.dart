import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:unicons/unicons.dart';

class PriceTag extends StatelessWidget {
  final String price;
  PriceTag({ Key key, this.price }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(UniconsLine.pricetag_alt,color: primaryBackgroundColor,size: 15.0,),
        Text(price + " MMK",style: GoogleFonts.poppins(fontSize: 13.0),)
      ],
    );
  }
}