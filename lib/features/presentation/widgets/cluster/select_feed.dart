

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/presentation/widgets/components/buttonx.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_sheet_title.dart';

import '../../../../config/svgicons.dart';
import '../../../../config/theme.dart';
import '../../pages/cluster_page.dart';
import '../../providers/all_feeds_provider.dart';
import '../feed_icon.dart';
import '../components/spacer_divider.dart';

class SelectFeed extends ConsumerStatefulWidget {

  const SelectFeed({super.key,});


  @override
  ConsumerState<SelectFeed> createState() => _SelectFeedState();
}

class _SelectFeedState extends ConsumerState<SelectFeed> {

  List<int> _feedIds = [];

  @override
  void initState() {
    super.initState();
    final cluster = ref.read(clusterProvider);
    _feedIds = List<int>.from(cluster.feedIds);
  }

  @override
  Widget build(BuildContext context) {
      final allFeedsAsync = ref.watch(allFeedsProvider);
      if (allFeedsAsync.isLoading) return SizedBox.shrink();
      List<Feed> feeds = allFeedsAsync.requireValue;
      return Column(children: [
        CenteredSheetTitle(
          // context,
          // color: AppTheme.black4, height: 48,
          title: '选择订阅源',
          // leading: CupxSheetTitleCloseButton(),
          // button: TextButtonx(child: 'Done',
          //   size: Sizex.smallCompact, type: ButtonxType.primary,
          //   enabled: _feedIds.isNotEmpty,
          //   onPressed: () async {
          //     ref.read(clusterProvider.notifier).update(feedIds: _feedIds);
          //     Navigator.pop(context);
          //   },
          // ),
        ),
        ListView.separated(shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index){
            final feed = feeds[index];
            return FeedRadio(feed: feed, isSelected: _feedIds.contains(feed.id),
              onSelect: (feed) {
                setState(() {
                  if (_feedIds.contains(feed.id)) {
                    _feedIds.remove(feed.id);
                  } else {
                    _feedIds.add(feed.id);
                  }
                });
              },
            );
        }, itemCount: feeds.length,
          separatorBuilder: (_, __) => Padding(
            padding: EdgeInsets.only(left: 28 + 12 + 24 + 12,),
            child: SpacerDivider(indent: 0, spacing: 1, thickness: 0.5,),
          )
        ),
      ],);
  }

}

class FeedRadio extends ConsumerWidget {

  final Feed feed;
  final bool isSelected;
  final void Function(Feed) onSelect;

  const FeedRadio({super.key, required this.feed, this.isSelected = false,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(onTap: () => onSelect(feed), child: Row(children: [
      SvgPicture.asset(
        isSelected ? Svgicons.selection : Svgicons.circular,
        height: 28,
        width: 28,
      ),
      SizedBox(width: 12, height: 52,),
      FeedIcon(title: feed.title, iconUrl: feed.iconUrl, size: 24,),
      SizedBox(width: 12,),
      Expanded(child: Text(feed.title, style: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
      ),))
    ],),);
  }

}