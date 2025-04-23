import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/features/domain/models/sync_task.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../providers/sync_data_provider.dart';

class SyncView extends ConsumerWidget {

  const SyncView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncProvider);
    if (syncState.status == "") {
      return Container();
    }
    String msg = "";
    Color textColor = AppTheme.blue;
    Color backColor = AppTheme.blueBackground;
    Color btnBackColor = AppTheme.blueBackground;
    String leftIcon = Svgicons.link;
    if (syncState.status == SyncTask.syncing) {
        msg = '数据同步中(${syncState.progress}/${syncState.total})...';
    } else if (syncState.status == SyncTask.success) {
      msg = "同步成功 ${syncState.executeTime}";
    } else if  (syncState.status == SyncTask.failed) {
      msg = "同步失败";
      textColor = AppTheme.red;
      backColor = AppTheme.redBackground;
      btnBackColor = AppTheme.red10;
      leftIcon = Svgicons.alertFill;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Row(
              children: [
                SizedBox(width: 4,),
                Svgicon(leftIcon, size: 16, iconSize: 16,),
                SizedBox(width: 8,),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(msg, style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.38,
                    color: textColor,
                  ),
                    overflow: TextOverflow.ellipsis, // 添加溢出处理
                    maxLines: 1,
                  ),),
                SizedBox(width: 8,),
              ],
            )),
            if (syncState.status == SyncTask.failed)
              GestureDetector(
                onTap: () {
                  ref.read(syncProvider.notifier).startSync();
                },
                child: Container(
                  height: 28,
                  decoration: BoxDecoration(
                    color: btnBackColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 12,),
                      SvgPicture.asset(Svgicons.reset, width: 16, height: 16,),
                      SizedBox(width: 8,),
                      Text('重试', style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: textColor,
                      ),),
                      SizedBox(width: 16,)
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
