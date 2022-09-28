import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:unicons/unicons.dart';

class PriceTag extends StatelessWidget {
  
  const PriceTag({ Key key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(UniconsLine.pricetag_alt,color: primaryBackgroundColor,),
        Text("100,000 - 150,000 Ks",style: GoogleFonts.poppins(fontSize: 13.0),)
      ],
    );
  }
}