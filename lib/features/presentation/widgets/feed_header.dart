import 'package:flutter/material.dart';

import '../../../config/theme.dart';
import 'dashed_line.dart';

class FeedHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  const FeedHeader({
    required this.title,
    required this.subTitle,
    super.key,
  });

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
                      title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        height: 1.21,
                        color: AppTheme.black95,
                      ),
                    )
                  ],
                ),
                if (subTitle.isNotEmpty)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6, left: 4),
                        child: Text(
                          subTitle,
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
          DashedDivider(
            indent: 0,
            spacing: 16,
            thickness: 1,
            color: AppTheme.black8,
          ),
        ],
      ),
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
