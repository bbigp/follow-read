import 'dart:async';

import 'package:follow_read/features/domain/models/aist.dart';
import 'package:follow_read/features/domain/models/constants.dart';

import 'base.dart';


class Aistx extends MetaDatax {
  @override
  final int id;
  @override
  final bool search;
  Aistx(this.id, {this.search = false});

  @override
  String get type => Model.aist;

  @override
  Cluster getMeta(){
    return Cluster();
  }

}
