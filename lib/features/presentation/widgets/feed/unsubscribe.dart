

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';

class Unsubscribe extends StatelessWidget {

  final VoidCallback? onPressed;

  const Unsubscribe({super.key, this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed,
        icon: SvgPicture.asset(Svgicons.reduceO),
    );
  }


}