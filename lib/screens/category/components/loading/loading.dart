import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  double height;
  Loading({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<String> widgetList = [
      'A',
      'B',
      'C',
    ];
    return Container(
      height: 220,
      child: Column(

        children: [
          Row(
            children: [
              Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400].withOpacity(0.4),
                      highlightColor: Colors.grey[300].withOpacity(0.4),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10.0)),
                        height: 30.0,
                        width: 150,
                      ),
                    ),
                  ),
            ],
          ),
          GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: size.width > 600 ? 4 : 3,
              childAspectRatio: size.width > 600 ? 1 : 0.7,
              shrinkWrap: true,
              children: widgetList.map((e) => listItem(size)).toList())
        ],
      ),
    );
  }

  Widget listItem(Size size) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300].withOpacity(0.4),
              borderRadius: BorderRadius.circular(5.0)),
          height: height,
          width: 100,
          child: Column(
            children: [
              Padding(
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
              Shimmer.fromColors(
                baseColor: Colors.grey[400].withOpacity(0.4),
                highlightColor: Colors.grey[300].withOpacity(0.4),
                child: Container(
                  margin: EdgeInsets.only(left: 8.0, right: 8.0),
                  width: size.width,
                  height: 20.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              )
            ],
          ),
        ),
      );
}
