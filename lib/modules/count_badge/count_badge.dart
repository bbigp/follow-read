import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/modules/count_badge/unread_controller.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:get/get.dart';


class CountBadge extends StatelessWidget {
  final controller = Get.find<UnreadController>();
  final profile = Get.find<ProfileController>();

  final String id;

  CountBadge({super.key, required this.id,});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      CountBadgeBuilder builder = switch(profile.state.unreadMark) {
        UnreadMark.none => noneBadgeBuilder,
        UnreadMark.dot => dotBadgeBuilder,
        _ => numberBadgeBuilder,
      };
      return builder(context, controller.unread(id));
    });
  }
}

typedef CountBadgeBuilder = Widget Function(BuildContext context, int count);

Widget dotBadgeBuilder(BuildContext context, int count) {
  return Row(children: [
    const SizedBox(width: 20,),
    count == 0
        ? const SizedBox(width: 20,)
        : Padding(
            padding: const EdgeInsets.all(7.5),
            child: SvgPicture.asset(SvgIcons.badge_dot, width: 5, height: 5,),
          ),
    const SizedBox(width: 4,),
  ],);
}

Widget numberBadgeBuilder(BuildContext context, int count) {
  return Row(children: [
    SizedBox(width: 40, child: Align(
      alignment: Alignment.centerRight,
      child: PgText(count == 0 ? '' : '$count', maxLines: 1, style: AppTextStyles.M13B25,
        textAlign: TextAlign.right,
      ), //设计图height 1.38
    ),),
    const SizedBox(width: 4,),
  ],);
}

Widget noneBadgeBuilder(BuildContext context, int count) {
  return const SizedBox.shrink();
}



// typedef Counter = AsyncValue<int> Function(WidgetRef ref, int id);
// AsyncValue<int> clusterCounter(WidgetRef ref, int id) => ref.watch(clusterUnreadProvider(id));
// AsyncValue<int> feedCounter(WidgetRef ref, int id) => ref.watch(feedUnreadProvider(id));
// AsyncValue<int> folderCounter(ref, id) => ref.watch(folderUnreadProvider(id));

// abstract class Counter {
//   AsyncValue<int> watch(WidgetRef ref, int id);
// }
//
// class ClusterCounter implements Counter {
//   @override
//   AsyncValue<int> watch(WidgetRef ref, int id) {
//     return ref.watch(clusterUnreadProvider(id));
//   }
// }
//
// class FolderCounter implements Counter {
//   @override
//   AsyncValue<int> watch(WidgetRef ref, int id) {
//     return AsyncValue.data(74);
//   }
// }
//
// class FeedCounter implements Counter {
//   @override
//   AsyncValue<int> watch(WidgetRef ref, int id) {
//     return ref.watch(feedUnreadProvider(id));
//   }
// }

