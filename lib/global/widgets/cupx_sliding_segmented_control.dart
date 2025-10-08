
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';

import 'pg_text.dart';

///
class CupxSlidingSegmentedControl extends StatelessWidget {

  final String groupValue;
  final ValueChanged<String?> onValueChanged;
  final List<String> children;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final double segmentedHeight;
  final BorderRadiusGeometry? segmentedBorderRadius;
  final double trackPadding;

  const CupxSlidingSegmentedControl({
    super.key,
    required this.groupValue,
    required this.onValueChanged,
    required this.children,
    this.height = 38,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.segmentedHeight = 32,
    this.segmentedBorderRadius = const BorderRadius.all(Radius.circular(8)),
    this.trackPadding = 4,
  });

  factory CupxSlidingSegmentedControl.big({
    required String groupValue,
    required ValueChanged<String?> onValueChanged,
    required List<String> children,
  }) {
    return CupxSlidingSegmentedControl(
      groupValue: groupValue,
      onValueChanged: onValueChanged,
      children: children,
      height: 48,
      borderRadius: BorderRadius.circular(14),
      segmentedHeight: 40,
      segmentedBorderRadius: BorderRadius.circular(10),
      trackPadding: 4,
    );
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double totalWidth = constraints.maxWidth;
      double itemWidth = (totalWidth - trackPadding * 2 * 2 ) / children.length;

      final Map<String, Widget> map = {
        for (var item in children)
          item: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              minWidth: itemWidth,
              maxWidth: itemWidth,
              minHeight: segmentedHeight,
              maxHeight: segmentedHeight,
            ),
            decoration: item == groupValue ? BoxDecoration(
              borderRadius: segmentedBorderRadius,
              color: Colors.white,
            ) : null ,
            child: PgText(item, textAlign: TextAlign.center, style: groupValue == item ? AppTextStyles.M15 :  AppTextStyles.M15B50),
          ),
      };

      return Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColors.black04,
        ),
        child: CupertinoSlidingSegmentedControl<String>(
          padding: EdgeInsets.symmetric(horizontal: trackPadding,),
          backgroundColor: Colors.transparent,
          groupValue: groupValue,
          onValueChanged: onValueChanged,
          children: map,
        ),
      );
    });

  }

}


