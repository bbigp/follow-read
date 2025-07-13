


import 'package:follow_read/data/model/entry.dart';

abstract class Meta {
  String get title;
  String get metaId;
}

abstract class MetaRow {

  Future<List<Entry>> entries(Meta meta, {int? page, int? size});

}
