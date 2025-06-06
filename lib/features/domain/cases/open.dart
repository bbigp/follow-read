

import 'package:flutter/material.dart';
import 'package:follow_read/widgets/open_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class Open {


  static modal(BuildContext context, Widget view){
    OpenModal.open(context, view);
  }


  static Future<void> browser(BuildContext context, String url) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final uri = Uri.parse(url);
      if (!await canLaunchUrl(uri)) {
        throw '无可用浏览器或链接无效';
      }
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // 强制使用外部应用
        webOnlyWindowName: '_blank', // Web 专用：新标签页打开
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('无法打开链接: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }


}