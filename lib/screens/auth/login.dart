import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/api/api_response.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/home/home.dart';
import 'package:omni_mobile_app/screens/index.dart';
import 'package:omni_mobile_app/services/authentication/login_service.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';

import '../../model/user.dart';
import '../../share/components/snackbar/snackbar.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  const Login({ Key key,this.toggleView }) : super(key: key);

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

  void _handleSubmit() async{
    final FormState form = _formKey.currentState;
    if(!form.validate()){
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar("Please Fix Error First"));
    }
    else{
      setState(() {
        isLoading = true;
      });
      form.save();
      _apiResponse = await loginUser(email, password);
    }
    if (_apiResponse.apiError == null) {
        print((_apiResponse.data as User).token);
         css.writeData('token', (_apiResponse.data as User).token);
         Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => Home()
           )
         );
    } else {
      
      Map data = _apiResponse.apiError;     
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar(data["message"]));
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
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://m.media-amazon.com/images/I/41x7edQd+EL._AC_SY580_.jpg'),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                Text("Welcome Back",style: GoogleFonts.poppins(fontSize: 28.0,fontWeight: FontWeight.w700),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sign in to continue",style: GoogleFonts.poppins(fontSize: 20.0),),
                ),
          
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                     onSaved: (value) => email = value,
                    decoration: InputDecoration(
                      label: Text("example123@gmail.com"),
                      hintText: 'Enter Email'
                    ),
                    validator: (value) =>
                    value.isEmpty ? 'Please fill this form' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (value) => password = value,
                    decoration: InputDecoration(
                      label: Text("Password"),
                      hintText: 'Enter your password'
                    ),
                    validator: (value) =>
                    value.isEmpty ? 'Please fill this form' : null,
                  ),
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child: Text("Forget Password?"))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    
                    onPressed: (){
                      
                       _handleSubmit();
                    },
                    child: Text("Log in",style: GoogleFonts.poppins(fontSize: 25.0),),
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
                    TextButton(onPressed: ()=>
                      widget.toggleView()
                    , child: const Text("Sign up"))
                  ],
                ),
                
              ],
            ),
          )
      )
      ),
    );
  }
}