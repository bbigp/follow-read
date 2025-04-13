

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/widgets/input_field.dart';
import 'package:follow_read/features/presentation/widgets/no_more_loading.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../../../core/utils/page_utils.dart';
import '../providers/search_provier.dart';
import '../widgets/entry_item.dart';
import '../widgets/loading_more.dart';
import '../widgets/spacer_divider.dart';

class SearchPage extends ConsumerStatefulWidget {

  final int id;
  final TileType type;
  const SearchPage({super.key, required this.id,
    required this.type,});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();

}

class _SearchPageState extends ConsumerState<SearchPage> {

  String get pid => PageUtils.pid(widget.type, widget.id);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }


  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    final searchAsync = ref.watch(searchProvier(pid));
    if (!searchAsync.isLoading
        && searchAsync.requireValue.word.isNotEmpty
        && !searchAsync.requireValue.isLoadingMore
        && searchAsync.requireValue.hasMore
        && _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(searchProvier(pid).notifier).loadMore();
    }
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchAsync = ref.watch(searchProvier(pid));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: InputField(
                    data: searchAsync.isLoading ? "" : searchAsync.requireValue.word,
                    onChanged: (v){
                      if (v == "") {
                        ref.read(searchProvier(pid).notifier).clearSearchResult();
                      }
                    },
                    onSubmitted: (v) {
                      ref.read(searchProvier(pid).notifier).search(v);
                    },
                    suffixIconPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    suffixSize: 24,
                    suffixIconSize: 20,
                    hintText: '搜索',
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    height: 36,
                    prefixPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    prefixIcon: Svgicons.searchInput,
                    prefixSize: 20,
                    prefixIconSize: 20,
                  )),
                SizedBox(width: 16,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Text('取消', style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppTheme.black95,
                  ),),
                )
              ],
            ),
          ),
        ),
      ),
      body: searchAsync.isLoading
          ? _buildNoHistory('搜索')
          : _buildView(searchAsync.requireValue)
    );
  }

  Widget _buildSearchResults(SearchState state){
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Results', style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppTheme.black50,
            ),),),
          ),
          SliverList(delegate: SliverChildBuilderDelegate(
              childCount: state.entries.length + 1,
                  (context, index) {
                if (index >= state.entries.length) {
                  return state.hasMore ? LoadingMore() : NoMoreLoading();
                }
                final entry = state.entries[index];
                final tile = state.tile;
                return entry.isUnread
                    ? EntryItem(entry: entry, tile: tile)
                    : Opacity(opacity: 0.5,
                  child: EntryItem(entry: entry, tile: tile),
                );
              }),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshData() async {}

  Widget _buildView(SearchState state){
    if (state.word.isEmpty) return _buildHistory(state.histories);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus(); // 收起键盘
    });
    if (state.isInitializing) return _buildHistory(state.histories);//正在搜索 加载进度条
    if (state.entries.isEmpty) return _buildNoHistory('没有匹配的结果'); //没搜到内容
    return _buildSearchResults(state);
  }

  Widget _buildHistory(List<String> histories){
    if (histories.isEmpty) return _buildNoHistory('搜索');
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => SpacerDivider(
        thickness: 0.5,
        spacing: 1,
        indent: 0,
        color: AppTheme.black8,
      ),
      itemCount: histories.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Row(children: [
            Expanded(child: Text('最近搜索', style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppTheme.black50,
            ),)),
            SizedBox(width: 10, height: 36,),
            GestureDetector(
              onTap: (){
                ref.read(searchProvier(pid).notifier).clearSearchHitory();
              },
              child: Svgicon(Svgicons.trash, size: 24, iconSize: 20,),
            ),
          ],);
        }
        if (index == histories.length + 1) {
          return NoMoreLoading();
        }
        final item = histories[index - 1];
        return GestureDetector(
          onTap: (){
            ref.read(searchProvier(pid).notifier).search(item);
          },
          child: Row(
            children: [
              Expanded(child: Text(item, style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
              ),)),
              SizedBox(width: 10, height: 48,),
              Svgicon(Svgicons.chevronRight, size: 24, iconSize: 20,),
            ],
          ),
        );
      },
    );
  }


  Widget _buildNoHistory(String text){
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(Svgicons.searchInput, width: 56, height: 56,),
            SizedBox(height: 16),
            Text(text,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppTheme.black25),
            ),
          ],
        ),
      ),
    );
  }

}