

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/features/domain/models/feed.dart';

import '../../../../config/svgicons.dart';
import '../../../../config/theme.dart';
import '../../pages/cluster_page.dart';
import '../../providers/all_feeds_provider.dart';
import '../done_button.dart';
import '../drag_handle.dart';
import '../feed_icon.dart';
import '../spacer_divider.dart';

class SelectFeed extends ConsumerWidget {

  final void Function(Feed) onSelect;

  const SelectFeed({super.key, required this.onSelect,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      final allFeedsAsync = ref.watch(allFeedsProvider);
      if (allFeedsAsync.isLoading) return SizedBox.shrink();
      List<Feed> feeds = allFeedsAsync.requireValue;
      return Column(children: [
        Bar(title: '选择订阅源', enabled: false,
          color: AppTheme.black4,
        ),
        ListView.separated(shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index){
            final feed = feeds[index];
            return FeedRadio(feed: feed, onSelect: onSelect,);
        }, itemCount: feeds.length,
          separatorBuilder: (_, __) => Padding(
            padding: EdgeInsets.only(left: 28 + 12 + 24 + 12,),
            child: SpacerDivider(indent: 0, spacing: 1, thickness: 0.5,),
          )
        ),
      ],);
  }

}

class FeedRadio extends StatelessWidget {

  final Feed feed;
  final bool isSelected;
  final void Function(Feed) onSelect;

  const FeedRadio({super.key, required this.feed, this.isSelected = false,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
      onSelect(feed);
    }, child: Row(children: [
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