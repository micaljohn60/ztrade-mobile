import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/api/api_response.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/main.dart';
import 'package:omni_mobile_app/providers/app_providers.dart';
import 'package:omni_mobile_app/screens/home/home.dart';
import 'package:omni_mobile_app/screens/index.dart';
import 'package:omni_mobile_app/services/authentication/login_service.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/user.dart';
import '../../share/components/snackbar/snackbar.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  const Login({Key key, this.toggleView}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ApiResponse _apiResponse = ApiResponse();
  CustomSecureStorage css = CustomSecureStorage();

  String email;
  String password;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Uri _forgetPassword =
      Uri.parse('https://appstaging.ztrademm.com/passwordforgot');
  void _launchUrl() async {
    if (!await launchUrl(_forgetPassword)) throw 'Could not launch $_launchUrl';
  }

  void _handleSubmit() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar("Please Fix Error First"));
    } else {
      setState(() {
        isLoading = true;
      });
      form.save();
      _apiResponse = await loginUser(email, password);
    }
    if (_apiResponse.apiError == null) {
      css.writeData('token', (_apiResponse.data as User).token);
      css.writeData('session_id', (_apiResponse.data as User).userId);
      css.writeData('email', (_apiResponse.data as User).email);
      css.writeData('username', (_apiResponse.data as User).username);
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const MyHomePage();
          },
        ),
        (_) => false,
      );
      //  pushNewScreen(context, screen: MyHomePage());
      //  Navigator.of(context).pushReplacement(
      //    MaterialPageRoute(builder: (context) => MyHomePage()
      //    )
      //  );
    } else {
      Map data = _apiResponse.apiError;
      ScaffoldMessenger.of(context).showSnackBar(snackBar(data["message"]));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBackgroundColor,
      child: SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 180,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/icon.png"),
                        fit: BoxFit.cover)),
              ),
              Text(
                "Welcome Back",
                style: GoogleFonts.poppins(
                    fontSize: 28.0, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sign in to continue",
                  style: GoogleFonts.poppins(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (value) => email = value,
                  decoration: InputDecoration(
                      label: Text("example123@gmail.com"),
                      hintText: 'Enter Email'),
                  validator: (value) =>
                      value.isEmpty ? 'Please fill this form' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (value) => password = value,
                  decoration: InputDecoration(
                      label: Text("Password"), hintText: 'Enter your password'),
                  validator: (value) =>
                      value.isEmpty ? 'Please fill this form' : null,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {_launchUrl();}, child: Text("Forget Password?"))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    _handleSubmit();
                  },
                  child: Text(
                    "Log in",
                    style: GoogleFonts.poppins(fontSize: 25.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: primaryBackgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 5),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Don't have an account? "),
                  ),
                  TextButton(
                      onPressed: () => widget.toggleView(),
                      child: const Text("Sign up"))
                ],
              ),
            ],
          ),
        ),
      ))),
    );
  }
}
