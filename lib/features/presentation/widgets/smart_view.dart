import 'package:flutter/material.dart';

class SmartViewSection extends StatelessWidget {
  final Map<String, int> counts;
  final bool isLoading;

  const SmartViewSection({
    super.key,
    required this.counts,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: Text('智能视图',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B0000),
              )),
        ),
        Column(
          children: [
            ListTile(
              dense: true,
              // 使ListTile更紧凑
              horizontalTitleGap: 8,
              // 减小图标和文字之间的距离
              minLeadingWidth: 20,
              // 减小leading区域的最小宽度
              leading: const Icon(Icons.history),
              title: const Text('近期已读'),
              trailing: Text(
                '${counts['recent']}', // 这里可以是你想显示的任何数字
                style: const TextStyle(
                  color: Color(0xFF8B0000),
                  fontSize: 14,
                ),
              ),
              onTap: () {
                // 处理点击事件
              },
            ),
            ListTile(
              dense: true,
              // 使ListTile更紧凑
              horizontalTitleGap: 8,
              // 减小图标和文字之间的距离
              minLeadingWidth: 20,
              // 减小leading区域的最小宽度
              leading: const Icon(Icons.star_border),
              title: const Text('星标'),
              trailing: Text(
                '${counts['star']}', // 这里可以是你想显示的任何数字
                style: const TextStyle(
                  color: Color(0xFF8B0000),
                  fontSize: 14,
                ),
              ),
              onTap: () {
                // 处理点击事件
              },
            ),
            ListTile(
              dense: true,
              // 使ListTile更紧凑
              horizontalTitleGap: 8,
              // 减小图标和文字之间的距离
              minLeadingWidth: 20,
              // 减小leading区域的最小宽度
              leading: const Icon(Icons.circle_outlined),
              title: const Text('未读'),
              trailing: Text(
                '${counts['unread']}', // 这里可以是你想显示的任何数字
                style: const TextStyle(
                  color: Color(0xFF8B0000),
                  fontSize: 14,
                ),
              ),
              onTap: () {
                // 处理点击事件
              },
            ),
            ListTile(
              dense: true,
              // 使ListTile更紧凑
              horizontalTitleGap: 8,
              // 减小图标和文字之间的距离
              minLeadingWidth: 20,
              // 减小leading区域的最小宽度
              leading: const Icon(Icons.calendar_today_outlined),
              title: const Text('今日'),
              trailing: Text(
                '${counts['today']}', // 这里可以是你想显示的任何数字
                style: const TextStyle(
                  color: Color(0xFF8B0000),
                  fontSize: 14,
                ),
              ),
              onTap: () {
                // 处理点击事件
              },
            ),
          ],
        ),
      ],
    );
  }
}
