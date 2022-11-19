import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SliderLoading extends StatelessWidget {
  const SliderLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
     decoration: BoxDecoration(
             color: Colors.grey[300].withOpacity(0.4),
             borderRadius: BorderRadius.circular(5.0)
          ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[400].withOpacity(0.4),
          highlightColor: Colors.grey[300].withOpacity(0.4),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5.0)),
            height: 110.0,
            width: 100,
          ),
        ),
      ),
    );
  }
}
