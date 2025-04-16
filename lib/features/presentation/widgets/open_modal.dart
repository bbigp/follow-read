
import 'package:flutter/material.dart';

import '../../../config/theme.dart';
import 'drag_handle.dart';

class OpenModal {

  static void open(BuildContext context, Widget view,{
    bool scrollable = false, // 👈 是否启用滚动容器
    double maxHeightFactor = 0.85, // 最大高度比例
  }){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // 允许内容高度超过屏幕70%
      backgroundColor: AppTheme.white95,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        final bottomPadding = mediaQuery.viewInsets.bottom;
        final maxHeight = mediaQuery.size.height * maxHeightFactor;
        Widget content = scrollable
            ? ConstrainedBox( // 如果需要滚动，就限制最大高度并加滚动容器
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: view,
          ),
        )
            : Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: IntrinsicHeight( // 不滚动，自动根据内容高度适配
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [view],
            ),
          ),
        );

        return GestureDetector(
          behavior: HitTestBehavior.opaque,//确保点击空白区域也能触发
          onTap: () =>FocusScope.of(context).unfocus(), //仅取消键盘，不关闭 modal
          child: content,
        );
      },
    );
  }
}