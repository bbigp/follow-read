

import 'package:flutter/material.dart';

import '../../config/theme.dart';
import 'app_colors.dart';

// ignore_for_file: constant_identifier_names
class AppTextStyles {

  AppTextStyles._();

  //FontWeight  w400 R（Regular） 500 M （Medium） 700 B （Bold）
  //颜色 黑色 B95  红色R00
  //R15B95   B95默认不加

  static const TextStyle R15 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppColors.black95,
  ); //1.33高度是20
  static const TextStyle M15 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppColors.black95,
  );
  static const TextStyle M17 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppColors.black95,
  );//height 22
  static const TextStyle M13 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppColors.black95,
  ); // 18px
  static const TextStyle M28 = TextStyle(
    fontSize: 28, fontWeight: FontWeight.w500, height: 1.21, color: AppColors.black95,
  );// 34px
  static const TextStyle M22 = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w500, height: 1.27, color: AppColors.black95,
  ); //28px
  static const TextStyle M20 = TextStyle(
    fontSize: 20, fontWeight: FontWeight.w500, height: 1.21, color: AppColors.black95,
  );

  //说明
  static const TextStyle R15B50 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppColors.black50,
  );
  static const TextStyle R13B50 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppColors.black50,
  );
  static const TextStyle M13B50 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppColors.black50,
  );
  static const TextStyle M15B50 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppColors.black50,
  );
  static const TextStyle M11B50 = TextStyle(
    fontSize: 11, fontWeight: FontWeight.w500, height: 1.18, color: AppColors.black50,
  );//13px
  static const TextStyle M17B50 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppColors.black50,
  );


  static const TextStyle R15B25 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppColors.black25,
  );
  static const TextStyle M15B25 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppColors.black25,
  );

  static const TextStyle M17B25 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppColors.black25,
  );
  static const TextStyle M11B25 = TextStyle(
      fontSize: 11, fontWeight: FontWeight.w500, height: 1.18, color: AppColors.black25,
  );//13px
  static const TextStyle R13B25 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppColors.black25,
  );// 18
  static const TextStyle M13B25 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppColors.black25,
  );// 18


  static const TextStyle M11R00 = TextStyle(
    fontSize: 11, fontWeight: FontWeight.w500, height: 1.18, color: AppColors.red00,
  );//13px
  static const TextStyle R13R00 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppColors.red00,
  );//height 18
  static const TextStyle M13R00 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppColors.red00,
  );//height 18
  static const TextStyle R15R00 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppColors.red00,
  );
  static const TextStyle M17R00 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppColors.red00,
  );
  static const TextStyle M15R00 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppColors.red00,
  );


  static const TextStyle R13Blue00 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppColors.blue00,
  );


  static const TextStyle M15White00 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: Colors.white,
  );
  static const TextStyle M17White00 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: Colors.white,
  );


  static const TextStyle text = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppColors.black95,
  ); //1.33高度是20
  static const TextStyle text500 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppColors.black95,
  );
  static const TextStyle text17500 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppColors.black95,
  );//height 22
  static const TextStyle text13500 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppColors.black95,
  ); // 18px
  static const TextStyle text28500 = TextStyle(
    fontSize: 28, fontWeight: FontWeight.w500, height: 1.21, color: AppColors.black95,
  );// 34px
  static const TextStyle text22500 = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w500, height: 1.27, color: AppColors.black95,
  ); //28px

  //说明
  static const TextStyle caption = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppColors.black50,
  );
  static const TextStyle caption13 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppColors.black50,
  );
  static const TextStyle caption13500 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppColors.black50,
  );
  static const TextStyle caption500 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppColors.black50,
  );
  static const TextStyle caption11500 = TextStyle(
    fontSize: 11, fontWeight: FontWeight.w500, height: 1.18, color: AppColors.black50,
  );//13px


  static const TextStyle hint = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppColors.black25,
  );
  static const TextStyle hint500 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppColors.black25,
  );

  static const TextStyle hint17500 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppColors.black25,
  );
  static const TextStyle hint11500 = TextStyle(
    fontSize: 11, fontWeight: FontWeight.w500, height: 1.18, color: AppColors.black25,
  );//13px

  // static const TextStyle hint13 = TextStyle(
  //   fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppColors.black25,
  // );// 18
  static const TextStyle hint13500 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppColors.black25,
  );// 18

  static const TextStyle red11500 = TextStyle(
    fontSize: 11, fontWeight: FontWeight.w500, height: 1.18, color: AppColors.red00,
  );//13px

  static const TextStyle red13 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppColors.red00,
  );//height 18
  static const TextStyle red13500 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500, height: 1.38, color: AppColors.red00,
  );//height 18

  static const TextStyle red = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppColors.red00,
  );

  static const TextStyle blue13 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppColors.blue00,
  );

  static const TextStyle red500 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppColors.red00,
  );

  static const TextStyle red17500 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppColors.red00,
  );

  static const TextStyle white500 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: Colors.white,
  );

  static const TextStyle white17500 = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: Colors.white,
  );
}