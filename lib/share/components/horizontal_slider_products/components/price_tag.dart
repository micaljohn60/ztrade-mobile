import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:unicons/unicons.dart';

class PriceTag extends StatelessWidget {
  final String price;
  PriceTag({Key key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          UniconsLine.pricetag_alt,
          color: primaryBackgroundColor,
          size: 18.0,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          price.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]},') +
              " MMK",
          style: GoogleFonts.poppins(fontSize: 15.0),
          overflow: TextOverflow.fade,
        )
      ],
    );
  }
}
