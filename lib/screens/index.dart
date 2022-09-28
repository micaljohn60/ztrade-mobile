import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/screens/about/about.dart';
import 'package:omni_mobile_app/screens/category/category.dart';
import 'package:omni_mobile_app/screens/chat/chat.dart';
import 'package:omni_mobile_app/screens/favourite/favourite.dart';
import 'package:omni_mobile_app/screens/home/home.dart';
import 'package:omni_mobile_app/screens/profile/profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:unicons/unicons.dart';

class Index extends StatefulWidget {
  const Index({ Key key }) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {

  List<Widget> _buildScreens(){
    return(
      [
        Home(),
        Category(isHomePage: true,),
        About(),
        Chat(),
        Favourite()
      ]
    );
  }
  List<PersistentBottomNavBarItem> _navBarsItems(){
    return(
      [
        PersistentBottomNavBarItem(
          icon: Icon(UniconsLine.estate),
          title: "Home",
          activeColorPrimary: activeColor,
          inactiveColorPrimary: activeColor
        ),
        PersistentBottomNavBarItem(
          icon: Icon(UniconsLine.cube),
          title: "Category",
          activeColorPrimary: activeColor,
          inactiveColorPrimary: activeColor
        ),
        PersistentBottomNavBarItem(
          icon: Icon(UniconsLine.info_circle),
          title: "About",
          activeColorPrimary: activeColor,
          inactiveColorPrimary: activeColor
        ),
        PersistentBottomNavBarItem(
          icon: Icon(UniconsLine.comment),
          title: "Chat",
          activeColorPrimary: activeColor,
          inactiveColorPrimary: activeColor
        ),
        PersistentBottomNavBarItem(
          icon: Icon(UniconsLine.heart),
          title: "Profile",
          activeColorPrimary: activeColor,
          inactiveColorPrimary: activeColor          
        ) 
      ]
    );
  }
  

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return  Container(
        decoration: BoxDecoration(
          color: primaryBackgroundColor
        ),
        child: SafeArea(
          child: PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: primaryBackgroundColor,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: const NavBarDecoration(
              colorBehindNavBar: secondayTextColor
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.bounceIn,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style13,
            
            ),
        ),
      );
  }
}