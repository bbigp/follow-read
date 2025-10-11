

import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/global/widgets/pg_text.dart';

///
class EntryAuthor extends StatelessWidget {

  final Entry entry;
  const EntryAuthor({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      if (entry.author.isNotEmpty) ...[
        Expanded(child: PgText(entry.author, maxLines: 2, style: AppTextStyles.M11B50)),
        const SizedBox(width: 8,),
        Container(width: 1, height: 6, color: AppColors.black08,),
        const SizedBox(width: 8,),
      ],
      Expanded(child: PgText(entry.feed.title, maxLines: 2, style: AppTextStyles.M11B50,)),
    ],);

  }

}