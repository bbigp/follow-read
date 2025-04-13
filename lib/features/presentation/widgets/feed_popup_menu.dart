import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';

class FeedPopupMenu {
  static void show({
    required BuildContext context,
    required Offset position,
    required String selected,
    required Function(String) onSelected,
    double width = 180,
    List<String> items = const ['Off', 'Custom'],
  }) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(position.dx, position.dy, 0, 0),
        Offset.zero & overlay.size,
      ),
      color: AppTheme.white95,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppTheme.black4, width: 1),
      ),
      items: _buildMenuItems(items, selected, width),
    ).then((value) {
      if (value != null) onSelected(value);
    });
  }

  static List<PopupMenuEntry<String>> _buildMenuItems(List<String> items, String selected, double width) {
    List<PopupMenuEntry<String>> list = [];
    for (int i = 0; i < items.length; i++) {
      list.add(CustomPopupMenuItem(value: items[i], selected: selected, width: width));
      if (i != items.length - 1) {
        list.add(PopupMenuDivider());
      }
    }
    return list;
  }
}

class CustomPopupMenuItem extends PopupMenuEntry<String> {
  final String value;
  final String selected;
  final double _height = 36;
  final double width;

  const CustomPopupMenuItem({
    super.key,
    required this.value,
    required this.selected,
    this.width = 100,
  });

  @override
  double get height => _height;

  @override
  bool represents(String? val) => value == val;

  @override
  State<StatefulWidget> createState() => _CustomPopupMenuItemState();
}

class _CustomPopupMenuItemState extends State<CustomPopupMenuItem> {
  @override
  Widget build(BuildContext context) {
    final isSelected = widget.value == widget.selected;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context, widget.value);
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            isSelected
                ? SvgPicture.asset(Svgicons.check, width: 20, height: 20)
                : SizedBox(width: 20, height: 20),
            SizedBox(width: 8),
            Expanded(child: Text(
              widget.value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.33,
                color: AppTheme.black95,
              ),
            ),),
          ],
        ),
      ),
    );
  }
}

class PopupMenuDivider extends PopupMenuEntry<String> {
  final double size;

  const PopupMenuDivider({super.key, this.size = 1});

  @override
  double get height => size;

  @override
  bool represents(String? value) => false;

  @override
  State<StatefulWidget> createState() => _PopupMenuDividerState();
}

class _PopupMenuDividerState extends State<PopupMenuDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      color: AppTheme.black8,
    );
  }
}
