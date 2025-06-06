import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/domain/models/sync_task.dart';
import 'package:follow_read/features/presentation/providers/sync_data_provider.dart';
import 'package:follow_read/modules/widgets/acx/alert_view.dart';

///
class SyncView extends ConsumerWidget {

  final bool skeleton;
  const SyncView({super.key, this.skeleton = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncProvider);
    if (syncState.status == "") {
      return const SizedBox.shrink();
    }
    AlertTipType type = syncState.status == SyncTask.failed
        ? AlertTipType.danger
        : AlertTipType.normal;
    String icon = syncState.status == SyncTask.failed
        ? Svgicons.alert_fill
        : Svgicons.link;
    String msg;
    AlertTipActionButton? button;
    if (syncState.status == SyncTask.syncing) {
      msg = '数据同步中(${syncState.progress}/${syncState.total})...';
    } else if (syncState.status == SyncTask.success) {
      msg = "同步成功 ${syncState.executeTime}";
    } else {
      msg = "同步失败";
      button = AlertTipActionButton(icon: Svgicons.reset, child: "重试", onTap: (){
        ref.read(syncProvider.notifier).startSync();
      });
    }
    return Container(padding: EdgeInsets.only(left: 12, right: 12, bottom: 8),
      color: Colors.white,
      child: AlertTip(icon: icon, title: msg, type: type, action: button,
        skeleton: skeleton,
      ),
    );
  }
}
