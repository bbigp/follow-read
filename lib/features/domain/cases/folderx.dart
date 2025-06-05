
import 'dart:async';

import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:get/get.dart';


import 'base.dart';

class Folderx extends MetaDatax {

  @override
  final int id;
  @override
  final bool search;
  Folderx(this.id, {this.search = false});

  @override
  String get type => Model.folder;

  @override
  Category getMeta(){
    return Category.empty;
  }

}