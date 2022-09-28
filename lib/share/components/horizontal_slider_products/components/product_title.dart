import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTitle extends StatelessWidget {
  String text;
  ProductTitle({ Key key, this.text }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.poppins(fontSize: 20.0, fontWeight: FontWeight.w700),textAlign: TextAlign.left,);
  }
}