

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryDetail extends ConsumerWidget {

  final int id;
  const EntryDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final entryAsync = ref.watch(entryProvider(id));
    // if (entryAsync.isLoading) {
    //   return const SizedBox.shrink();
    // }
    // final entry = entryAsync.requireValue;

    return const SizedBox.shrink();
  }

}