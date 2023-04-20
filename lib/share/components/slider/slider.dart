import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:omni_mobile_app/services/slider/carousel_slider_service.dart';
import 'package:omni_mobile_app/share/components/slider/components/slider_loading.dart';
import 'package:provider/provider.dart';

import '../../../static/ztradeAPI.dart';

class ImageSlider extends StatelessWidget {
  List<dynamic> images;
  ImageSlider({Key key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CarouselSliderService>().fetchData;

    return Consumer<CarouselSliderService>(
      builder: ((context, value, child) {
        return value.map.length == 0 && !value.error && !value.empty
            ? SliderLoading()
            : value.error
                ? Center(
                    child: Text(value.errorMessage),
                  )
                : value.empty
                    ? Center(
                        child: Text(""),
                      )
                    : Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            viewportFraction: 1,
                            aspectRatio: 2.5,
                            enlargeCenterPage: true,
                          ),
                          items: images
                              .map((item) => Container(
                                    child: Container(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          child: Stack(
                                            children: <Widget>[
                                              Image.network(
                                                  ZtradeAPI.sliderImageUrl +
                                                      item["image"],
                                                  fit: BoxFit.contain,
                                                  width: 1000.0),
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
