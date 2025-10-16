

import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/empty_state_view.dart';
import 'package:follow_read/global/widgets/loading_more.dart';
import 'package:follow_read/global/widgets/no_more.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/modules/entry_tile/entry_tile.dart';
import 'package:follow_read/modules/search/search_controller.dart';
import 'package:get/get.dart';



class SearchEntries extends StatefulWidget {

  const SearchEntries({super.key,});

  @override
  State<SearchEntries> createState() => _SearchEntriesState();
}

class _SearchEntriesState extends State<SearchEntries> {

  final ScrollController _scrollController = ScrollController();
  final searchPage = Get.find<SearchHistoryController>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (searchPage.state.isLoading) return;
    if (searchPage.state.isLoadingMore) return;
    if (!searchPage.state.hasMore) return;
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      searchPage.nextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildResult() {
    final entries = searchPage.state.items;
    return entries.isEmpty
        ? EmptyStateView(value: "No result found")
        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 4),
        child: PgText('Results', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.R13B50,),
      ),
      Expanded(child: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(delegate: SliverChildBuilderDelegate(
                childCount: entries.length,
                (context, index) {
                  return EntryTile(entryObs: entries[index]);
                }
            )),
            SliverToBoxAdapter(child: searchPage.state.hasMore
                ? const LoadingMore()
                : const NoMore()
            ),
          ],
        ),
      )),
    ],);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return searchPage.state.isLoading
          ? const SizedBox.shrink()
          : _buildResult();
    });
  }

  Future<void> _refreshData() async {
    await searchPage.loadEntries(searchPage.state.word);
  }
}