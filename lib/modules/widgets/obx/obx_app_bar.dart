

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ObxAppBar extends StatelessWidget implements PreferredSizeWidget {

  final Widget Function() builder;
  final double height;
  const ObxAppBar({super.key, required this.builder, this.height = 58.0,});

  @override
  Widget build(BuildContext context) {
    return Obx(() => builder());
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

}