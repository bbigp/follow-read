

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/presentation/providers/unread_count_notifier.dart';
import 'package:follow_read/theme/text_styles.dart';

///
class CountBadge extends ConsumerWidget {

  final UnreadMark unreadMark;
  final int id;
  final Counter counter;

  const CountBadge({super.key, this.unreadMark = UnreadMark.number,
    required this.id,
    required this.counter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countAsync = counter.watch(ref, id);
    if (countAsync.isLoading) {
      return SizedBox(width: 44,);
    }
    CountBadgeBuilder builder = switch(unreadMark) {
      UnreadMark.none => noneBadgeBuilder,
      UnreadMark.dot => dotBadgeBuilder,
      _ => numberBadgeBuilder,
    };
    return builder(context, countAsync.requireValue);
  }

}

typedef CountBadgeBuilder = Widget Function(BuildContext context, int count);

Widget dotBadgeBuilder(BuildContext context, int count) {
  return Row(children: [
    const SizedBox(width: 20,),
    count == 0
        ? const SizedBox(width: 20,)
        : Padding(padding: const EdgeInsets.all(7.5), child: SvgPicture.asset(Svgicons.badge_dot, width: 5, height: 5,),),
    const SizedBox(width: 4,),
  ],);
}

Widget numberBadgeBuilder(BuildContext context, int count) {
  return Row(children: [
    SizedBox(width: 40, child: Align(
      alignment: Alignment.centerRight,
      child: Text(count == 0 ? '' : '$count', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.hint13500,), //设计图height 1.38
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

abstract class Counter {
  AsyncValue<int> watch(WidgetRef ref, int id);
}

class ClusterCounter implements Counter {
  @override
  AsyncValue<int> watch(WidgetRef ref, int id) {
    return ref.watch(clusterUnreadProvider(id));
  }
}

class FolderCounter implements Counter {
  @override
  AsyncValue<int> watch(WidgetRef ref, int id) {
    return AsyncValue.data(74);
  }
}

class FeedCounter implements Counter {
  @override
  AsyncValue<int> watch(WidgetRef ref, int id) {
    return ref.watch(feedUnreadProvider(id));
  }
}

enum UnreadMark {
  none, dot, number,
}