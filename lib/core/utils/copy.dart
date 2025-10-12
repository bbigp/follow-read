

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Copy {

  /// 将指定的文本内容复制到设备的剪贴板
  static void clipboard(String textToCopy) async {
    if (textToCopy.isEmpty) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: textToCopy));
    Get.snackbar('成功', '内容已复制');
  }

}