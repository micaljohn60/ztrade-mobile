import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omni_mobile_app/constants/color.dart';

void showToastMessage(String str) => Fluttertoast.showToast(
    msg: str,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: primaryBackgroundColor,
    textColor: Colors.white,
    fontSize: 16.0);
