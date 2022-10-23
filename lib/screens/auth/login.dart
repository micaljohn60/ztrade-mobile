import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  const Login({ Key key,this.toggleView }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
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

              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    label: Text("example123@gmail.com"),
                    hintText: 'Enter Email'
                  ),
                ),
              ),
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    label: Text("Password"),
                    hintText: 'Enter your password'
                  ),
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
                  
                  onPressed: (){},
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
                  TextButton(onPressed: (){}, child: const Text("Sign up"))
                ],
              ),
              
            ],
          )
      )
      ),
    );
  }
}