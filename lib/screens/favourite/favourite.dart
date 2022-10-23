import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/favourite/components/facourite_items.dart';
import 'package:omni_mobile_app/screens/favourite/components/favourite_header.dart';

class Favourite extends StatelessWidget {
  const Favourite({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: secondayBackgroundColor,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: const [
                FavouriteHeader(),
                Flexible(child: FavouriteItems())
                ,
              ],
            )
          ),
        ),
      ),
    );
  }
}



