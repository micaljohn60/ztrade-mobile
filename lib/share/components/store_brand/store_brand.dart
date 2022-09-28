import 'package:flutter/material.dart';

import '../horizontal_slider_products/components/product_title.dart';
import '../horizontal_slider_products/most_popular.dart';

class StoreBrand extends StatelessWidget {
  String title;
  StoreBrand({ Key
   key, this.title }) : super(key: key);
  String link ="https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(     
      height: 220,
      width: size.width,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductTitle(text: title),
            ),
          ),
          SizedBox(
            height: 170,
            width: size.width,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => 
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    
                    boxShadow: const [
                      BoxShadow(
                         offset: Offset(0, 14),
        spreadRadius: -11,
        blurRadius: 21,
        color: Color.fromRGBO(205, 205, 205, 1),
                      )
                    ]
                    
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(link),
                          fit: BoxFit.cover
                        )
                        
                      ),
                    ),
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}