import 'package:flutter/material.dart';
import 'package:follow_read/features/data/datasources/api.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/logger.dart';
import '../../data/models/entry.dart';
import '../../data/models/feed.dart';
import '../widgets/entry_item_view.dart';

class EntryListPage extends StatefulWidget {
  final Feed feed;

  const EntryListPage({super.key, required this.feed});

  @override
  State<EntryListPage> createState() => _EntryListPageState();
}

class EntryListViewModel extends ChangeNotifier {
  List<Entry> items = [];
  final size = 20;
  int currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool pullRefresh = false;

  Future<void> loadNetworkData(int feedId, {bool reset = false}) async {
    if (_isLoadingMore) return;
    if (reset) {
      currentPage = 1;
      items.clear();
      pullRefresh = true;
      notifyListeners();
    } else {
      pullRefresh = false;
      _isLoadingMore = true;
      notifyListeners();
    }

    await Api.getEntries(
        feedId: feedId,
        page: currentPage,
        limit: size,
        onSuccess: (entries) => {
          items.addAll(entries),
          _hasMore = entries.length >= size ? true : false,
          logger.i("hasMore $_hasMore"),
          currentPage++,
          _isLoadingMore = false,
          pullRefresh = false,
          notifyListeners()
        },
        onError: (error) => {
          logger.e(error),
          _isLoadingMore = false,
          pullRefresh = false,
          notifyListeners()
        });
  }
}

class _EntryListPageState extends State<EntryListPage> {
  final _viewModel = EntryListViewModel();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // _refreshIndicatorKey.currentState?.show(); // 手动显示刷新指示器
      _viewModel.loadNetworkData(widget.feed.id, reset: true);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100 &&
          !_viewModel._isLoadingMore && _viewModel._hasMore) {
        _viewModel.loadNetworkData(widget.feed.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Text(
            widget.feed.title,
            style: TextStyle(fontSize: 16),
          ),
          leadingWidth: 48,
          leading: GestureDetector(
            child: const Icon(Icons.rss_feed),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: [],
        ),
        body: Consumer<EntryListViewModel>(
          builder: (context, viewModel, child) {
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () => viewModel.loadNetworkData(widget.feed.id, reset: true),
              child: ListView.builder(
                  physics: viewModel.pullRefresh ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
                  controller: _scrollController,
                  itemCount: viewModel.pullRefresh ? 20 : viewModel.items.length + 1,
                  itemBuilder: (context, index) {
                    if (viewModel.pullRefresh) {
                        return _buildRefreshItem();
                    }
                    if (index == viewModel.items.length) {
                      return _buildLoadMoreIndicator();
                    }
                    final item = viewModel.items[index];
                    return EntryItemView(item: item,);
                  }),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRefreshItem(){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 16, right: 16),
            child: Row(
              children: [
                Container(width: 18, height: 18, color: Colors.white),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Container(height: 12, width: 72, color: Colors.white),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4, left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 4), child: Container(height: 14, width: 154, color: Colors.white,),),
                      Padding(padding: EdgeInsets.only(top: 8), child: Container(height: 12, width: 244, color: Colors.white,),),
                      Padding(padding: EdgeInsets.only(top: 8), child: Container(height: 12, width: 134, color: Colors.white,),),
                      SizedBox(height: 18,),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8,),
                  child: Container(height: 80, width: 80, color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(height: 16,),
          Container(height: 1, color: Colors.black12,)
        ],
      ),
    );
  }


  Widget _buildLoadMoreIndicator() {
    if (_viewModel._isLoadingMore) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (!_viewModel._hasMore) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: Text("/")),
      );
    }
    return SizedBox.shrink();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
