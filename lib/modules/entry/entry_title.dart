

import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/global/widgets/pg_text.dart';

import 'entry_author.dart';

///
class EntryTitle extends StatelessWidget {

  final Entry entry;
  const EntryTitle({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 8,),
      PgText(entry.title, maxLines: 10, style: AppTextStyles.M22,),
      const SizedBox(height: 8,),
      EntryAuthor(entry: entry),
      const SizedBox(height: 8,),
      PgText(entry.publishedAt.toString(), maxLines: 1, style: AppTextStyles.M11B50),
      const SizedBox(height: 8,),
    ],);
  }

}