

import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/global/widgets/pg_text.dart';

///
class EntryTileBodyTextOnly extends StatelessWidget {

  final Entry entry;
  const EntryTileBodyTextOnly({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return PgText(entry.title, maxLines: 2, style: AppTextStyles.M15,);
  }

}