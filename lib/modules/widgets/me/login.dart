

import 'package:flutter/material.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/modules/widgets/acx/buttonx.dart';
import 'package:follow_read/modules/widgets/acx/cupx_app_bar.dart';
import 'package:follow_read/modules/widgets/acx/dashed_line.dart';
import 'package:follow_read/modules/widgets/acx/text_fieldx.dart';
import 'package:follow_read/theme/text_styles.dart';

class Login extends StatelessWidget {

  const Login({super.key});

  @override
  Widget build(BuildContext context) {

    Widget child = Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 24,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 4),
        child: Text('Get Started', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text28500,),
      ),
      const SizedBox(height: 8,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 6),
        child: Text('Enter or create an account in a few steps', maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.caption,),
      ),
      const SizedBox(height: 24,),
      TextFieldx(sizex: Sizex.medium, hint: "服务器地址",),
      const SizedBox(height: 16,),
      TextFieldx(sizex: Sizex.medium, hint: "令牌",),
      const SizedBox(height: 16,),
      TextButtonx(child: "Continue", size: Sizex.large, enabled: true,),
      const SizedBox(height: 16,),
      Padding(padding: EdgeInsets.all(4),
        child: Row(children: [
          Expanded(child: DashedDivider(spacing: 18, )),
          const SizedBox(width: 8, height: 18,),
          Text("OR", style: AppTextStyles.hint13500,),
          const SizedBox(width: 8, height: 18,),
          Expanded(child: DashedDivider(spacing: 18, )),
        ],),
      ),
      const SizedBox(height: 16,),
      IconButtonx(icon: Svgicons.apple, child: "Continue with Apple", size: Sizex.large, enabled: true, type: ButtonxType.primary,),
      const SizedBox(height: 16,),
      TextButtonx(child: "Continue with Google", size: Sizex.large, enabled: true, type: ButtonxType.secondary,),

      const SizedBox(height: 271-24-24-34- 36,),
      Center(child: Text("By continuing, you agree to our", style: AppTextStyles.hint13),),
      Center(child: Text(" Terms of Use and Privacy Policy", style: AppTextStyles.hint13,),)
    ],),);
    return Scaffold(
      appBar: CupxAppBar(),
      body: child
    );
  }




}