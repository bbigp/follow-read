import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/aist.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';
import 'package:follow_read/features/presentation/providers/aisthub/aisthub_controller.dart';
import 'package:follow_read/features/presentation/providers/aists_provider.dart';
import 'package:get/get.dart';

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
    return Get.find<AisthubController>().getById(id);
  }

}
