

import 'package:flutter/material.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/theme/text_styles.dart';

///
class EntryTileBodyTextOnly extends StatelessWidget {

  final Entry entry;
  const EntryTileBodyTextOnly({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Text(entry.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.text500,);
  }

}