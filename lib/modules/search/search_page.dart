

import 'package:flutter/material.dart';
import 'package:follow_read/global/widgets/search_barx.dart';
import 'package:follow_read/modules/search/search_entries.dart';
import 'package:follow_read/modules/search/search_history_view.dart';
import 'package:get/get.dart';

import 'search_controller.dart';


class SearchPage extends StatefulWidget {

  const SearchPage({super.key,});

  @override
  State<StatefulWidget> createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage> {

  final FocusNode _searchFocusNode = FocusNode();
  final search = Get.find<SearchHistoryController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchBarx(
        focusNode: _searchFocusNode,
        valueGetter: () => search.state.word,
        onSubmitted: (value) async {
          FocusScope.of(context).unfocus(); // 收起键盘
          await search.loadEntries(value);
        },
        onChanged: (value) async {
          if (value == "") {
            await search.clearEntries();
            _searchFocusNode.requestFocus();
          }
        },
      ),
      body: Obx((){
        return search.state.page == 0
            ? SearchHistoryView()
            : SearchEntries();
      })
    );
  }

}