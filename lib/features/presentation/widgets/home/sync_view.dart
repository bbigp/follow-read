import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/domain/models/sync_task.dart';
import 'package:follow_read/features/presentation/providers/sync_data_provider.dart';
import 'package:follow_read/features/presentation/widgets/components/alert_view.dart';

///
class SyncView extends ConsumerWidget {

  const SyncView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncProvider);
    if (syncState.status == "") {
      return const SizedBox.shrink();
    }
    String msg;
    AlertViewType type = AlertViewType.normal;
    String icon = Svgicons.link;
    String? action;
    String? actionIcon;
    if (syncState.status == SyncTask.syncing) {
      msg = '数据同步中(${syncState.progress}/${syncState.total})...';
    } else if (syncState.status == SyncTask.success) {
      msg = "同步成功 ${syncState.executeTime}";
    } else {
      msg = "同步失败";
      type = AlertViewType.danger;
      icon = Svgicons.alert_fill;
      actionIcon = Svgicons.reset;
      action = "重试";
    }
    //ref.read(syncProvider.notifier).startSync();
    return Container(padding: EdgeInsets.only(left: 12, right: 12),
      color: Colors.white,
      child: AlertView(icon: icon, title: msg, type: type, action: action, actionIcon: actionIcon,),
    );
  }
}
