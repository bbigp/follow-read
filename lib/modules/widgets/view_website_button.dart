

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/theme.dart';

class ViewWebsiteButton extends StatelessWidget {

  final String url;

  const ViewWebsiteButton({super.key, required this.url});


  Future<void> _openBrowser(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: IntrinsicWidth(
        child: GestureDetector(
          onTap:  () => _openBrowser(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 44,
              constraints: const BoxConstraints(
                minWidth: 125, // 可选：设置最小宽度
              ),
              color: Color.fromRGBO(0, 0, 0, 0.04),
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisSize: MainAxisSize.min, // 关键属性：收缩宽度
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View Website',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                      color: AppTheme.black95,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    'assets/svg/out_o.svg',
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}