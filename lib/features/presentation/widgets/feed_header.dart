import 'package:flutter/material.dart';

import '../../../config/theme.dart';
import 'components/alert_view.dart';
import 'components/dashed_line.dart';

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
