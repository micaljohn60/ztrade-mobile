import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';

class FavouriteHeader extends StatelessWidget {
  const FavouriteHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3.0,
            blurRadius: 5.0,
            offset: Offset(0, 0.5)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("Favourite",style: GoogleFonts.poppins(fontSize: 20.0,color:primaryTextColor,fontWeight: FontWeight.w600)),
                const Padding(padding: EdgeInsets.only(left: 5.0),
                child: Icon(Icons.favorite,color: primaryTextColor,),
                ),
                
              ],
            ),
            Text("Z Trade",style: GoogleFonts.poppins(fontSize: 20.0,color:primaryTextColor,fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}