

import 'package:flutter/material.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/text_fieldx.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginView extends StatelessWidget {

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    Widget child = Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 200,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 4),
        child: Text('Get Started', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.M28,),
      ),
      const SizedBox(height: 8,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 6),
        child: Text('Enter token and server address', maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.R15B50,),
      ),
      const SizedBox(height: 24,),
      Obx(() {
        return TextFieldx(sizex: Sizex.medium, hint: "服务器地址", value: controller.state.apiURL, onChanged: (v) {
          controller.change(apiURL: v);
        },);
      }),
      const SizedBox(height: 16,),
      Obx((){
        return TextFieldx(sizex: Sizex.medium, hint: "令牌", value: controller.state.apiToken, onChanged: (v) {
          controller.change(apiToken: v);
        },);
      }),
      const SizedBox(height: 16,),
      Obx((){
        return TextButtonx(child: "Continue", size: Sizex.large,
          enabled: controller.state.apiURL.isNotEmpty && controller.state.apiToken.isNotEmpty,
          onPressed: () async {
            await controller.login();
          },
        );
      }),
      // const SizedBox(height: 16,),
      // Padding(padding: EdgeInsets.all(4),
      //   child: Row(children: [
      //     Expanded(child: DashedDivider(spacing: 18, )),
      //     const SizedBox(width: 8, height: 18,),
      //     Text("OR", style: AppTextStyles.hint13500,),
      //     const SizedBox(width: 8, height: 18,),
      //     Expanded(child: DashedDivider(spacing: 18, )),
      //   ],),
      // ),
      // const SizedBox(height: 16,),
      // IconButtonx(icon: Svgicons.apple, child: "Continue with Apple", size: Sizex.large, enabled: true, type: ButtonxType.secondary,),
      // const SizedBox(height: 16,),

      const SizedBox(height: 40,),
      const SizedBox(height: 36,),
      const SizedBox(height: 24,)
    ],),);
    Widget stack = Stack(
      children: [
        child,
        Positioned(left: 0, right: 0, bottom: 24,
            child: Column(children: [
          Center(child: Text("By continuing, you agree to our", style: AppTextStyles.R13B25),),
          Center(child: Text(" Terms of Use and Privacy Policy", style: AppTextStyles.R13B25,),),
        ],))
      ],
    );
    return Scaffold(
        resizeToAvoidBottomInset: true,
        // appBar: CupxAppBar(),
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints){
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // ✅ 适配键盘高度
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(child: stack,),
            ),
          );
        }))
    );
  }


}