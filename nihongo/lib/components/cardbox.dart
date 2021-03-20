import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardBox extends StatelessWidget {
  final String? hira;
  final String? kanji;
  final String? mean;
  final double? width;
  final double? height;

  const CardBox(
      {Key? key, this.hira, this.kanji, this.mean, this.width, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: Container(
          child: Column(
            children: [
              Text('$hira'),
              Text('$kanji'),
              Text('$mean'),
            ],
          ),
        ));
  }
}
