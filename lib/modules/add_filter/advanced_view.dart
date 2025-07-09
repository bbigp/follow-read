

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/global/widgets/cupx_list_tile_chevron.dart';
import 'package:follow_read/global/widgets/menux.dart';
import 'package:follow_read/global/widgets/modal_wrapper.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/modules/add_filter/add_filter_controller.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/modules/feed_picker/feed_picker.dart';
import 'package:follow_read/modules/add_filter/advanced_tile.dart';
import 'package:follow_read/modules/feed_picker/feed_picker_controller.dart';
import 'package:get/get.dart';


class AdvancedView extends ConsumerWidget {

  final AddFilterController controller;
  AdvancedView({super.key, required this.controller});
  final GlobalKey _releaseTimeKey = GlobalKey();
  final GlobalKey _addTimeKey = GlobalKey();
  final GlobalKey _feedKey = GlobalKey();
  final GlobalKey _statusKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Obx((){
      final feedIds = controller.state.feedIds;
      final releaseTime = controller.state.releaseTime;
      final addTime = controller.state.addTime;
      final statuses = controller.state.statuses;

      final releaseTimeMenu = RadioPopupMenu(
        menus: buildTimeMenu(controller.state.timeMap, (v) => controller.change(releaseTime: v),),
        groupValue: releaseTime.toString(),
      );
      final addTimeMenu = RadioPopupMenu(
        menus: buildTimeMenu(controller.state.timeMap, (v) => controller.change(addTime: v),),
        groupValue: addTime.toString(),
      );

      final List<SelectableInterface> items = [
        AdvancedTile(icon: SvgIcons.square_rss, title: '订阅源', localKey: _feedKey,
          selectedContent: feedIds.join(","),
          isSelected: feedIds.isNotEmpty,
          openTickboxTap: () => Open.modal(context, GetModalWrapper(
            initControllers: (){
              Get.put(FeedPickerController(initialFeeds: []));
            },
            disposeControllers: () {
              Get.delete<FeedPickerController>();
            },
            builder: () => FeedPicker(),
          )),
          clearTap: () => controller.change(feedIds: []),
        ),
        SelectableWidget(isSelected: releaseTime > 0, child: ListTilexChevronUpDown(
          key: _releaseTimeKey,
          icon: SvgIcons.calendar_today,
          title: "发布时间",
          additionalInfo: controller.state.timeMap[releaseTime] ?? 'Off',
          onTap: () => Open.menu(context, _releaseTimeKey, releaseTimeMenu),
        ),),
        SelectableWidget(isSelected: addTime > 0, child: ListTilexChevronUpDown(
          key: _addTimeKey,
          icon: SvgIcons.calendar_today,
          title: "添加时间",
          additionalInfo: controller.state.timeMap[addTime] ?? 'Off',
          onTap: () => Open.menu(context, _addTimeKey, addTimeMenu),
        ),),
        // AdvancedTile(
        //   icon: SvgIcons.calendar_today,
        //   title: '已读未读',
        //   selectedContent: statuses.join(","),
        //   localKey: _statusKey,
        //   isSelected: statuses.isNotEmpty,
        //   openTickboxTap: () => Open.modal(context, StatusPicker(addArtiad: addArtiad,)),
        //   clearTap: () => addArtiad.change(statuses: []),
        // ),
      ];
      final List<List<SelectableInterface>> groups = _groupConditions(items);

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
              child: Text('自定义规则以自动收集和筛选内容', textAlign: TextAlign.left, style: AppTextStyles.R13B50,),
            ),
          )
        ],
      );
    });
  }

}


extension AdvancedViewExtension on AdvancedView {
  List<Widget> _buildGroupWithDivider(List<SelectableInterface> group) {
    final List<Widget> widgets = [];
    for (int i = 0; i < group.length; i++) {
      widgets.add(group[i] as Widget);
      if (i != group.length - 1) {
        widgets.add(const Padding(
          padding: EdgeInsets.only(left: 16 + 24 + 12, right: 12),
          child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),)
        );
      }
    }
    return widgets;
  }

  List<List<SelectableInterface>> _groupConditions(List<SelectableInterface> items) {
    final List<List<SelectableInterface>> result = [];
    List<SelectableInterface> currentGroup = [];

    for (final item in items) {
      currentGroup.add(item);
      if (item.hasSelection) {
        result.add(currentGroup);
        currentGroup = [];
      }
    }
    if (currentGroup.isNotEmpty) {
      result.add(currentGroup);
    }

    // for (final item in items) {
    //   if (item.hasSelection) {
    //     if (currentGroup.isNotEmpty) {
    //       result.add(currentGroup);
    //       currentGroup = [];
    //     }
    //     result.add([item]); // 单独放一个选中的
    //   } else {
    //     currentGroup.add(item);
    //   }
    // }
    // if (currentGroup.isNotEmpty) {
    //   result.add(currentGroup);
    // }
    return result;
  }

  List<MenuData> buildTimeMenu(Map<int, String> timeMap, void Function(int) onTap) {
    return timeMap.entries.map((item) {
      final key = item.key;
      final text = item.value;
      return MenuData(value: key.toString(), text: text, onTap: (){
        onTap(key);
      });
    }).toList();
  }




}