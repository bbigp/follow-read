import 'package:flutter/material.dart';
import 'package:follow_read/models/feed.dart';
import 'package:follow_read/widgets/feed_list_view.dart';
import 'package:follow_read/widgets/smart_view.dart';

import '../services/api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Feed> items = [];

  Map<String, int> smartViewCounts = {
    'star': 0,
    'recent': 0,
    'unread': 0,
    'today': 0
  };

  bool isLoadingRss = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    _refreshSmartViewData();
    _refreshRssData();
  }

  Future<void> _refreshData() async {
    _refreshSmartViewData();
    await Future.wait([
      _refreshRssData(),
    ]);
  }

  Future<void> _refreshSmartViewData() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // 模拟网络请求

      setState(() {
        smartViewCounts = {
          'star': 10 + (DateTime.now().second % 5),
          'recent': 8 + (DateTime.now().second % 3),
          'unread': 15 + (DateTime.now().second % 4),
          'today': 5 + (DateTime.now().second % 2),
        };
      });
    } finally{

    }
  }

  Future<void> _refreshRssData() async {
    if (isLoadingRss) return;
    setState(() {
      isLoadingRss = true;
    });
    Api.getFeeds(
      onSuccess: (feeds) => setState(() => items = feeds),
      onError: (error) => {
      },
      onComplete: () => setState(() => isLoadingRss = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.person, color: Colors.black), // 添加"我的"图标
        // title: const Text('RSS阅读器', style: TextStyle(color: Colors.black)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search, color: Colors.black), // 添加加号图标
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.refresh, color: Colors.black), // 添加加号图标
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.add, color: Colors.black), // 添加加号图标
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(children: [
          SmartViewSection(counts: smartViewCounts, isLoading: true),
          RssListSection(items: items, isLoading: isLoadingRss),
        ]),
      ),
    );
  }
}
