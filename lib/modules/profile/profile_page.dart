

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
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/modules/folder_picker/folder_picker.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {

  final GlobalKey _unreadMarkKey = new GlobalKey();
  final GlobalKey _openContentKey = new GlobalKey();
  final GlobalKey _rootFolderKey = new GlobalKey();

  final controller = Get.find<ProfileController>();

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
        menus: buildMenu(['内置阅读器', '应用内浏览器', '系统浏览器'], (v) {
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
                  child: Column(children: [
                    Obx((){
                      return ListTilexChevronUpDown(key: _unreadMarkKey, icon: SvgIcons.unread_dashed,
                        title: "未读标记",
                        additionalInfo: controller.state.user.unreadMark.asString,
                        onTap: () => Open.menu(context, _unreadMarkKey, unreadMarkView),
                      );
                    }),
                    Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12,), child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),),
                    Obx((){
                      return ListTilexSwitch(title: "自动已读", value: controller.state.user.autoRead,
                        icon: SvgIcons.book, onChanged: (v) {
                          controller.change(autoRead: v);
                      },);
                    }),
                    Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12,), child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),),
                    Obx((){
                      return ListTilexChevronUpDown(key: _openContentKey, icon: SvgIcons.page,
                        title: "内容打开方式",
                        additionalInfo: controller.state.user.openContent,
                        onTap: () => Open.menu(context, _openContentKey, openContentView),
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
                  child: Column(children: [
                    Row(children: [
                      const SizedBox(width: 16, height: 48,),
                      SvgPicture.asset(SvgIcons.check_fill, width: 24, height: 24, fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(Colors.green, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 12,),
                      Expanded(
                        child: Obx(() {
                          return Text(controller.state.user.baseUrl, maxLines: 3,
                            overflow: TextOverflow.ellipsis, style: AppTextStyles.text,
                            textAlign: TextAlign.center,
                          );
                        })
                      ),
                      const SizedBox(width: 16,),
                    ],),
                    Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12,), child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),),
                    Obx((){
                      return ListTilex(
                        icon: SvgPicture.asset(SvgIcons.page, width: 24, height: 24, fit: BoxFit.contain,
                          colorFilter: ColorFilter.mode(AppColors.black50, BlendMode.srcIn
                        ),
                      ), title: "令牌",
                        additionalInfo: controller.state.user.token,
                      );
                    })
                  ],)
              ),),),
              SliverToBoxAdapter(child: SizedBox(height: 24,),),


              SliverToBoxAdapter(child: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: CardView(
                child: Column(children: [
                  Obx((){
                    return ListTilexChevronUpDown(icon: SvgIcons.folder_1,
                      title: "根文件夹",
                      additionalInfo: controller.state.rootFolder.title,
                      onTap: () => Open.modal(context, FolderPicker(
                        sheetTitle: "根文件夹", value: controller.state.rootFolder.title,
                        onChanged: (v) => controller.change(rootFolderId: v),
                      )),
                    );
                  }),
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