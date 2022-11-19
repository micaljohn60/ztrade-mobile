import 'package:flutter/material.dart';
import 'package:omni_mobile_app/screens/product_detail/components/product_text.dart';

class ProductDescription extends StatelessWidget {
  
  ProductDescription({ Key key,text }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       ProductText(prefix: "Brand", data: "Apple",),
       ProductText(prefix: "Color", data: "Purple, Red, Silver",),
       ProductText(prefix: "Storage Capacity", data: "128GB",),
      ],
    );
  }
}