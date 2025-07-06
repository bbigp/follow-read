

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:follow_read/global/widgets/tickbox.dart';

class TickboxListTile extends StatefulWidget {


  final ValueChanged<String>? onChanged;
  final Widget title;
  final bool tristate;
  final String value;


  const TickboxListTile({super.key,
    required this.title,
    required this.value,
    this.tristate = false,
    this.onChanged,
  });
  @override
  State<TickboxListTile> createState() => _TickboxListTileState();
}

class _TickboxListTileState extends State<TickboxListTile> {

  bool _tristate = false;

  @override
  void initState() {
    super.initState();
    _tristate = widget.tristate;
  }

  @override
  void didUpdateWidget(covariant TickboxListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tristate != widget.tristate) {
      setState(() {
        _tristate = widget.tristate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
      HapticFeedback.mediumImpact();
      widget.onChanged?.call(widget.value);
      setState(() {
        _tristate = !_tristate;
      });
    }, child: Row(
      children: [
        const SizedBox(width: 16, height: 52,),
        Tickbox(value: widget.value, tristate: _tristate,),
        const SizedBox(width: 12,),
        const SizedBox(width: 4,),
        Expanded(child: widget.title),
        const SizedBox(width: 16,),
      ],
    ),);
  }


}