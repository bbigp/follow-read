

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:get/get.dart';

import 'buttonx.dart';
import 'element_type.dart';
import 'text_fieldx.dart';


class SearchBarx extends StatelessWidget implements PreferredSizeWidget {

  final ValueChanged<String>? onSubmitted;
  final void Function(String)? onChanged;
  final String Function() valueGetter;
  final FocusNode? focusNode;
  const SearchBarx({super.key, this.onSubmitted, this.onChanged, required this.valueGetter,
    this.focusNode,
  });

  @override
  Size get preferredSize => Size.fromHeight(54);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 54, color: Colors.white,
        child: Row(children: [
          const SizedBox(width: 16,),
          Expanded(child: Obx((){
            final value = valueGetter();
            return SearchTextField(onSubmitted: onSubmitted, onChanged: onChanged,
              value: value, focusNode: focusNode,
            );
          })),
          TextButtonx(child: '取消',
            size: Sizex.custom, type: ElementType.ghost, enabled: true,
            buttonSize: smallCompact().copyWith(textSize: AppTextStyles.M15),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ],),
      ),
    );

  }


}