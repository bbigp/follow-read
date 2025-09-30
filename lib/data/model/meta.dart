


import 'package:follow_read/data/model/entry.dart';

abstract class Meta {
  String get title;
  String get metaId;
  String get order;
  bool get onlyShowUnread;
  bool get hideGlobally;
  String get siteUrl;
  String get url;
}

// abstract class MetaRow {
//
//   Future<List<Entry>> entries(Meta meta, {int? page, int? size});
//
// }
