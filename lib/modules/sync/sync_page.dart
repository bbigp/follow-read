

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/cupx_app_bar.dart';
import 'package:follow_read/global/widgets/loading_more.dart';
import 'package:follow_read/global/widgets/no_more.dart';
import 'package:follow_read/global/widgets/padded_svg_icon.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/modules/sync/sync_controller.dart';
import 'package:get/get.dart';

class SyncPage extends StatefulWidget {

  const SyncPage({super.key});

  @override
  State<StatefulWidget> createState() => _SyncPageState();

}

class _SyncPageState extends State<SyncPage> {

  final ScrollController _scrollController = ScrollController();
  final sync = Get.find<SyncController>();

  @override
  void initState() {
    super.initState();
    sync.getSyncRecords();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (sync.state.isLoading) return;
    if (!sync.state.hasMore) return;
    if (sync.state.isLoadingMore) return;
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      sync.nextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(SvgIcons.arrow_left, onTap: () => Get.back()),
      ),
      body: Obx((){
          if (sync.state.isLoading) return const Center(child: LoadingMore(),);
          return RefreshIndicator(
            onRefresh: () => sync.getSyncRecords(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: sync.state.records.length + 1,
              itemBuilder: (context, index) {
                if (index == sync.state.records.length) {
                  return sync.state.hasMore ? const LoadingMore() : const NoMore();
                }
                final record = sync.state.records[index];
                return Column(children: [
                  Row(children: [
                    Expanded(child: PgText("${record.time}", style: AppTextStyles.R15)),
                    PgText(record.status, style: AppTextStyles.R15),
                  ],),
                  Row(children: [
                    Expanded(child: PgText("feed:${record.feed}", style: AppTextStyles.R15)),
                    Expanded(child: PgText("folder:${record.folder}", style: AppTextStyles.R15)),
                    Expanded(child: PgText("media:${record.media}", style: AppTextStyles.R15)),
                  ],),
                  Row(children: [
                    Expanded(child: PgText("${record.startTime} ${record.endTime}", style: AppTextStyles.R15)),
                    Expanded(child: PgText(record.errorMsg, style: AppTextStyles.R15)),
                  ],)
                ],);
              }
            ),
          );
      }),
    );
  }

}