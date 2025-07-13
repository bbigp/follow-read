


import 'package:follow_read/data/model/entry.dart';

abstract class Meta {

}

abstract class MetaRow {

  Future<List<Entry>> entries(Meta meta, {int? page, int? size});

}
