import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/api/api_response.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/auth/message.dart';
import 'package:omni_mobile_app/screens/category/components/loading/loading.dart';
import 'package:omni_mobile_app/services/authentication/register_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../share/components/snackbar/snackbar.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key key, this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  ApiResponse _apiResponse = ApiResponse();

  String name;
  String email;
  String password;
  String reTypePassword;
  String factoryName;
  bool isLoading = true;
  final TextEditingController _pass = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        _apiResponse = await registerUser(name, email, factoryName, password);

        if (_apiResponse.apiError == null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Message()));
        } else {
          setState(() {
            isLoading = false;
          });
        }
      
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Create Account",
                      style: GoogleFonts.poppins(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500,
                          color: primaryTextColor),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (value) => name = value,
                  decoration: InputDecoration(
                    label: Text("Username"),
                    hintText: 'Enter User Name',
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Please fill this form' : null,
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
                  onSaved: (value) => factoryName = value,
                  decoration: InputDecoration(
                      label: Text("Factory Name"),
                      hintText: 'Enter Factory Name'),
                      
                  validator: (value) =>
                      value.isEmpty ? 'Please fill this form' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _pass,
                  onSaved: (value) => password = value,
                  decoration: InputDecoration(
                      label: Text("Password"), hintText: 'Enter your password'),
                  validator: (value) =>
                      value.isEmpty ? 'Please fill this form' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (value) => reTypePassword = value,
                  decoration: InputDecoration(
                      label: Text("Confirm Password"),
                      hintText: 'Re-type to Confirm password'),
                  validator: (value) =>
                      value.isEmpty ? 'Please fill this form' : 
                      value != _pass.text ? 'Password Dont Match' : null
                      ,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    _handleSubmit();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(fontSize: 25.0),
                      ),
                      // isLoading ?
                      // const Icon(
                      //   // <-- Icon
                      //   Icons.circle,
                      //   size: 24.0,
                      // ):
                      const Icon(
                        // <-- Icon
                        Icons.navigate_next_rounded,
                        size: 24.0,
                      ),
                    ],
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
                    child: Text("Already have an account? "),
                  ),
                  TextButton(
                      onPressed: () {
                        widget.toggleView();
                      },
                      child: const Text("Login"))
                ],
              ),
            ],
          ),
        ),
      ))),
    );
  }
}
