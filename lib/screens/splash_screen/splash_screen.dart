import 'dart:async';

import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Index()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondayBackgroundColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/logo_icon.png",
                        ),
                        fit: BoxFit.contain)),
              ),
              TweenAnimationBuilder(
                child: Text(
                  "Z Trade Myanmar",
                  style: TextStyle(
                      fontSize: 36,
                      color: primaryTextColor,
                      fontWeight: FontWeight.bold),
                ),
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500),
                builder: (BuildContext context, double _val, Widget child) {
                  return Opacity(
                    opacity: _val,
                    child: Padding(
                        padding: EdgeInsets.only(top: _val * 20), child: child),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
