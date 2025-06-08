
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/modules/widgets/acx/card_viewx.dart';
import 'package:follow_read/modules/widgets/acx/tickbox.dart';
import 'package:follow_read/theme/text_styles.dart';

class CardTickboxListTile extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String title;
  final String icon;
  final bool tristate;
  final String value;
  const CardTickboxListTile({super.key, required this.title,
    required this.value,
    required this.icon,
    this.tristate = false,
    this.onChanged,});
  @override
  State<CardTickboxListTile> createState() => _CardTickboxListTileState();
}

class _CardTickboxListTileState extends State<CardTickboxListTile> {

  bool _tristate = false;

  @override
  void initState() {
    super.initState();
    _tristate = widget.tristate;
  }

  @override
  void didUpdateWidget(covariant CardTickboxListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tristate != widget.tristate) {
      setState(() {
        _tristate = widget.tristate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = CardView(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      borderRadius: 99,
      border: Border.all(color: AppTheme.black95, width: 1.5),
      child: Padding(padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(children: [
          const SizedBox(width: 4,),
          SvgPicture.asset(widget.icon, width: 24, height: 24, fit: BoxFit.contain,),

          const SizedBox(width: 8,),
          Expanded(child: Text(widget.title, textAlign: TextAlign.center,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text500)
          ),
          const SizedBox(width: 4,),
          const SizedBox(width: 4,),

          Tickbox(value: widget.value, tristate: _tristate, onChanged: widget.onChanged,),
        ],),
      ),
    );
    return GestureDetector(onTap: (){
      HapticFeedback.mediumImpact();
      widget.onChanged?.call(widget.value);
      setState(() {
        _tristate = !_tristate;
      });
    }, child: child,);
  }
}
