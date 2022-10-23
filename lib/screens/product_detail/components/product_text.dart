import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductText extends StatelessWidget {
  String prefix;
  String data;
  double fontSize;
  ProductText({ Key key , this.prefix,this.data,this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(prefix + " - " + data,style: GoogleFonts.poppins(fontSize: 15.0,fontWeight: FontWeight.w500)),
    );
  }
}