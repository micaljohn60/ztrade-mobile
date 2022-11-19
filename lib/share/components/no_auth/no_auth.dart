import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/auth/authenticate.dart';
import 'package:omni_mobile_app/share/components/horizontal_slider_products/components/product_title.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NoAuth extends StatelessWidget {
  const NoAuth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please Login to Continue",
                  style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: primaryTextColor),
                ),
                TextButton(
                    onPressed: () {
                      pushNewScreen(
                        context,
                        screen: Authenticate(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Text('Login'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
