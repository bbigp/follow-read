

import 'package:flutter/material.dart';

class GetModalWrapper extends StatefulWidget {
  final void Function() initControllers;
  final void Function() disposeControllers;
  final Widget Function() builder;

  const GetModalWrapper({
    super.key,
    required this.initControllers,
    required this.disposeControllers,
    required this.builder,
  });

  @override
  State<GetModalWrapper> createState() => _GetModalWrapperState();
}

class _GetModalWrapperState extends State<GetModalWrapper> {

  @override
  void initState() {
    super.initState();
    widget.initControllers();
  }

  @override
  void dispose() {
    widget.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder();
}