

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/providers/user_provider.dart';
import 'package:follow_read/modules/widgets/acx/card_viewx.dart';
import 'package:follow_read/modules/widgets/acx/cupx_list_tile.dart';
import 'package:follow_read/modules/widgets/acx/cupx_list_tile_chevron.dart';
import 'package:follow_read/modules/widgets/acx/cupx_sheet_title.dart';
import 'package:follow_read/modules/widgets/acx/menux.dart';
import 'package:follow_read/modules/widgets/acx/spacer_divider.dart';
import 'package:follow_read/modules/widgets/me/me.dart';
import 'package:follow_read/modules/widgets/open_modal.dart';
import 'package:follow_read/modules/widgets/preference_panel.dart';
import 'package:follow_read/modules/widgets/server_picker.dart';
import 'package:follow_read/service/open.dart';


class GeneralPage extends ConsumerStatefulWidget {

  const GeneralPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GeneralPageState();

}

class _GeneralPageState extends ConsumerState<GeneralPage> {
  final GlobalKey _unreadMarkKey = new GlobalKey();
  final GlobalKey _openContentKey = new GlobalKey();

  List<MenuData> buildIconMenu(Map<String, String> menuValues, void Function(String) onTap) {
    return menuValues.entries.map((item) {
      final key = item.key;
      final icon = item.value;
      return MenuData(value: key, text: key, icon: icon,onTap: (){
        onTap(key);
      });
    }).toList();
  }

  List<MenuData> buildMenu(List<String> menuValues, void Function(String) onTap) {
    return menuValues.map((item) {
      final key = item;
      return MenuData(value: key, text: key, onTap: (){
        onTap(key);
      });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);

    final unreadMarkView = RadioPopupMenu(
      menus: buildIconMenu({
        'None': Svgicons.ban,
        'Dot': Svgicons.dot_m,
        'Number': Svgicons.notification_num,
      }, (v) => null),
      groupValue: 'None',
    );

    final openContentView = RadioPopupMenu(
      menus: buildMenu(['内置阅读器', '应用内浏览器', '系统浏览器'], (v) => null),
      groupValue: '内置阅读器',
    );


    return Scaffold(
        appBar: CenteredSheetTitleBar(color: AppTheme.black4, title: '设置',),
        body: userAsync.isLoading ? SizedBox.shrink() : Container(
          color: AppTheme.black4,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 8,),),
              SliverToBoxAdapter(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16), child: CardView(
                  child: Column(children: [
                    ListTilexChevronUpDown(key: _unreadMarkKey, icon: Svgicons.unread_dashed,
                      title: "未读标记",
                      additionalInfo: "None",
                      onTap: () => Open.menu(context, _unreadMarkKey, unreadMarkView),
                    ),
                    Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12,), child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),),
                    ListTilexSwitch(title: "自动已读", icon: Svgicons.book, onChanged: (v) {

                    },),
                    Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12,), child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),),
                    ListTilexChevronUpDown(key: _openContentKey, icon: Svgicons.page,
                      title: "内容打开方式",
                      additionalInfo: "内置阅读器",
                      onTap: () => Open.menu(context, _openContentKey, openContentView),
                    ),
                  ],)
              ),),),

              SliverToBoxAdapter(child: SizedBox(height: 24,),),
              SliverToBoxAdapter(child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16,),
                padding: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Column(children: [




                  CupxListTile.chevronUpDown(
                      icon: Svgicons.book,
                      title: '服务器URL',
                      onTap: () {
                        OpenModal.open(context, ServerPicker());
                      },
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16 + 24 + 12, right: 12),
                    child: SpacerDivider(
                      thickness: 0.5, spacing: 1, indent: 0,),
                  ),
                  CupxListTile.chevron(
                      icon: Svgicons.ban, title: '令牌'
                  ),
                ],),
              ),),
              SliverToBoxAdapter(child: SizedBox(height: 24,),),
              SliverToBoxAdapter(child: PreferencePanel(
                items: [
                  SwitchItem(icon: Svgicons.markRead, label: '自动已读',
                      value: userAsync.requireValue.autoRead,
                      onChanged: (v) => ref.read(userProvider.notifier).saveConf(autoRead: v)
                  ),
                  SwitchItem(icon: Svgicons.ban, label: '显示全部Feed',
                      value: userAsync.requireValue.showAll,
                      onChanged: (v) => ref.read(userProvider.notifier).saveConf(showAll: v)
                  ),
                ],
              ))
            ],
          ),
        )
    );
  }


}
