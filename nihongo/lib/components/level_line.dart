import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nihongo/const.dart';
import 'package:nihongo/screens/show_bunpou.dart';

class LevelLine extends StatelessWidget {
  final String? numb;

  const LevelLine({Key? key, this.numb}) : super(key: key);
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BunpouScreen(
                        id: numb,
                        title: Text('Ngữ pháp - Mina bài $numb'),
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
