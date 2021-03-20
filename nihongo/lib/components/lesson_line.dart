import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nihongo/const.dart';
import 'package:nihongo/screens/show_kotoba.dart';

class LessonLine extends StatelessWidget {
  final String? numb;
  LessonLine({Key? key, this.numb}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => KotobaScreen(
                        id: numb,
                        title: Text('Từ vựng- Mina bài $numb'),
                      )));
        },
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [icon, Text('    Mina bài $numb')],
          ),
        ),
      ),
    );
  }
}
