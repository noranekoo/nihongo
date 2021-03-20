class Kotoba {
  // ignore: non_constant_identifier_names
  String cn_mean;
  String favorite;
  String hiragana;
  String id;
  String kanji;
  // ignore: non_constant_identifier_names
  String kanji_id;
  // ignore: non_constant_identifier_names
  String lesson_id;
  String mean;
  // ignore: non_constant_identifier_names
  String mean_unsigned;
  String roumaji;
  String tag;

  Kotoba(
      this.cn_mean,
      this.favorite,
      this.hiragana,
      this.id,
      this.kanji,
      this.kanji_id,
      this.lesson_id,
      this.mean,
      this.mean_unsigned,
      this.roumaji,
      this.tag);
}

class Bunpou {
  String id;
  String name;
  String content;
  // ignore: non_constant_identifier_names
  String lesson_id;
  String favorite;

  Bunpou(this.id, this.name, this.content, this.lesson_id, this.favorite);
}
