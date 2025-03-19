

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/theme.dart';

class NoMoreLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/no_more.svg',
              width: 14,
              height: 14,
              colorFilter: ColorFilter.mode(
                AppTheme.black50, // 设置颜色
                BlendMode.srcIn, // 等效于原 color 属性的效果
              ),
            ),
            //
          ],
        ),
      ),
    );
  }

}