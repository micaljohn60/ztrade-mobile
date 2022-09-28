import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';

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
      Input(icon : const Icon(Icons.factory_rounded,color: primaryBackgroundColor),type: "text", text: "US Navy"),

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
            Form(
              child: Column(
                children: 
                  widgetList                    
                      .map((data) => inputLists(icon:data.icon, hint : data.text))
                      .toList()              
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
