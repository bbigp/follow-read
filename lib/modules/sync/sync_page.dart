

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/cupx_app_bar.dart';
import 'package:follow_read/global/widgets/cupx_sheet_title.dart';
import 'package:follow_read/global/widgets/loading_more.dart';
import 'package:follow_read/global/widgets/no_more.dart';
import 'package:follow_read/global/widgets/padded_svg_icon.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/modules/sync/sync_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      appBar: CenteredSheetTitleBar(
        title: "同步记录",
      ),
      body: Obx((){
          if (sync.state.isLoading) return const Center(child: LoadingMore(),);
          return RefreshIndicator(
            onRefresh: () => sync.getSyncRecords(),
            child: ListView.separated(
              controller: _scrollController,
              itemCount: sync.state.records.length + 1,
              itemBuilder: (context, index) {
                if (index == sync.state.records.length) {
                  return sync.state.hasMore ? const LoadingMore() : const NoMore();
                }
                final record = sync.state.records[index];
                final start = record.startTime == null ? "" : DateFormat('yyyy-MM-dd HH:mm:ss').format(record.startTime!.toUtc());
                final end = record.endTime == null ? "" : DateFormat('yyyy-MM-dd HH:mm:ss').format(record.endTime!.toUtc());
                final executeTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(record.time);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(children: [
                    Row(children: [
                      Expanded(child: PgText("时间: $executeTime", style: AppTextStyles.R15)),
                    ],),
                    const SizedBox(height: 4,),
                    Row(children: [
                      PgText("状态: ", style: AppTextStyles.R15, maxWidth: 200,),
                      Expanded(child: PgText(record.status, style: AppTextStyles.R15B50)),
                    ],),
                    const SizedBox(height: 4,),
                    Row(children: [
                      PgText("数据: ", style: AppTextStyles.R15, maxWidth: 200,),
                      Expanded(child: PgText("feed:${record.feed} folder:${record.folder} media:${record.media}", style: AppTextStyles.R15B50)),
                    ],),
                    const SizedBox(height: 4,),
                    Row(children: [
                      Expanded(child: PgText("$start - $end", style: AppTextStyles.R15B50)),
                    ],),
                    if (record.errorMsg != "")
                      Row(children: [
                        Expanded(child: PgText(record.errorMsg, style: AppTextStyles.R15B50)),
                      ],)
                  ],),
                );
              }, separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: const SpacerDivider(indent: 0, spacing: 1, thickness: 0.5,),
                );
              },
            ),
          );
      }),
    );
  }

}