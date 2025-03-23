

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/theme.dart';

class ViewWebsiteButton extends StatelessWidget {

  const ViewWebsiteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: IntrinsicWidth(
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
    );
  }

}