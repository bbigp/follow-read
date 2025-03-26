
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/features/presentation/providers/entry_loading_provider.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';

import '../../../config/theme.dart';
import '../../../core/utils/logger.dart';
import '../providers/entry_detail_provider.dart';

class EntryDetailBottomBar extends ConsumerWidget {

  final int entryId;
  final int feedId;

  const EntryDetailBottomBar({super.key, required this.entryId, required this.feedId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        // 处理全面屏底部安全区域
        top: false,
        child: Column(
          children: [
            SpacerDivider(
              spacing: 1,
              thickness: 1,
              indent: 0,
              color: AppTheme.black8,
            ),
            Container(
              color: Colors.white,
              padding:
              const EdgeInsets.only(top: 16, bottom: 20, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: SvgPicture.asset(
                          'assets/svg/ai_outline.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      // 中间自适应区域
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            // 计算可用空间和间距
                            final totalSpacing =
                                constraints.maxWidth - (28 * 3); // 20为图标宽度
                            final eachSpacing =
                                totalSpacing / 4; // 4个间隔区域：左间隔 + 图标间*2 + 右间隔

                            return Row(
                              children: [
                                SizedBox(width: eachSpacing),
                                SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: SvgPicture.asset(
                                    'assets/svg/bubble_language.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                SizedBox(width: eachSpacing),
                                GestureDetector(
                                  onTap: () async {
                                    final success = await ref.watch(entryDetailProvider(entryId).notifier).read();
                                    if (success) {
                                      ref.watch(entriesLoadingProvider(feedId).notifier).updateRead(entryId, 'read');
                                    } else {
                                      logger.e('read失败$entryId');
                                    }
                                  },
                                  child: SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: SvgPicture.asset(
                                      'assets/svg/mark_read.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                                SizedBox(width: eachSpacing),
                                SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: SvgPicture.asset(
                                    'assets/svg/plus_o.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                SizedBox(width: eachSpacing),
                              ],
                            );
                          },
                        ),
                      ),

                      // 右侧固定图标
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: SvgPicture.asset(
                          'assets/svg/share.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }



}