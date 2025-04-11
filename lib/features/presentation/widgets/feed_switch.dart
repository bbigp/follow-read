

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';
import 'package:follow_read/features/presentation/widgets/preference_panel.dart';

import '../../domain/models/tile.dart';
import '../providers/home_page_provider.dart';

class FeedSwitch extends ConsumerWidget {

  final int id;
  final TileType type;

  const FeedSwitch({super.key, required this.id, required this.type,});

  String get pid => PageUtils.pid(type, id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileState = ref.watch(tileProvider(pid));
    return tileState.when(data: (tile){
      return PreferencePanel(
        items: [
          SwitchItem(icon: Svgicons.onlyUnread, label: '只显示未读',
              value: tile.onlyShowUnread,
              onChanged: (v){
                ref.read(tileProvider(pid).notifier).saveShow(onlyShowUnread: v);
                final _ = ref.refresh(homePageProvider);
              }
          ),
          SwitchItem(icon: Svgicons.readingTime, label: '阅读时间',
              value: tile.showReadingTime,
              onChanged: (v) => ref.read(tileProvider(pid).notifier).saveShow(showReadingTime: v),
          ),
          SwitchItem(icon: Svgicons.ban, label: '全局隐藏',
              value: tile.hideGlobally,
              onChanged: (v) {
                ref.read(tileProvider(pid).notifier).saveShow(hideGlobally: v);
                final _ = ref.refresh(homePageProvider);
              }
          ),
        ],
      );
    }, error: (_, stack) => const SizedBox.shrink(), loading: () => const SizedBox.shrink());
  }

}
