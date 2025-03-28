
import 'package:flutter/material.dart';

import '../../../config/theme.dart';

class HomeGroup extends StatelessWidget {

  final String title;

  const HomeGroup({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      // color: Colors.blue,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            height: 1.29,
            color: AppTheme.black95,
          ),
        ),
      ),
    );
  }

}