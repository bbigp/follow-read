

import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/features/domain/models/entry.dart';

///
class EntryTileBodyTextOnly extends StatelessWidget {

  final Entry entry;
  const EntryTileBodyTextOnly({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Text(entry.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.M15,);
  }

}