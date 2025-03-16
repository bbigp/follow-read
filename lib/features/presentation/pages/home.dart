// import 'package:flutter/material.dart';
// import 'package:follow_read/features/presentation/widgets/smart_view.dart';
// import 'package:provider/provider.dart';
//
// import '../../data/datasources/api.dart';
// import '../../data/datasources/database.dart';
// import '../../../core/utils/logger.dart';
// import '../../data/models/feed.dart';
// import '../widgets/feed_list_view.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class FeedViewModel extends ChangeNotifier {
//   List<Feed> items = [];
//   Map<String, int> smartViewCounts = {
//     'star': 0,
//     'recent': 0,
//     'unread': 0,
//     'today': 0
//   };
//
//   final AppDatabase _database = AppDatabase();
//
//   bool isLoadingRss = false;
//   bool isRefresh = false;
//
//   Future<void> loadInitialData() async {
//     logger.i("fetch feeds from sqlite");
//     isLoadingRss = true;
//     notifyListeners();
//     // await Future.delayed(const Duration(seconds: 3));
//     final cachedFeeds = await _database.getAllFeeds();
//     if (cachedFeeds.isEmpty) {
//       items = [];
//       isLoadingRss = false;
//       isRefresh = false;
//       notifyListeners();
//       return;
//     }
//     items = cachedFeeds;
//     isLoadingRss = false;
//     isRefresh = false;
//     notifyListeners();
//   }
//
//   Future<void> fetchFeeds() async {
//     isRefresh = true;
//     logger.i("refesh feeds");
//     notifyListeners();
//     Api.getFeedsAndCounters(onSuccess: (feeds) async => {
//       await _database.deleteAllFeeds(),
//       await _database.insertFeeds(feeds),
//       await loadInitialData(),
//     }, onError: (error) => {
//       isRefresh = false, notifyListeners()
//     });
//     // Api.getFeeds(
//     //     onSuccess: (feeds) async => {
//     //           await _database.deleteAllFeeds(),
//     //           await _database.insertFeeds(feeds),
//     //           await loadInitialData(),
//     //         },
//     //     onError: (error) => {isRefresh = false, notifyListeners()}
//     // );
//     // Api.getFeedsCounters(onSuccess: (counter) => {
//     //
//     // }, onError: (error) => {});
//   }
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();
//   final _viewModel = FeedViewModel();
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       _refreshIndicatorKey.currentState?.show(); // 手动显示刷新指示器
//       _viewModel.loadInitialData();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: _viewModel,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           leading: GestureDetector(
//               onTap: (){
//                 // AppRoutes.navigateTo(context, AppRoutes.me);
//               },
//               child: Icon(Icons.person, color: Colors.black)), // 添加"我的"图标
//           // title: const Text('RSS阅读器', style: TextStyle(color: Colors.black)),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: Consumer<FeedViewModel>(
//                 builder: (context, viewModel, child) {
//                   return SizedBox(
//                     width: 24,
//                     height: 24,
//                     child: viewModel.isRefresh
//                         ? const Center(
//                             // 居中放置 CircularProgressIndicator
//                             child: SizedBox(
//                               width: 15,
//                               height: 15,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor:
//                                     AlwaysStoppedAnimation<Color>(Colors.black),
//                               ),
//                             ),
//                           )
//                         : IconButton(
//                             padding: EdgeInsets.zero,
//                             icon:
//                                 const Icon(Icons.refresh, color: Colors.black),
//                             onPressed: () async {
//                               await _viewModel.fetchFeeds();
//                             },
//                             iconSize: 24,
//                           ),
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 16.0),
//               child: Icon(Icons.add, color: Colors.black), // 添加加号图标
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 16.0),
//               child: Icon(Icons.search, color: Colors.black), // 添加加号图标
//             ),
//           ],
//         ),
//         body: Consumer<FeedViewModel>(
//           builder: (context, viewModel, child) {
//             return RefreshIndicator(
//               key: _refreshIndicatorKey,
//               onRefresh: viewModel.loadInitialData,
//               child: ListView(children: [
//                 SmartViewSection(
//                     counts: viewModel.smartViewCounts, isLoading: true),
//                 RssListSection(
//                     items: viewModel.items, isLoading: viewModel.isLoadingRss),
//               ]),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _viewModel.dispose();
//   }
// }
