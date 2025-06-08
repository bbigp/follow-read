

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/modules/controller/add_artiad/add_artiad_controller.dart';
import 'package:follow_read/modules/widgets/acx/card_viewx.dart';
import 'package:follow_read/modules/widgets/acx/cupx_list_tile_chevron.dart';
import 'package:follow_read/modules/widgets/acx/floating_menu.dart';
import 'package:follow_read/modules/widgets/acx/menux.dart';
import 'package:follow_read/modules/widgets/acx/spacer_divider.dart';
import 'package:follow_read/modules/widgets/artiad/status_picker.dart';
import 'package:follow_read/modules/widgets/feed/feed_picker.dart';
import 'package:follow_read/service/open.dart';
import 'package:follow_read/theme/text_styles.dart';
import 'package:get/get.dart';


class AdvancedView extends ConsumerWidget {

  final AddArtiadController addArtiad;
  AdvancedView({super.key, required this.addArtiad});
  final GlobalKey _releaseTimeKey = GlobalKey();
  final GlobalKey _addTimeKey = GlobalKey();
  final String typeReleaseTime = "releaseTime";
  final String typeAddTime = "addTime";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Obx((){
      final feedIds = addArtiad.state.feedIds;
      final releaseTime = addArtiad.state.releaseTime;
      final addTime = addArtiad.state.addTime;
      final statuses = addArtiad.state.statuses;
      final List<ConditionItem> items = [
        ConditionItem(
          widget: ListTilexChevronUpDown(
            icon: Svgicons.square_rss,
            title: '订阅源',
            additionalInfo: feedIds.isEmpty ? 'Off' : feedIds.join(","),
            onTap: () => Open.modal(context, FeedPicker()),
          ),
          isSelected: feedIds.isNotEmpty,
        ),
        ConditionItem(
          widget: ListTilexChevronUpDown(
            key: _releaseTimeKey,
            icon: Svgicons.calendar_today,
            title: "发布时间",
            additionalInfo: addArtiad.state.timeMap[releaseTime] ?? 'Off',
            onTap: () => Open.menu(context, Menux(menus: buildTimeMenu(addArtiad, typeReleaseTime)), _releaseTimeKey),
          ),
          isSelected: releaseTime > 0,
        ),
        ConditionItem(
          widget: ListTilexChevronUpDown(
            key: _addTimeKey,
            icon: Svgicons.calendar_today,
            title: "添加时间",
            additionalInfo: addArtiad.state.timeMap[addTime] ?? 'Off',
            onTap: () => Open.menu(context, Menux(menus: buildTimeMenu(addArtiad, typeAddTime)), _addTimeKey),
          ),
          isSelected: addTime > 0,
        ),
        ConditionItem(
          widget: ListTilexChevronUpDown(
            icon: Svgicons.calendar_today,
            title: "已读未读",
            additionalInfo: statuses.isEmpty ? 'Off' : statuses.join(","),
            onTap: () => Open.modal(context, StatusPicker(addArtiad: addArtiad,)),
          ),
          isSelected: statuses.isNotEmpty,
        ),
      ];
      final List<List<ConditionItem>> groups = _groupConditions(items);

      return Column(
        children: [
          const SizedBox(height: 4,),
          ...groups.map((group) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: CardView(
                child: Column(
                  children: _buildGroupWithDivider(group),
                ),
              ),
            );
          }),
          //自定义规则以自动收集和筛选内容，但之后无法手动添加内容。
          Padding(padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8), 
            child: Align(
              alignment: Alignment.center,
              child: Text('自定义规则以自动收集和筛选内容', textAlign: TextAlign.left, style: AppTextStyles.caption13,),
            ),
          )
        ],
      );
    });
  }

}

class ConditionItem {
  final Widget widget;
  final bool isSelected;
  ConditionItem({required this.widget, required this.isSelected});
}

extension AdvancedViewExtension on AdvancedView {
  List<Widget> _buildGroupWithDivider(List<ConditionItem> group) {
    final List<Widget> widgets = [];
    for (int i = 0; i < group.length; i++) {
      widgets.add(group[i].widget);
      if (i != group.length - 1) {
        widgets.add(const Padding(
          padding: EdgeInsets.only(left: 16 + 24 + 12, right: 12),
          child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),)
        );
      }
    }
    return widgets;
  }

  List<List<ConditionItem>> _groupConditions(List<ConditionItem> items) {
    final List<List<ConditionItem>> result = [];
    List<ConditionItem> currentGroup = [];

    for (final item in items) {
      if (item.isSelected) {
        if (currentGroup.isNotEmpty) {
          result.add(currentGroup);
          currentGroup = [];
        }
        result.add([item]); // 单独放一个选中的
      } else {
        currentGroup.add(item);
      }
    }
    if (currentGroup.isNotEmpty) {
      result.add(currentGroup);
    }

    return result;
  }


  List<Widget> buildTimeMenu(AddArtiadController addArtiad, String field) {
    final state = addArtiad.state;
    final groupValue = field == typeReleaseTime ? state.releaseTime : state.addTime;
    final widgets = addArtiad.state.timeMap.entries.expand((item) {
      final key = item.key;
      final text = item.value;

      return [
        RadioMenuItem(
          title: text,
          value: key.toString(),
          groupValue: groupValue.toString(), // 当前选中的 value
          onTap: () {
            if (field == typeReleaseTime) {
              addArtiad.change(releaseTime: key);
            } else {
              addArtiad.change(addTime: key);
            }
            FloatingMenu.hide();
          },
        ),
        const MenuDivider(),
      ];
    }).toList();
    if (widgets.isNotEmpty) {
      widgets.removeLast();
    }

    return widgets;
  }




}