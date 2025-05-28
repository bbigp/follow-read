

import 'package:flutter/material.dart';

import '../config/theme.dart';

class AppTextStyles {

  AppTextStyles._();

  static const TextStyle text = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
  ); //1.33高度是20
  static const TextStyle text500 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppTheme.black95,
  );
  static const TextStyle text17500 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppTheme.black95,
  );//height 22
  static const TextStyle text13500 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppTheme.black95,
  );
  static const TextStyle text28500 = TextStyle(
    fontSize: 28, fontWeight: FontWeight.w500, height: 1.21, color: AppTheme.black95,
  );// 34px

  //说明
  static const TextStyle caption = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black50,
  );
  static const TextStyle caption13 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppTheme.black50,
  );
  static const TextStyle caption13500 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppTheme.black50,
  );
  static const TextStyle caption500 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppTheme.black50,
  );

  static const TextStyle hint500 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppTheme.black25,
  );

  static const TextStyle hint17500 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppTheme.black25,
  );
  static const TextStyle hint11500 = TextStyle(
      fontSize: 11, fontWeight: FontWeight.w500, height: 1.18, color: AppTheme.black25,
  );//13px

  static const TextStyle hint13500 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppTheme.black25,
  );// 18

  static const TextStyle red13 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppTheme.red,
  );//height 18
  static const TextStyle red13500 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppTheme.red,
  );//height 18

  static const TextStyle red = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.red,
  );

  static const TextStyle blue13 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppTheme.blue,
  );

  static const TextStyle red500 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppTheme.red,
  );

  static const TextStyle red17500 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppTheme.red,
  );

  static const TextStyle white500 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: Colors.white,
  );

  static const TextStyle white17500 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: Colors.white,
  );
}