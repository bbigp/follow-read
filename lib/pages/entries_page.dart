import 'package:flutter/material.dart';
import 'package:follow_read/models/entry.dart';
import 'package:follow_read/services/api.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/feed.dart';
import '../utils/logger.dart';

class EntryListPage extends StatefulWidget {
  final Feed feed;

  const EntryListPage({super.key, required this.feed});

  @override
  State<EntryListPage> createState() => _EntryListPageState();
}

class EntryListViewModel extends ChangeNotifier {
  List<Entry> items = [];

  Future<void> loadNetworkData(int feedId) async {
    await Api.getEntries(
        feedId: feedId,
        limit: 20,
        onSuccess: (entries) => {items = entries, notifyListeners()},
        onError: (error) => {logger.e(error), notifyListeners()});
  }
}

class _EntryListPageState extends State<EntryListPage> {
  final _viewModel = EntryListViewModel();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _refreshIndicatorKey.currentState?.show(); // 手动显示刷新指示器
      _viewModel.loadNetworkData(widget.feed.id);
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
              onRefresh: () => viewModel.loadNetworkData(widget.feed.id),
              child: ListView.builder(
                  itemCount: viewModel.items.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.items[index];
                    logger.i(item.mainPic);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    maxLines: item.summary == "" ? 2 : 1,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  item.summary == "" ? Container() :
                                  Text(
                                    item.summary,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: item.summary == "" ? 0 : 8,
                                  ),
                                  Text(
                                    'ss',
                                    // item.publishedAt as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(width: item.mainPic != null ? 16 : 0), // 左右间距
                          item.mainPic != null ?
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0), // 圆角缩略图
                            child: CachedNetworkImage(
                              imageUrl: item.mainPic!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[200], // 占位颜色
                                child: Center(child: CircularProgressIndicator()), // 占位动画
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[300], // 错误时的背景颜色
                                child: Icon(Icons.error, color: Colors.red), // 错误图标
                              ),
                            ),
                          ) : Container(),
                        ],
                      ),
                    );
                  }),
            );
          },
        ),

        // return ListView.builder(
        //     itemCount: viewModel.items.length,
        //     itemBuilder: (context, index) {
        //       final item = viewModel.items[index];

        //         ),
        //       );
        //     });
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
