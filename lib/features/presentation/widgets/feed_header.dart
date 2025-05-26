import 'package:flutter/material.dart';

import '../../../config/theme.dart';
import 'components/alert_view.dart';
import 'components/dashed_line.dart';

class FeedHeader extends StatelessWidget {

  final String title;
  final int unread;
  final int errorCount;
  final String errorMsg;

  const FeedHeader({
    super.key,
    this.title = 'All',
    this.unread = 0,
    this.errorCount = 0,
    this.errorMsg = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Visibility  (
        //   visible: false,
        //     maintainSize: true, // 保持组件的尺寸
        //     maintainAnimation: true, // 保持动画状态
        //     maintainState: true, // 保持状态
        //     child: AlertView(data: errorMsg,)
        // ),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      height: 1.21,
                      color: AppTheme.black95,
                    ),
                  )),
                ],
              ),
              if (unread > 0)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6, left: 4),
                      child: Text(
                        '${unread.toString()}未读',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          height: 1.18,
                          color: AppTheme.black25,
                        ),
                      ),
                    )
                  ],
                )
            ],
          ),
        ),
        const DashedDivider(
          indent: 0,
          spacing: 16,
          thickness: 1,
          color: AppTheme.black8,
        ),
      ],
    );
  }
}

class SkeletonFeedHeader extends StatelessWidget {
  const SkeletonFeedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        height: 1.21,
                        color: AppTheme.black95,
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 4,
                      ),
                      child: Container(
                        width: 80,
                        height: 10,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          DashedDivider(
            indent: 0,
            spacing: 16,
            thickness: 1,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
