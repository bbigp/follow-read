

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/cases/base.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/presentation/widgets/components/loading_more.dart';
import 'package:follow_read/features/presentation/widgets/components/no_more.dart';
import 'package:follow_read/features/presentation/widgets/entry/entry_tile.dart';
import 'package:follow_read/features/presentation/widgets/search/no_search_history.dart';
import 'package:follow_read/theme/text_styles.dart';

class SearchEntry extends ConsumerStatefulWidget {
  final MetaDatax metaDatax;
  const SearchEntry({super.key, required this.metaDatax});

  @override
  ConsumerState<SearchEntry> createState() => _SearchEntryState();
}

class _SearchEntryState extends ConsumerState<SearchEntry> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final entriesAsync = widget.metaDatax.page(ref);
    if (entriesAsync.isLoading) return;
    if (entriesAsync.requireValue.isLoadingMore) return;
    if (!entriesAsync.requireValue.hasMore) return;
    if (entriesAsync.requireValue.builder!.word.isEmpty) return;
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      widget.metaDatax.loadMore(ref);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final entriesAsync = widget.metaDatax.page(ref);
    if (entriesAsync.isLoading) {
      return const SizedBox.shrink();
    }
    PageInfo<Entry> pageInfo = entriesAsync.requireValue;
    if (pageInfo.list.isEmpty) {
      return NoSearchHistory(value: "没有匹配的结果");
    }
    final List<Entry> entries = pageInfo.list;
    // int total = 0;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: EdgeInsets.only(left: 18, right: 16, top: 8, bottom: 4),
        child: Text('Results', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.caption13,),
      ),
      Expanded(child: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(delegate: SliverChildBuilderDelegate(
                childCount: entries.length,
                    (context, index) {
                  return EntryTile(entry: entries[index]);
                }
            )),
            SliverToBoxAdapter(child: pageInfo.hasMore ? LoadingMore() : NoMore(),)
          ],
        ),
      ))
    ],);
  }

  Future<void> _refreshData() async {}
}