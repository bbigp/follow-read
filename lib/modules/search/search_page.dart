

import 'package:flutter/material.dart';
import 'package:follow_read/global/widgets/search_barx.dart';
import 'package:follow_read/modules/search/search_entries.dart';
import 'package:follow_read/modules/search/search_history_view.dart';
import 'package:get/get.dart';

import 'search_controller.dart';


class SearchPage extends StatelessWidget {

  SearchPage({super.key,});

  final search = Get.find<SearchHistoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchBarx(
        valueGetter: () => search.state.word,
        onSubmitted: (value) async {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            FocusScope.of(context).unfocus(); // 收起键盘
          });
          await search.loadEntries(value);
        },
        onChanged: (value) async {
          if (value == "") {
            await search.clearEntries();
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