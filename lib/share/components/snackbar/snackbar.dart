import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';

snackBar(String value) => SnackBar(
  elevation: 6.0,
  backgroundColor: primaryBackgroundColor,
  behavior: SnackBarBehavior.floating,
  content: Text(value),
 
);