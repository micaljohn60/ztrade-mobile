import 'package:flutter/material.dart';

class NoItem extends StatelessWidget {
  String errorText;
  NoItem({Key key, this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/search_error.png',
                height: 80,
                width: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(errorText),
              )
            ],
          ),
        ],
      ),
    );
  }
}
