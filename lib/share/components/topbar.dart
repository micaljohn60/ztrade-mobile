import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/profile/profile.dart';
import 'package:omni_mobile_app/screens/search/search.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:unicons/unicons.dart';

class TopBar extends StatefulWidget {
  const TopBar({ Key key }) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

 
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: primaryBackgroundColor
      ),
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 65.0,
            width: size.width / 1.2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  pushNewScreen(
                    context,
                    screen: Search(text: value,),
                    withNavBar: true,
    );
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(UniconsLine.search,color: secondayBackgroundColor),
                  labelText: "Search",
                  labelStyle: TextStyle(color: secondayBackgroundColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const  BorderSide(width: 2, color: secondayBackgroundColor),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const  BorderSide(width: 2, color: secondayBackgroundColor),
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
              ),
            ),
          ),
          IconButton(onPressed: ()=>{
            
            pushNewScreen(
                context,
                screen: Profile(),
                
            )
          }, icon: Icon(UniconsLine.user,size: 30.0,color: secondayBackgroundColor,))

        ],
      ),
    );
  }
}