
import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/cupx_list_tile_chevron.dart';
import 'package:follow_read/global/widgets/no_more.dart';
import 'package:follow_read/global/widgets/padded_svg_icon.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/global/widgets/empty_state_view.dart';
import 'package:follow_read/modules/search/search_controller.dart';
import 'package:get/get.dart';

///
class SearchHistoryView extends StatelessWidget {

  SearchHistoryView({super.key});
  final search = Get.find<SearchHistoryController>();

  @override
  Widget build(BuildContext context) {
    Widget view = Column(children: [
      Padding(
        padding: EdgeInsets.only(left: 16, right: 12, top: 4, bottom: 8),
        child: Row(children: [
          Expanded(child: PgText('最近搜索', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.R13B50,)),
          const SizedBox(width: 10, height: 24,),
          InkWell(
                onTap: () => search.clear(),
                child: PaddedSvgIcon(
                  SvgIcons.trash,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(AppColors.black50, BlendMode.srcIn),
                ),
              )
            ],),
      ),
      Expanded(child: Obx((){
        final histories = search.state.histories;
        return ListView.separated(
          itemBuilder: (context, index) {
            if (index == histories.length) {
              return NoMore();
            }
            final word = histories[index];
            return ListTilexChevron(
              title: word,
              onTap: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  FocusScope.of(context).unfocus(); // 收起键盘
                });
                search.loadEntries(word);
              },
            );
          },
          separatorBuilder: (_, index) {
            return SpacerDivider(thickness: 0.5,spacing: 1,indent: 16,);
          },
          itemCount: histories.length + 1,
          padding: EdgeInsets.zero,
        );
      }))
    ],);

    return Obx(() {
      return search.state.loadingHistories || search.state.histories.isEmpty
          ? EmptyStateView()
          : view;
    });
  }


}