import 'package:flutter/material.dart';
import 'package:omni_mobile_app/constants/color.dart';
import 'package:unicons/unicons.dart';

class Heart extends StatefulWidget {
  const Heart({ Key key }) : super(key: key);

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin{
  bool isFav = false;
   AnimationController _controller;
   Animation<Color> _colorAnimation;
   Animation<double> _sizeAnimation;
   Animation<double> _curve;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000)
      );

      _curve = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);    

      _colorAnimation = ColorTween(begin: Colors.grey[400], end: primaryBackgroundColor)
      .animate(_curve);    

     _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 25.0, end: 40.0),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 40.0, end: 25.0),
          weight: 50.0,
        ),
      ]
    ).animate(_curve);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    }); 
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller, 
      builder: (BuildContext context,_){
        return IconButton(
          onPressed: (){
            isFav ? _controller.reverse() : _controller.forward() ;
          }, 
          icon:  Icon(Icons.favorite,color: _colorAnimation.value,size: _sizeAnimation.value,));
      }
      );
  }
}