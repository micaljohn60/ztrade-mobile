import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_mobile_app/api/api_response.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:omni_mobile_app/services/wishlist_service/wish_list_service.dart';
import 'package:omni_mobile_app/share/components/snackbar/snackbar.dart';

class Heart extends StatefulWidget {
  String userId;
  String productId;
  bool isWishList;
  List<dynamic> wishLists;
  Heart({Key key, this.userId, this.productId,this.isWishList,this.wishLists}) : super(key: key);

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {

  bool isFav = false;
  bool favWish = true;
  bool isNewWishlist = false;
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;
  Animation<double> _curve;

  ApiResponse _apiResponse = ApiResponse();



  Future<void> updateState() async {
    
    if(widget.isWishList){
          print("Yes");
        }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState

  //   super.initState();   
  //   // bool data = checkInWishList(widget.wishLists,widget.productId);
   

  //   // _controller = AnimationController(
  //   //     vsync: this, duration: const Duration(milliseconds: 1000));

  //   // _curve = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

  //   // if(isFav){
  //   //   _colorAnimation =
  //   //     ColorTween(begin:primaryBackgroundColor , end: Colors.grey[400],)
  //   //         .animate(_curve);
  //   // }
  //   // else{
  //   //   _colorAnimation =
  //   //     ColorTween(begin: Colors.grey[400], end: primaryBackgroundColor)
  //   //         .animate(_curve);
  //   // }

    

  //   // _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
  //   //   TweenSequenceItem<double>(
  //   //     tween: Tween<double>(begin: 25.0, end: 40.0),
  //   //     weight: 50.0,
  //   //   ),
  //   //   TweenSequenceItem<double>(
  //   //     tween: Tween<double>(begin: 40.0, end: 25.0),
  //   //     weight: 50.0,
  //   //   ),
  //   // ]).animate(_curve);

  //   // _controller.addStatusListener((status) {
  //   //   if (status == AnimationStatus.completed) {
  //   //     setState(() {
  //   //       isFav = true;
  //   //     });
  //   //   }
  //   //   if (status == AnimationStatus.dismissed) {
  //   //     setState(() {
  //   //       isFav = false;
  //   //     });
  //   //   }
  //   // });
  // }


  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {    

   

    void addToWishList(bool myFav) async {
      if (widget.userId != null) {
        if(myFav){
          setState(() {
            favWish = false;
            isNewWishlist = false;
          });
          _apiResponse = await removeFromFavourite(widget.userId, widget.productId);
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar("Removed From Favourite"));
          
        }
        else{
          if(isNewWishlist){
              setState(() {
              favWish = true;
              isNewWishlist = false;
            });
            
            _apiResponse = await removeFromFavourite(widget.userId, widget.productId);
            ScaffoldMessenger.of(context)
              .showSnackBar(snackBar("Removed from Favourite"));
              
          }
          else{
             setState(() {
            favWish = false;
            isNewWishlist = true;
          });
            
            _apiResponse = await addToFavourite(widget.userId, widget.productId);
            ScaffoldMessenger.of(context)
              .showSnackBar(snackBar("Added To Favourite"));
          }
          
          

          

          
        }
        

          // _controller.forward();
          
        
      }
      else{
         showDialog(
                context: context,
                builder: (ctx) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: AlertDialog(
                    title: const Text("Can't Add to Favourite"),
                    content: const Text("You Need to Login to use this feature"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          color:  primaryBackgroundColor,
                          padding: const EdgeInsets.all(14),
                          child: Text("okay",style: GoogleFonts.poppins(color: secondayTextColor),),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }
    }

    // return AnimatedBuilder(
    //     animation: _controller,
    //     builder: (BuildContext context, _) {
    //       return IconButton(
    //           onPressed: () {
    //             addToWishList();
    //           },
    //           icon: Icon(
    //             Icons.favorite,
    //             color: _colorAnimation.value,
    //             size: _sizeAnimation.value,
    //           ));
    //     });

   
          return widget.isWishList && favWish ||  isNewWishlist?
          IconButton(
              onPressed: () {
                addToWishList(widget.isWishList);
              },
              icon: const Icon(
                Icons.favorite,
                color: primaryBackgroundColor 
                // size: _sizeAnimation.value,
              ))
              :
              IconButton(
              onPressed: () {
                addToWishList(false);
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.grey[400] ,
                // size: _sizeAnimation.value,
              ));

      
  }
}
