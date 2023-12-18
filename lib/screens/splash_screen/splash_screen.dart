import 'dart:async';

import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/index.dart';
import 'package:provider/provider.dart';

import '../../providers/add_to_cart/add_to_cart_provider.dart';
import '../../services/secure_storage/custom_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CustomSecureStorage css = CustomSecureStorage();
  String token = "";

  Future<void> readToken() async {
    final String value = await css.readValueName("session_id");
    final String userToken = await css.readValue();
    setState(() {
      token = userToken;
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Index()));
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
                    image: const DecorationImage(
                        image: const AssetImage(
                          "assets/images/logo_icon.png",
                        ),
                        fit: BoxFit.contain)),
              ),
              TweenAnimationBuilder(
                child: const Text(
                  "Z Trade Myanmar",
                  style: TextStyle(
                      fontSize: 36,
                      color: primaryTextColor,
                      fontWeight: FontWeight.bold),
                ),
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
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
