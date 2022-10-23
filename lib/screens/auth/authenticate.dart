import 'package:flutter/material.dart';
import 'package:omni_mobile_app/screens/auth/login.dart';
import 'package:omni_mobile_app/screens/auth/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({ Key key }) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {

    bool showLogIn = true;

    void toggleView(){
      setState(()=> showLogIn = !showLogIn);
    }

     if(showLogIn){
     return Login(toggleView: toggleView);
   }
   else {
     return Register(toggleView: toggleView,);
   }
  }
}