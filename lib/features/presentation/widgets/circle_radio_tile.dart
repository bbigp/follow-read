

import 'package:flutter/material.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import 'circle_radio.dart';

class CircleRadioTile extends StatelessWidget {

  final String value;
  final bool choose;
  final ValueChanged<bool> onChanged;

  const CircleRadioTile({super.key,
    required this.value, this.choose = false,
    required this.onChanged,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 12, height: 40,),
        Svgicon(Svgicons.folder, size: 32, iconSize: 24,),
        SizedBox(width: 12,),
        Expanded(child: Text(value, style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
        ),)),
        SizedBox(width: 12,),
        CircleRadio(
          onChanged: onChanged,
          choose: choose,
        ),
        SizedBox(width: 12,),
      ],
    );
  }


}