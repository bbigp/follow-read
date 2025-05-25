

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_list_tile.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_sheet_title.dart';
import 'package:follow_read/features/presentation/widgets/components/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/server_picker.dart';

import '../../../config/svgicons.dart';
import '../providers/user_provider.dart';
import '../widgets/open_modal.dart';
import '../widgets/preference_panel.dart';

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: CupxSheetTitle.closeButton(
            color: AppTheme.black4, height: 54,
            title: '设置',
            leading: ChevronLeftCloseButton(),
          ),
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
                  CupxListTile.chevronUpDown(
                      icon: Svgicons.book,
                      title: '服务器URL',
                      onTap: () {
                        OpenModal.open(context, ServerPicker(), scrollable: true);
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
