


import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/pending_change.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/cupx_sheet_title.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/modules/pending_change/pending_change_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'generic_paged_list_view.dart';

class PendingChangePage extends StatelessWidget{

  final changeController = Get.find<PendingChangeController>();
  PendingChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CenteredSheetTitleBar(title: "变更",),
      body: GenericPagedListView<PendingChangeController, PendingChange>(
        controller: changeController,
        itemBuilder: (BuildContext context, PendingChange item, int index) {
          final time = item.executeTime == null ? "" : DateFormat('yyyy-MM-dd HH:mm:ss').format(item.executeTime!);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              Column(children: [
                Expanded(child: PgText("执行时间: $time", style: AppTextStyles.R15)),
                Row(children: [
                  Expanded(child: PgText(item.action.toString(), style: AppTextStyles.R15)),
                  Expanded(child: PgText(item.contentId, style: AppTextStyles.R15)),
                ],),
                Row(children: [
                  Expanded(child: PgText(item.status.toString(), style: AppTextStyles.R15)),
                  Expanded(child: PgText(item.msg, style: AppTextStyles.R15)),
                ],),
                if (item.extra != "")
                  Expanded(child: PgText(item.extra, style: AppTextStyles.R15)),
              ],),
              TextButtonx(
                child: "提交", size: Sizex.mediumCompact,
                enabled: item.status != PendingChangeStatus.success,
                onPressed: () async => await changeController.submit(item),
              ),
            ],),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: const SpacerDivider(indent: 0, spacing: 1, thickness: 0.5,),
          );
        },
      ),
    );
  }


}