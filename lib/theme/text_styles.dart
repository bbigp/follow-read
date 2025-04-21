

import 'package:flutter/material.dart';

import '../config/theme.dart';

class AppTextStyles {

  AppTextStyles._();

  static const TextStyle text = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
  );
  //说明
  static const TextStyle caption = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black50,
  );

}