

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/theme/text_styles.dart';

import 'buttonx.dart';
import 'text_fieldx.dart';

class SearchBarx extends StatelessWidget implements PreferredSizeWidget {

  final ValueChanged<String>? onSubmitted;
  final void Function(String)? onChanged;
  final String value;
  const SearchBarx({super.key, this.onSubmitted, this.onChanged, this.value = ""});

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
          Expanded(child: TextFieldx(
            sizex: Sizex.small,
            icon: SvgPicture.asset(Svgicons.search, width: 20, height: 20,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(AppTheme.black25, BlendMode.srcIn),
            ),
            hint: '搜索',
            onSubmitted: onSubmitted,
            onChanged: onChanged,
            value: value,
          ),),
          TextButtonx(child: '取消',
            size: Sizex.custom, type: ButtonxType.ghost, enabled: true,
            buttonSize: smallCompact().copyWith(textSize: AppTextStyles.text500),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ],),
      ),
    );

  }


}