

import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/features/domain/models/entry.dart';

class EntryAuthor extends StatelessWidget {

  final Entry entry;
  const EntryAuthor({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      if (entry.author.isNotEmpty) ...[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 122,
          ),
          child: Text(entry.author, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption11500,
          ),
        ),
        const SizedBox(width: 8,),
        Container(width: 1, height: 6, color: AppColors.black08,),
        const SizedBox(width: 8,),
      ],
      Expanded(child: Text(entry.feed.title, maxLines: 1,
        overflow: TextOverflow.ellipsis, style: AppTextStyles.caption11500,
      )),
    ],);

  }

}