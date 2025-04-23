
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/widgets/feed/svg_icon_button.dart';
import 'package:follow_read/theme/text_styles.dart';

class AlertBanner extends StatelessWidget {

  final String data;
  final String buttonText;

  const AlertBanner({super.key,
    this.data = '',
    this.buttonText = '',
  });


  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(children: [
        Container(
          color: AppTheme.white0,
          width: double.infinity,
        ),
        Positioned(
          child: Container(
            // height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.red10,
            ),
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Row(children: [
              const SizedBox(width: 4,),
              SvgPicture.asset(Svgicons.alertFill, width: 16, height: 16,),
              const SizedBox(width: 8,),
              Expanded(child: Text(data, maxLines: 5, style: AppTextStyles.red13,),),
              Visibility(
                visible: buttonText.isNotEmpty,
                child: const SizedBox(width: 8,),
              ),
              Visibility(visible: buttonText.isNotEmpty,
                  child: SvgIconButton(label: buttonText,
                    height: 28,
                    borderRadius: BorderRadius.circular(6),
                    backgroundColor: AppTheme.red10,
                    icon: Svgicons.reset, iconSize: 16,
                    textStyle: AppTextStyles.red13500,
                    padding: EdgeInsets.only(left: 12, right: 16),
                  )
              ),
            ],),
          ),
        )
      ],),
    );
  }

}