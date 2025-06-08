import 'package:flutter/material.dart';
import 'package:follow_read/config/theme.dart';


class OpenModal {
  static void open(BuildContext context, Widget view, {
    double maxHeightFactor = 0.85, // 最大高度比例
    bool hasMargin = false,
  }) {
    final controller = AnimationController(
      duration: const Duration(milliseconds: 300), // 动画时长
      vsync: Navigator.of(context), // 必须由 State/StatefulWidget 提供 TickerProvider
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 允许内容高度超过屏幕70%
      backgroundColor: Colors.transparent,
      enableDrag: true,
      transitionAnimationController: controller,
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        final bottomPadding = mediaQuery.viewInsets.bottom;
        Widget content = ConstrainedBox(// 如果需要滚动，就限制最大高度并加滚动容器
                constraints: BoxConstraints(
                    maxHeight: mediaQuery.size.height * maxHeightFactor),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: bottomPadding),
                  child: view,
                ),
              );

        return SafeArea(
            bottom: false,
            child: Padding(
              padding: hasMargin ? const EdgeInsets.only(left: 16, right: 16, bottom: 16,) : EdgeInsets.zero,
              child: Material(
                color: AppTheme.white95,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: hasMargin
                      ? BorderRadius.circular(16)
                      : const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque, //确保点击空白区域也能触发
                  onTap: () => FocusScope.of(context).unfocus(), //仅取消键盘，不关闭 modal
                  child: content,
                ),
              ),
            )
        );
      },
    );
  }


  static void closeMultiple(BuildContext context, {int count = 1,}) {
    for (var i = 0; i < count; i++) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

}


// Widget content = true
//     ? ConstrainedBox(// 如果需要滚动，就限制最大高度并加滚动容器
//   constraints: BoxConstraints(
//       maxHeight: mediaQuery.size.height * maxHeightFactor),
//   child: SingleChildScrollView(
//     padding: EdgeInsets.only(bottom: bottomPadding),
//     child: view,
//   ),
// )
//     : Padding(
//   padding: EdgeInsets.only(bottom: bottomPadding),
//   child: IntrinsicHeight(// 不滚动，自动根据内容高度适配
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [view],
//     ),
//   ),
// );