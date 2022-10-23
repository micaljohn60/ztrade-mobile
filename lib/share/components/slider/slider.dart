import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  ImageSlider({ Key key }) : super(key: key);

  final List<String> imgLists =[
  'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://www.junglescout.com/wp-content/uploads/2021/01/product-photo-water-bottle-hero.png',
   'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://www.junglescout.com/wp-content/uploads/2021/01/product-photo-water-bottle-hero.png',
   'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://www.junglescout.com/wp-content/uploads/2021/01/product-photo-water-bottle-hero.png',
  ];  

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgLists
    .map((item) => Container(
          child: Container(
           padding: EdgeInsets.only(top: 3.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  ],
                )),
          ),
        ))
    .toList();

    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.5,
          enlargeCenterPage: true,
        ),
        items: imageSliders,
      )
    );
  }
}