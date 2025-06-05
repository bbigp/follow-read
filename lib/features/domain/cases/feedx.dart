


import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:get/get.dart';

import 'base.dart';

class Feedx extends MetaDatax {
  
  @override
  final int id;
  @override
  final bool search;
  Feedx(this.id, {this.search = false});

  @override
  String get type => Model.feed;

  @override
  Feed getMeta(){
    return Feed.empty;
  }

}



