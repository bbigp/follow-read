
import 'package:flutter/material.dart';

import '../../../config/theme.dart';
import 'drag_handle.dart';

class OpenModal {

  static void open(BuildContext context, Widget view){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // 允许内容高度超过屏幕70%
      backgroundColor: AppTheme.white95,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,//确保点击空白区域也能触发
          onTap: (){
            FocusScope.of(context).unfocus();//仅取消键盘，不关闭 modal
          },
          child: Padding(padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DragHandle(),
                    view,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}