

import 'package:flutter/material.dart';
import 'package:follow_read/global/widgets/search_barx.dart';
import 'package:follow_read/modules/search/search_history_view.dart';
import 'package:get/get.dart';

import 'no_search_history.dart';
import 'search_controller.dart';


class SearchPage extends StatelessWidget {

  SearchPage({super.key,});

  final search = Get.find<SearchHistoryController>();

  @override
  Widget build(BuildContext context) {
    // final entriesAsync = metaDatax.page(ref);
    // String word = entriesAsync.isLoading ? "" : entriesAsync.requireValue.builder!.word;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchBarx(
        value: "",
        onSubmitted: (value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            FocusScope.of(context).unfocus(); // 收起键盘
          });
          // metaDatax.loadMore(ref, word: value);
        },
        onChanged: (value) {
          if (value == "") {
            // metaDatax.init(ref);
          }
        },
      ),
      body: SearchHistoryView()

      // Obx((){
      //   return search.state.isLoading || search.state.histories.isEmpty
      //       ? NoSearchHistory()
      //       : NoSearchHistory();
      // })


      // !entriesAsync.isLoading && entriesAsync.requireValue.page > 0
      //     ? SearchEntry(metaDatax: metaDatax,)
      //     : SearchHistory(metaDatax: metaDatax,)
    );
  }

}