

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/presentation/widgets/components/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/home/main_tile.dart';
import 'package:follow_read/features/presentation/widgets/home/provider/feed_provider.dart';
import 'package:follow_read/features/presentation/widgets/home/provider/folder_provider.dart';

///
class FolderTile extends ConsumerWidget {

  final Category folder;
  const FolderTile({super.key, required this.folder,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      MainTile(provider: FolderProvider(folder, ref: ref)),
      Padding(
        padding: EdgeInsets.only(left: 12 + 24 + 4, right: 16),
        child: SpacerDivider(thickness: 0.5, spacing: 0.5, indent: 0,),
      ),
      if (folder.expanded)
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final feed = folder.feeds[index];
              return Column(children: [
                MainTile(provider: FeedProvider(feed, context: context, ref: ref, hasLeadingIndicator: false)),
                Padding(
                  padding: EdgeInsets.only(left: 12 + 24 + 4, right: 16),
                  child: SpacerDivider(thickness: 0.5, spacing: 0.5, indent: 0,),
                ),
              ],);
            },
            itemCount: folder.feeds.length
        ),
    ],);
  }
}