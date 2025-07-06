

import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/features/domain/models/entry.dart';

import 'entry_author.dart';

class EntryTitle extends StatelessWidget {

  final Entry entry;
  const EntryTitle({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 8,),
      Text(entry.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.text22500,),
      const SizedBox(height: 8,),
      EntryAuthor(entry: entry),
      const SizedBox(height: 8,),
      Text(entry.publishedAt.toShowTime(), maxLines: 1,
        overflow: TextOverflow.ellipsis, style: AppTextStyles.caption11500,
      ),
      const SizedBox(height: 8,),
    ],);
  }

}