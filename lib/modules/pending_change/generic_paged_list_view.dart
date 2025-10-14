import 'package:flutter/material.dart';
import 'package:follow_read/data/model/page_state.dart';
import 'package:follow_read/global/widgets/loading_more.dart';
import 'package:follow_read/global/widgets/no_more.dart';
import 'package:get/get.dart';

// 假设我们使用如下类型定义来保持通用性
// T_Controller 必须是 GetxController 且具有 load/nextPage 方法
// T_Item 是列表项的数据类型

class GenericPagedListView<T_Controller extends PagedController<T>, T> extends StatefulWidget {

  final T_Controller controller;

  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  const GenericPagedListView({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.separatorBuilder,
  });

  @override
  State<GenericPagedListView<T_Controller, T>> createState() => _GenericPagedListViewState<T_Controller, T>();
}

class _GenericPagedListViewState<T_Controller extends PagedController<T>, T>
    extends State<GenericPagedListView<T_Controller, T>> {

  final ScrollController _scrollController = ScrollController();

  T_Controller get controller => widget.controller;
  PageState<T> get state => controller.state;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (state.isLoading) return;
    if (!state.hasMore) return;
    if (state.isLoadingMore) return;
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      (controller as dynamic).nextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<T> items = state.items;
      return RefreshIndicator(
        onRefresh: () => (controller as dynamic).load(),
        child: ListView.separated(
          controller: _scrollController,
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == items.length) {
              return state.hasMore ? const LoadingMore() : const NoMore();
            }
            return widget.itemBuilder(context, items[index], index);
          },
          separatorBuilder: widget.separatorBuilder ?? (_, __) => const SizedBox(height: 1),
        ),
      );
    });
  }
}