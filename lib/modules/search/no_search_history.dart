

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';

///
class NoSearchHistory extends StatelessWidget {

  final String value;
  const NoSearchHistory({super.key, this.value = "Search"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(SvgIcons.search_1, width: 56, height: 56, fit: BoxFit.contain,),
          Text(value, maxLines: 1, style: AppTextStyles.M15B25,),
        ],
      ),),
    );
  }


}