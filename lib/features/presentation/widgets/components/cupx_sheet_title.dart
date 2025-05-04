

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_button.dart';
import 'package:follow_read/theme/text_styles.dart';

class CupxSheetTitle extends StatefulWidget {

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final double? height;

  const CupxSheetTitle({super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.color = Colors.transparent,
    this.height = 44,
  });

  @override
  State<CupxSheetTitle> createState() => _CupxSheetTitleState();

  factory CupxSheetTitle.closeButton({
    required String title,
    Widget? leading,
    Color? color,
    double? height,
    bool left = true, bool right = false,
  }){
    return CupxSheetTitle(
      leading: left ? leading ?? CupxSheetTitleCloseButton() : null,
      title: title,
      trailing: right ? leading ?? CupxSheetTitleCloseButton() : null,
      color: color, height: height,
    );
  }

  factory CupxSheetTitle.button(BuildContext context, {
    required String title,
    required CupxButton button,
    Widget? leading,
    Color? color,
    double? height,
  }) {
    return CupxSheetTitle(
      color: color, height: height,
      title: title,
      leading: leading ?? ChevronLeftCloseButton(),
      trailing: button,
    );
  }
}

class _CupxSheetTitleState extends State<CupxSheetTitle> {

  final GlobalKey _leadingKey = GlobalKey();
  final GlobalKey _trailingKey = GlobalKey();

  double _leadingWidth = 0;
  double _trailingWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  @override
  void didUpdateWidget(covariant CupxSheetTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  void _measure() {
    final RenderBox? box1 = _leadingKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? box2 = _trailingKey.currentContext?.findRenderObject() as RenderBox?;

    final newLeadingWidth = box1?.size.width ?? 0;
    final newTrailingWidth = box2?.size.width ?? 0;

    if (newLeadingWidth != _leadingWidth || newTrailingWidth != _trailingWidth) {
      setState(() {
        _leadingWidth = newLeadingWidth;
        _trailingWidth = newTrailingWidth;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 没有 leading 的情况：不做居中处理
    final bool shouldCenter = widget.leading != null;

    final double leftGap = shouldCenter
        ? (_trailingWidth - _leadingWidth).clamp(0, double.infinity)
        : 0;
    final double rightGap = shouldCenter
        ? (_leadingWidth - _trailingWidth).clamp(0, double.infinity)
        : 0;

    return SafeArea(
      bottom: false,
      child: Container(
        color: widget.color, height: widget.height,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(width: 12,),
          const SizedBox(width: 4,),

          if (widget.leading case final Widget leading) ...<Widget>[
            KeyedSubtree(key: _leadingKey, child: leading),
            const SizedBox(width: 4,),
          ],

          if (leftGap > 0) SizedBox(width: leftGap),

          Expanded(child: Text(widget.title,
            maxLines: 1, overflow: TextOverflow.ellipsis,
            style: AppTextStyles.text17500,
            textAlign: shouldCenter ? TextAlign.center : TextAlign.start,
          )),

          if (rightGap > 0) SizedBox(width: rightGap),

          if (widget.trailing case final Widget trailing) ...<Widget>[
            const SizedBox(width: 4,),
            KeyedSubtree(key: _trailingKey, child: trailing),
            const SizedBox(width: 4,),
          ],
          const SizedBox(width: 12,)
        ],),
      )
    );
  }

}

class CupxSheetTitleCloseButton extends StatelessWidget {

  const CupxSheetTitleCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    Widget close = InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        width: 30, height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            color: AppTheme.black4
        ),
        child: SvgPicture.asset(Svgicons.x, width: 20, height: 20, fit: BoxFit.none,),
      ),
    );
    return close;
  }

}


class ChevronLeftCloseButton extends StatelessWidget {

  const ChevronLeftCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: SvgPicture.asset(Svgicons.arrowLeft, width: 24, height: 24,),
    );
  }

}