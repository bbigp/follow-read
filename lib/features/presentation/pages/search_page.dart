

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/cases/base.dart';
import 'package:follow_read/features/presentation/widgets/components/search_barx.dart';
import 'package:follow_read/features/presentation/widgets/search/search_history.dart';
import 'package:follow_read/features/presentation/widgets/search/search_entry.dart';


class SearchPage extends ConsumerWidget {

  final MetaDatax metaDatax;
  const SearchPage({super.key, required this.metaDatax,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = metaDatax.page(ref);
    String word = entriesAsync.isLoading ? "" : entriesAsync.requireValue.builder!.word;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchBarx(
        value: word,
        onSubmitted: (value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            FocusScope.of(context).unfocus(); // 收起键盘
          });
          metaDatax.loadMore(ref, word: value);
        },
        onChanged: (value) {
          if (value == "") {
            metaDatax.init(ref);
          }
        },
      ),
      body: !entriesAsync.isLoading && entriesAsync.requireValue.page > 0
          ? SearchEntry(metaDatax: metaDatax,)
          : SearchHistory(metaDatax: metaDatax,)
    );
  }

}