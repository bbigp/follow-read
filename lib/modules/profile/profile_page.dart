

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/cupx_list_tile_chevron.dart';
import 'package:follow_read/global/widgets/cupx_sheet_title.dart';
import 'package:follow_read/global/widgets/menux.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/modules/folder_picker/folder_picker.dart';
import 'package:follow_read/modules/home/home_controller.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {

  final GlobalKey _unreadMarkKey = new GlobalKey();
  final GlobalKey _openContentKey = new GlobalKey();
  final GlobalKey _rootFolderKey = new GlobalKey();

  final controller = Get.find<ProfileController>();
  final homePage = Get.find<HomeController>();

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

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final unreadMarkView = Obx((){
      return RadioPopupMenu(
        menus: buildIconMenu({
          UnreadMark.none.asString: SvgIcons.ban,
          UnreadMark.dot.asString: SvgIcons.dot_m,
          UnreadMark.number.asString: SvgIcons.notification_num,
        }, (v) {
          controller.change(unreadMark: v);
        }),
        groupValue: controller.state.user.unreadMark.asString,
      );
    });

    final openContentView = Obx(() {
      return RadioPopupMenu(
        menus: buildMenu([User.OPEN_CONTENT_VIEW, User.OPEN_CONTENT_WEBVIEW, User.OPEN_CONTENT_BROWSER], (v) {
          controller.change(openContent: v);
        }),
        groupValue: controller.state.user.openContent,
      );
    });


    return Scaffold(
        appBar: CenteredSheetTitleBar(color: AppColors.black04, title: '设置',),
        body: Container(
          color: AppColors.black04,
          child: CustomScrollView(
            slivers: [
              // SliverToBoxAdapter(child: SizedBox(height: 8,),),
              SliverToBoxAdapter(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16), child: CardView(
                  padding: EdgeInsets.zero,
                  child: Column(children: [
                    Obx((){
                      return ListTilexChevronUpDown(key: _unreadMarkKey, icon: SvgIcons.unread_dashed,
                        title: "Unread Mark",
                        additionalInfo: controller.state.user.unreadMark.asString,
                        onTap: () => Open.menu(context, _unreadMarkKey, unreadMarkView),
                      );
                    }),
                    Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12,), child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),),
                    Obx((){
                      return ListTilexChevronUpDown(key: _openContentKey, icon: SvgIcons.page,
                        title: "Open Content with",
                        additionalInfo: controller.state.user.openContent,
                        onTap: () => Open.menu(context, _openContentKey, openContentView),
                      );
                    }),
                    Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12,), child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),),
                    Obx((){
                      return ListTilexSwitch(title: "Auto Mark Read", value: controller.state.user.autoRead,
                        icon: SvgIcons.book, onChanged: (v) {
                          controller.change(autoRead: v);
                      },);
                    }),
                    Obx((){
                      return ListTilexChevronUpDown(icon: SvgIcons.folder_1,
                        title: "Root Folder",
                        additionalInfo: controller.state.rootFolder.title,
                        onTap: () => Open.modal(context, FolderPicker(
                          sheetTitle: "根文件夹", value: controller.state.rootFolder.title,
                          onChanged: (v) async {
                            await controller.change(rootFolderId: v);
                            await homePage.loadHomeData(loadAll: true);
                          },
                        )),
                      );
                    }),
                  ],)
              ),),),

              SliverToBoxAdapter(child: SizedBox(height: 24,),),


              // SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: CardView(
              //     child: Column(children: [
              //       ListTilexChevronUpDown(icon: Svgicons.page, title: "服务器地址",),
              //       Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12,), child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),),
              //       ListTilexChevron(title: "https://feedo.coolbet.cn/",),
              //     ],)
              // ),),),
              // SliverToBoxAdapter(child: SizedBox(height: 24,),),


              SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text("当前服务器地址", maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.M11B25,),
              ),),
              SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: CardView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Column(children: [
                    Obx((){
                      return ListTilexText(title: controller.state.user.baseUrl);
                    }),
                    SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),
                    Obx((){
                      return ListTilexText(title: controller.state.user.token);
                    })
                  ],)
              ),),),
              SliverToBoxAdapter(child: SizedBox(height: 24,),),


              SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: CardView(
                padding: EdgeInsets.zero,
                child: Column(children: [
                  ListTilexChevron(title: "订阅同步", onTap: () => Get.offNamed(RouteConfig.sync),)
                ],),
              ))),


              // SliverToBoxAdapter(child: Container(
              //   margin: EdgeInsets.symmetric(horizontal: 16,),
              //   padding: EdgeInsets.symmetric(vertical: 4),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(16),
              //     color: Colors.white,
              //   ),
              //   child: Column(children: [




                  // CupxListTile.chevronUpDown(
                  //   icon: Svgicons.book,
                  //   title: '服务器URL',
                  //   onTap: () {
                  //     OpenModal.open(context, ServerPicker());
                  //   },
                  // ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 16 + 24 + 12, right: 12),
                  //   child: SpacerDivider(
                  //     thickness: 0.5, spacing: 1, indent: 0,),
                  // ),
                  // CupxListTile.chevron(
                  //     icon: SvgIcons.ban, title: '令牌'
                  // ),
                // ],),
              // ),),
              // SliverToBoxAdapter(child: SizedBox(height: 24,),),
              // SliverToBoxAdapter(child: PreferencePanel(
              //   items: [
              //     SwitchItem(icon: SvgIcons.markRead, label: '自动已读',
              //         value: userAsync.requireValue.autoRead,
              //         onChanged: (v) => ref.read(userProvider.notifier).saveConf(autoRead: v)
              //     ),
              //     SwitchItem(icon: Svgicons.ban, label: '显示全部Feed',
              //         value: userAsync.requireValue.showAll,
              //         onChanged: (v) => ref.read(userProvider.notifier).saveConf(showAll: v)
              //     ),
              //   ],
              // ))
            ],
          ),
        )
    );

  }

}