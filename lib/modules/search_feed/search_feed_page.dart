


import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/global/widgets/cupx_app_bar.dart';
import 'package:follow_read/global/widgets/cupx_sheet_title.dart';
import 'package:follow_read/global/widgets/empty_state_view.dart';
import 'package:follow_read/global/widgets/loading_more.dart';
import 'package:follow_read/global/widgets/no_more.dart';
import 'package:follow_read/global/widgets/padded_svg_icon.dart';
import 'package:follow_read/global/widgets/text_fieldx.dart';
import 'package:follow_read/modules/feed_line.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

import 'search_feed_controller.dart';

class SearchFeedPage extends StatefulWidget {

  const SearchFeedPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchFeedPageState();
}

class _SearchFeedPageState extends State<SearchFeedPage> {

  final searchFeed = Get.find<SearchFeedController>();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CenteredSheetTitleBar(
        title: "RSS/Atom",
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 12, left: 16, right: 16),
          child: SearchTextField(
            focusNode: _searchFocusNode,
            onSubmitted: (v) async {
              await searchFeed.search(v.trim());
            },
            onChanged: (v) async {
              if (v == "") {
                searchFeed.clear();
                _searchFocusNode.requestFocus();
              }
            },
          ),
        ),
        Expanded(child: Obx((){
          if (searchFeed.state.word.isEmpty) {
            return const SizedBox.shrink();
          }
          if (searchFeed.state.isSearching) {
            return Center(child: LoadingMore(),);
          }
          if (searchFeed.state.feeds.isEmpty) {
            return EmptyStateView(value: "No results found",);
          }
          return ListView.builder(
              itemBuilder: (context, index){
                if (index == searchFeed.state.feeds.length) {
                  return NoMore();
                }
                final feed = searchFeed.state.feeds[index];
                return FeedLine(
                  feed: feed,
                  onTap: () => Get.toNamed(RouteConfig.addFeed, arguments: feed),
                );
              },
              itemCount: searchFeed.state.feeds.length + 1,
          );
        }))
      ],),
    );
  }
}