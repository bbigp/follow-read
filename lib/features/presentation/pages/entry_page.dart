import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/theme.dart';
import '../../domain/models/ui_item.dart';
import '../../domain/models/entry.dart';
import '../providers/entry_loading_proviider.dart';
import '../widgets/dashed_line.dart';
import '../widgets/spacer_divider.dart';

class EntryPage extends ConsumerStatefulWidget {
  final BigInt feedId;

  const EntryPage({
    required this.feedId,
    super.key,
  });

  @override
  ConsumerState<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(entriesLoadingProvider.notifier).fetchEntry();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(entriesLoadingProvider);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          actions: [
            // _buildRefreshButton(ref, feedsState.isSyncing),
            // const SizedBox(width: 12),
          ],
        ),
        body: ListView.builder(
                itemCount: state.uiItems.length,
                itemBuilder: (context, index) {
                  return _buildItem(state.uiItems[index]);
            })

    );
  }

  Widget _buildItem(UiItem uiItem) {
    if (uiItem.type == ViewType.entryItem) {
      return _buildEntryItem(uiItem);
    }
    if (uiItem.type == ViewType.feedHeaderItem) {
      return _buildFeedHeader(uiItem);
    }
    if (uiItem.type == ViewType.noMore) {
      return _buildNoMore();
    }
    if (uiItem.type == ViewType.noContentYetItem) {
      return _noContentYet();
    }
    return Text('dsds');
  }

  Widget _buildFeedHeader(UiItem uiItem){
    final feed = uiItem as FeedHeader;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feed.title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        height: 1.21,
                        color: AppTheme.black95,
                      ),
                    )
                  ],
                ),
                if (feed.subTitle.isNotEmpty)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          '99+ 未读',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            height: 1.18,
                            color: AppTheme.black25,
                          ),
                        ),
                      )
                    ],
                  )
              ],
            ),),
          DashedDivider(
            indent: 0,
            spacing: 16,
            thickness: 1,
            color: AppTheme.black8,
          ),
        ],
      ),
    );
  }

  Widget _buildNoMore() {
    return SizedBox(
      height: 60,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/no_more.svg',
              width: 14,
              height: 14,
              colorFilter: ColorFilter.mode(
                AppTheme.black50, // 设置颜色
                BlendMode.srcIn, // 等效于原 color 属性的效果
              ),
            ),
            //
          ],
        ),
      ),
    );
  }

  Widget _noContentYet() {
    return Center(child: Padding(padding: EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(top: 24, left: 35, right: 35, bottom: 0),
          child: Image.asset(
            'assets/png/no_content_yet.png',
            width: 90,
            height: 46,
          ),),
        Padding(padding: EdgeInsets.only(top: 8),
          child: Text('没有内容了', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.33,
            color: AppTheme.black25,
          ),),)
      ],
    ),
    ),);

  }

  Widget _buildEntryItem(UiItem uiItem) {
    final entry = uiItem as Entry;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 18,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: CachedNetworkImage(
                        imageUrl: entry.feedIcon,
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 18,
                            height: 18,
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 18,
                          height: 18,
                          color: Colors.grey[300], // 错误时的背景颜色
                          child: Icon(Icons.error, color: Colors.red, size: 10,), // 错误图标
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          entry.feedTitle,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.38,
                            color: AppTheme.black95,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                      child: Text(
                        entry.publishedAt,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.38,
                          color: AppTheme.black25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 4,
                            ),
                            child: Text(
                              entry.title,
                              maxLines: entry.tilteLines,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 1.33,
                                color: AppTheme.black95,
                              ),
                            ),
                          ),
                          if (entry.showReadingTime)
                            Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: SizedBox(
                                height: 18,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: AppTheme.black50,
                                      ),
                                    ),
                                    Text(
                                      '${entry.readingTime}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        height: 1.38,
                                        color: AppTheme.black50,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          if (entry.description != "")
                            Text(
                              entry.description,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                height: 1.38,
                                color: AppTheme.black50,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (entry.pic != "")
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: entry.pic,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 24,
                                height: 24,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300], // 错误时的背景颜色
                              child:
                                  Icon(Icons.error, color: Colors.red), // 错误图标
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SpacerDivider(
          indent: 16,
          spacing: 1,
          thickness: 0.5,
        ),
      ],
    );
  }
}
