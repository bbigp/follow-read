

import 'package:flutter/material.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/modules/controller/add_artiad/add_artiad_controller.dart';
import 'package:follow_read/modules/widgets/acx/buttonx.dart';
import 'package:follow_read/modules/widgets/acx/card_tickbox_list_tile.dart';
import 'package:follow_read/modules/widgets/acx/cupx_sheet_title.dart';
import 'package:follow_read/modules/widgets/acx/drag_handle.dart';

class StatusPicker extends StatefulWidget {
  final AddArtiadController addArtiad;
  const StatusPicker({super.key, required this.addArtiad});

  @override
  State<StatusPicker> createState() => _StatusPickerState();
}

class _StatusPickerState extends State<StatusPicker> {
  Set<String> selectedStatuses = <String>{};

  @override
  void initState() {
    super.initState();
    selectedStatuses = Set.from(widget.addArtiad.state.statuses);
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
      _buildTile('未读', 'unread', Svgicons.unread),
      _buildTile('已读', 'read', Svgicons.check_o),
      _buildTile('删除', 'remove', Svgicons.trash),

      Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: TextButtonx(child: 'Done', size: Sizex.large, enabled: selectedStatuses.isNotEmpty,
          onPressed: () async {
            widget.addArtiad.change(statuses: selectedStatuses.toList());
            Navigator.pop(context);
          },
        ),
      ),
      const SizedBox(height: 8,)
    ],);
  }

}


