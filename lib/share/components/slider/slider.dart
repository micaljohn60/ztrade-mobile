import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:omni_mobile_app/services/slider/carousel_slider_service.dart';
import 'package:omni_mobile_app/share/components/slider/components/slider_loading.dart';
import 'package:provider/provider.dart';

import '../../../static/ztradeAPI.dart';

class ImageSlider extends StatelessWidget {
  ImageSlider({ Key key }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    
    context.read<CarouselSliderService>().fetchData;

    return Consumer<CarouselSliderService>(
        builder: ((context, value, child) {
          return value.map.length == 0 && !value.error && !value.empty ?
         SliderLoading()
          :
          value.error ?
          Center(
            child: Text(value.errorMessage),
          )
          :
          value.empty ?
          Center(child: Text("No Data"),)
          :
          Container(
            child: CarouselSlider(
        options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 3,
            enlargeCenterPage: true,
        ),
        items: value.map.map((item) => Container(
          child: Container(
           padding: EdgeInsets.only(top: 3.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(ZtradeAPI.sliderImageUrl+item["image"], fit: BoxFit.cover, width: 1000.0),
                  ],
                )),
          ),
        ))
    .toList(),
      ),
          );
        }),
      );

      
    
  }
}