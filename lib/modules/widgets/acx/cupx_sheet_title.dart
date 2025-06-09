

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/modules/widgets/acx/buttonx.dart';
import 'package:follow_read/theme/text_styles.dart';

import 'padded_svg_icon.dart';

class ActionSheetTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final Future<void> Function()? onPressed;
  final bool enabled;
  final Color? color;
  const ActionSheetTitleBar({super.key, this.height = 58.0, this.title = "",
    this.onPressed, this.enabled = false, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(height: height, color: color,
        padding: EdgeInsets.only(top: 10),
        child: ActionSheetTitle(title: title, enabled: enabled,),
      ),
    );
  }


  @override
  Size get preferredSize => Size.fromHeight(height);
}


class ActionSheetTitle extends StatelessWidget {
  final String title;
  final Future<void> Function()? onPressed;
  final bool enabled;
  const ActionSheetTitle({super.key, required this.title,
    this.onPressed, this.enabled = false,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CupxSheetTitle(
          title: const SizedBox.shrink(),
          leading: CupxSheetTitleCloseButton(),
          trailing: Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: TextButtonx(
            size: Sizex.custom, type: ButtonxType.primary, child: 'Done',
            onPressed: onPressed, enabled: enabled,
            buttonSize: smallCompact().copyWith(borderRadius: BorderRadius.circular(10)),
          ),)
      ),
      Positioned(child: SizedBox(height: 34,
        child: Center(
          child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text17500, textAlign: TextAlign.center,),
        ),
      ))
    ],);
  }
}

class PlainSheetTitle extends StatelessWidget {
  final String title;
  const PlainSheetTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) { //16 4+title+4  12 30 16 => 16 4+title+4 8 4+30+4 12
    return Container(height: 42,
      padding: EdgeInsets.only(left: 16, right: 12, top: 0,),
      child: Row(children: [
        Expanded(child: Padding(padding: EdgeInsets.all(4),
          child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text17500,),
        )),
        const SizedBox(width: 8,),
        CupxSheetTitleCloseButton(),
      ],),
    );
  }
}

class CenteredSheetTitle extends StatelessWidget {
  final String title;
  const CenteredSheetTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return CupxSheetTitle(
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text17500, textAlign: TextAlign.center,),
      leading: PaddedSvgIcon(Svgicons.arrow_left, onTap: () => Navigator.pop(context),),
      trailing: const SizedBox(width: 28,)
    );
  }
}


class CupxSheetTitle extends StatelessWidget {

  final Widget title;
  final Widget leading;
  final Widget trailing;

  const CupxSheetTitle({super.key,
    required this.title,
    required this.leading,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(height: 34 + 2 + 12, padding: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 12),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          leading,
          Expanded(child: title),
          trailing,
        ],),
      )
    );
  }

}

///
class CupxSheetTitleCloseButton extends StatelessWidget {

  const CupxSheetTitleCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    Widget close = InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: Container(
        width: 30, height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            color: AppTheme.black4
        ),
        child: SvgPicture.asset(Svgicons.x, fit: BoxFit.none,),
      ),),
    );
    return close;
  }

}