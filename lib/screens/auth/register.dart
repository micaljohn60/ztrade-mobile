import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';

class Register extends StatelessWidget {
  final Function toggleView;
  const Register({ Key key,this.toggleView }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Create Account",style: GoogleFonts.poppins(fontSize: 28.0,fontWeight: FontWeight.w500,color: primaryTextColor),),
                ),

                ],
              ),
             
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    label: Text("Username"),
                    hintText: 'Enter User Name'
                  ),
                ),
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
                    label: Text("Factory Name"),
                    hintText: 'Enter Factory Name'
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
               const Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    label: Text("Confirm Password"),
                    hintText: 'Re-type to Confirm password'
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  
                  onPressed: (){},
                  child: Text("Sign Up",style: GoogleFonts.poppins(fontSize: 25.0),),
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
                  TextButton(onPressed: (){}, child: const Text("Login"))
                ],
              ),
              
            ],
          )
      )
      ),
    );
  }
}