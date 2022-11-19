import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  ImageBanner({ Key key }) : super(key: key);
  String link ="https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(link),
            fit: BoxFit.cover,
            
          )
        ),
      ),
    );
  }
}