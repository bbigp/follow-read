

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/global/widgets/card_tickbox_list_tile.dart';
import 'package:follow_read/global/widgets/cupx_sheet_title.dart';
import 'package:follow_read/modules/controller/add_artiad/add_artiad_controller.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/drag_handle.dart';
import 'package:get/get.dart';

import 'add_filter_controller.dart';

class StatusPicker extends StatefulWidget {
  final AddFilterController controller;
  const StatusPicker({super.key, required this.controller});

  @override
  State<StatusPicker> createState() => _StatusPickerState();
}

class _StatusPickerState extends State<StatusPicker> {
  Set<String> selectedStatuses = <String>{};

  @override
  void initState() {
    super.initState();
    selectedStatuses = Set.from(widget.controller.state.statuses);
  }

  void _onChanged(String value) {
    setState(() {
      if (selectedStatuses.contains(value)) {
        selectedStatuses.remove(value);
      } else {
        selectedStatuses.add(value);
      }
    });
  }

  Widget _buildTile(String title, String value, String icon) {
    return CardTickboxListTile(
      title: title,
      value: value,
      icon: icon,
      tristate: selectedStatuses.contains(value),
      onChanged: (_) => _onChanged(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SheetGrabber(),
      const PlainSheetTitle(title: '选择状态'),

      const SizedBox(height: 4,),
      _buildTile('未读', 'unread', SvgIcons.unread),
      _buildTile('已读', 'read', SvgIcons.check_o),
      _buildTile('删除', 'remove', SvgIcons.trash),

      Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: TextButtonx(child: 'Done', size: Sizex.large, enabled: selectedStatuses.isNotEmpty,
          onPressed: () async {
            widget.controller.change(statuses: selectedStatuses.toList());
            Get.back();
          },
        ),
      ),
      const SizedBox(height: 8,)
    ],);
  }

}


