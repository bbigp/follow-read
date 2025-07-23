// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:follow_read/config/svg_icons.dart';
// import 'package:follow_read/config/theme.dart';
// import 'package:follow_read/core/utils/page_utils.dart';
// import 'package:follow_read/features/domain/models/constants.dart';
// import 'package:follow_read/features/domain/models/tile.dart';
// import 'package:follow_read/features/presentation/providers/tile_provider.dart';
// import 'package:follow_read/global/widgets/card_viewx.dart';
// import 'package:follow_read/global/widgets/cupx_sliding_segmented_control.dart';
// import 'package:follow_read/global/widgets/drag_handle.dart';
// import 'package:follow_read/modules/widgets/feed/add_feed_form.dart';
// import 'package:follow_read/modules/widgets/feed_icon.dart';
// import 'package:follow_read/modules/widgets/feed_switch.dart';
// import 'package:follow_read/modules/widgets/open_modal.dart';
// import 'package:follow_read/theme/app_text_styles.dart';
//
//
// class FeedSettingsSheet extends ConsumerWidget {
//   final int id;
//   final TileType type;
//
//   const FeedSettingsSheet({
//     super.key,
//     required this.id,
//     required this.type,
//   });
//
//   String get pid => PageUtils.pid(type, id);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tileAsync = ref.watch(tileProvider(pid));
//     final tile = tileAsync.requireValue;
//     return ;
//   }
//
// }
