import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';

class Message extends StatelessWidget {
  const Message({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: secondayBackgroundColor,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/email.png',
                  height: 100,
        width: 100,),
                  Padding(
                    padding: const EdgeInsets.only(top :30.0),
                    child: Text("Please Check your email to \n verify your account",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18.0
                    ),),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}