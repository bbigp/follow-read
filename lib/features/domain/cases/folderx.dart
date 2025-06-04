
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';
import 'package:follow_read/features/presentation/providers/folderhub/folderhub_controller.dart';
import 'package:follow_read/features/presentation/providers/folders_provider.dart';
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
    return Get.find<FolderhubController>().getById(id);
  }

}