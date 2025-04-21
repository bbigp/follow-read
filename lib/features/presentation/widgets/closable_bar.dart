
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';

class ClosableBar extends StatelessWidget {

  final String title;
  final double horizontal;

  const ClosableBar({super.key,
    required this.title,
    this.horizontal = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: horizontal, height: 42,),
        Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppTheme.black95,
          ),)),
        const SizedBox(width: 12, height: 30,),
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            width: 30, height: 30,
            decoration: BoxDecoration(
              color: AppTheme.black4,
              borderRadius: BorderRadius.circular(99),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(Svgicons.x, width: 20, height: 20,),
          ),
        ),
        SizedBox(width: horizontal,),
      ],
    );
  }

}