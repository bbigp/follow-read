

import 'package:flutter/material.dart';

import '../config/theme.dart';

class SmartModal {

  static void openSmartModal(BuildContext context, Widget child) {
    showDialog(
      context: context,
      barrierDismissible: false, // 我们自定义点击行为
      barrierColor: Colors.black54,
      builder: (context) {
        return Scaffold(
            resizeToAvoidBottomInset: false, // 避免键盘弹出时整个内容上移错位
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  GestureDetector(onTap: (){
                    if (MediaQuery.of(context).viewInsets.bottom > 0) {
                      FocusScope.of(context).unfocus();
                    } else {
                      Navigator.of(context).pop();
                    }
                  }, child: Container(color: Colors.transparent,),),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Material(
                      color: AppTheme.white95,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      child: SafeArea(
                        top: false,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).viewInsets.bottom + 16),
                          child: child,
                        ),
                      ),
                    ),
                  )
                ],
              )
            )
        );
      },
    );
  }


}