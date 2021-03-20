import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nihongo/components/lesson_line.dart';
import 'package:nihongo/components/level_line.dart';

const List<Widget> tabs = [
  Tab(text: 'Từ vựng', icon: Icon(FontAwesomeIcons.globe)),
  Tab(
    text: 'Ngữ pháp',
    icon: Icon(FontAwesomeIcons.gavel),
  ),
  // Tab(
  //   text: 'Hán Tự',
  //   icon: Icon(FontAwesomeIcons.language),
  // ),
  Tab(
    text: 'Thông tin',
    icon: Icon(FontAwesomeIcons.info),
  )
];

const icon = Icon(
  FontAwesomeIcons.bookOpen,
  size: 40,
  color: Colors.blue,
);

class Init {
  List<LessonLine> createMina() {
    List<LessonLine> _lmina = [];
    for (var i = 1; i < 51; i++) {
      _lmina.add(LessonLine(
        numb: i.toString(),
      ));
    }
    return _lmina;
  }

  List<LevelLine> createLevel() {
    List<LevelLine> _lnum = [];
    for (var i = 1; i < 51; i++) {
      _lnum.add(LevelLine(
        numb: i.toString(),
      ));
    }
    return _lnum;
  }
}
