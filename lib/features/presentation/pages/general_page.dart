

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/widgets/modal_tile.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:follow_read/features/presentation/widgets/switch_tile.dart';
import 'package:path/path.dart';

import '../../../config/svgicons.dart';
import '../providers/user_provider.dart';
import '../widgets/open_modal.dart';

class GeneralPage extends ConsumerStatefulWidget {

  const GeneralPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GeneralPageState();

}

class _GeneralPageState extends ConsumerState<GeneralPage> {

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.black4,
        elevation: 0,
        title: Text('设置', style: TextStyle(
          fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppTheme.black95,
        ),),
      ),
      body: userAsync.isLoading ? SizedBox.shrink() : Container(
        color: AppTheme.black4,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 8,),),
            SliverToBoxAdapter(child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16,),
              padding: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(children: [
                ModalTile(Svgicons.book, '服务器URL', onTap: () {
                  OpenModal.open(context, _buildSelectUrl(context));
                }),
                Container(
                  padding: EdgeInsets.only(left: 16+24+12, right: 12),
                  child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),
                ),
                Row(
                  children: [
                    SizedBox(width: 16, height: 36,),
                    SvgPicture.asset(Svgicons.ban, width: 24, height: 24,),
                    SizedBox(width: 12,),
                    Expanded(child: Text('令牌', style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
                    ),)),
                    SizedBox(width: 4,),
                    SvgPicture.asset(Svgicons.chevronRight, width: 20, height: 20,),
                    SizedBox(width: 12,),
                  ],
                ),
              ],),
            ),),
            SliverToBoxAdapter(child: SizedBox(height: 24,),),
            SliverToBoxAdapter(child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16,),
              padding: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(children: [
                SwitchTile(Svgicons.markRead, '自动已读', open: userAsync.requireValue.autoRead,
                    onChanged: (v) {
                  ref.read(userProvider.notifier).saveConf(autoRead: v);
                }),
                Container(
                  padding: EdgeInsets.only(left: 16+24+12, right: 12),
                  child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),
                ),
                SwitchTile(Svgicons.ban, '显示隐藏', open: userAsync.requireValue.showHide,
                    onChanged: (v) {
                      ref.read(userProvider.notifier).saveConf(showHide: v);
                }),
              ],),
            ),)
          ],
        ),
      )
    );
  }

  Widget _buildSelectUrl(BuildContext context){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Text('选择服务器URL', maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppTheme.black95,
            ),)),
            SizedBox(width: 12, height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 30, height: 30,
                decoration: BoxDecoration(
                  color: AppTheme.black4,
                  borderRadius: BorderRadius.circular(99),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(Svgicons.x, width: 20, height: 20,),
              ),
            )
          ],
        ),
        SizedBox(height: 12,),
        SizedBox(height: 8,),
        SizedBox(height: 24,),
        TextButton(
          onPressed: (){

          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),)
            ),
            minimumSize: WidgetStateProperty.all<Size>(const Size(double.infinity, 52)),
            textStyle: WidgetStateProperty.all<TextStyle>(
                  TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w500, height: 1.29,
                  )
            ),
            backgroundColor:  WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return AppTheme.black8; // 禁用状态
                }
                return AppTheme.black95;
              },
            ),
            foregroundColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return AppTheme.black25; // 禁用状态
                }
                return AppTheme.white0;
              },
            ),
          ),
          child: Text('Done',),
        ),
        SizedBox(height: 8,),
        SizedBox(
          height: 21,
        )
      ],
    );
  }

}