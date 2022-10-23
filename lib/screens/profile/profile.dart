import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/favourite/favourite.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Input{
  Icon icon;
  String type;
  String text;

  Input({this.icon, this.type, this.text});
}

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Input> widgetList = [
      Input(icon : const Icon(Icons.email,color: primaryBackgroundColor,),type: "email", text: "yorktownclass123@gmail.com"),
      Input(icon : const Icon(Icons.account_circle,color: primaryBackgroundColor),type: "text", text: "USS Enterprise"),
      Input(icon : const Icon(Icons.factory_rounded,color: primaryBackgroundColor),type: "text", text: "Factory Name"),
      Input(icon : const Icon(Icons.factory_rounded,color: primaryBackgroundColor),type: "number", text: "Phone Number"),

    ];
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: primaryBackgroundColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                              image: NetworkImage(
                                  "https://i.pinimg.com/736x/52/b3/42/52b3426275182447522e3fb53711e02e.jpg"),
                              fit: BoxFit.contain),
                          border: Border.all(
                              color: secondayBackgroundColor, width: 3.0))),
                ),
                
              ],
            ),
            TextButton(onPressed: (){}, child: Text("Change Profile Picture")),
            Form(
              child: Column(
                children: 
                  widgetList                    
                      .map((data) => inputLists(icon:data.icon, hint : data.text))
                      .toList()              
              ),
            ),

            InkWell(
              onTap: (){
                pushNewScreen(
                context,
                screen: Favourite(),
                
            );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                decoration: const BoxDecoration(                
                  border: Border(
                    top: BorderSide(
                      color: primaryBackgroundColor,
                      width: 2.0
                    ),
                    bottom: BorderSide(
                      color: primaryBackgroundColor,
                      width: 2.0
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                     Icon(Icons.favorite,color: primaryBackgroundColor,),
                     Padding(
                       padding: EdgeInsets.only(left : 8.0),
                       child: Text("Favourites Items",style: GoogleFonts.poppins(fontSize: 18.0)),
                     )
                    ],
                  ),
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: const BoxDecoration(                
                border: Border(
                  top: BorderSide(
                    color: primaryBackgroundColor,
                    width: 2.0
                  ),
                  bottom: BorderSide(
                    color: primaryBackgroundColor,
                    width: 2.0
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children:  [
                   const Icon(Icons.document_scanner,color: primaryBackgroundColor,),
                   Padding(
                     padding: const EdgeInsets.only(left : 8.0),
                     child: Text("Privacy Policy",style: GoogleFonts.poppins(fontSize: 18.0),),
                   )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget inputLists({Icon icon, String hint}) {
    return (Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryBackgroundColor)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            readOnly: true,
            initialValue: hint,
            // onSaved: (value) => email = value,
            onChanged: (value) {},
            decoration: InputDecoration(
                hintText: hint,
                icon: icon,
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: primaryBackgroundColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: primaryBackgroundColor),
                  borderRadius: BorderRadius.circular(15),
                )),
          ),
        ),
      ),
    ));
  }
}
