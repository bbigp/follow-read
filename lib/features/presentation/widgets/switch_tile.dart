

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/theme.dart';

class SwitchTile extends StatelessWidget {

  final String assetName;
  final String title;
  final bool open;
  final ValueChanged<bool>? onChanged;

  const SwitchTile(this.assetName, this.title,
      {super.key, this.open = false, required this.onChanged,});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16, height: 40,),
        SvgPicture.asset(assetName, width: 24, height: 24,),
        SizedBox(width: 12,),
        Expanded(child: Text(title, style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
        ),)),
        SizedBox(width: 4,),
        SizedBox(
            height: 28, width: 48,
            child: Transform.scale(
              scale: 0.8, // 缩放比例 (0.8 对应默认尺寸的 80%)
              child: Switch(
                value: open,
                padding: EdgeInsets.all(0),
                thumbIcon: WidgetStateProperty.resolveWith<Icon>((states) {
                  return Icon(Icons.circle, size: 20,
                    color: Colors.white,
                  );
                }),
                activeColor: Colors.white,      // 开启状态滑块颜色
                activeTrackColor: AppTheme.black95, // 开启轨道颜色
                inactiveThumbColor: Colors.white, // 关闭状态滑块颜色
                inactiveTrackColor: AppTheme.black8, // 关闭轨道颜色
                trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent), // 移除边框
                trackOutlineWidth: const WidgetStatePropertyAll(0.0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 调整点击区域
                onChanged: onChanged,
              ),
            )
        ),
        SizedBox(width: 12,),
      ],
    );
  }

}