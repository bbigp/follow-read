

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';

class SyncIcon extends ConsumerStatefulWidget {

  const SyncIcon({super.key});

  @override
  ConsumerState<SyncIcon> createState() => _SyncIconState();
}

class _SyncIconState extends ConsumerState<SyncIcon> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  bool _isRotating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  void _toggleRotation() {
    setState(() {
      _isRotating = !_isRotating;
      if (_isRotating) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isRotating ? null : _toggleRotation,
      child: AbsorbPointer(
        absorbing: _isRotating,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * 3.14159,
              child: child,
            );
          },
          child: Padding(
            padding: EdgeInsets.all(4),
            child:  SvgPicture.asset(Svgicons.sync, width: 24, height: 24, fit: BoxFit.contain,),
          ),
        ),
      ),
    );
    return RotationTransition(
      turns: _controller,
      child: SizedBox(
        width: 28, height: 28,
        child: SvgPicture.asset(Svgicons.sync, width: 24, height: 24, fit: BoxFit.contain,),
      ),
    );
  }


  // Widget _buildRefreshButton(WidgetRef ref) {
  //   final status = ref.watch(syncProvider.select((s) => s.status));
  //   return status == SyncTask.syncing
  //       ? Padding(
  //     padding: const EdgeInsets.all(16),
  //     child: SizedBox(
  //       width: 16,
  //       height: 16,
  //       child: CircularProgressIndicator(
  //         strokeWidth: 2,
  //         color: Colors.black,
  //       ),
  //     ),
  //   )
  //       : IconButton(
  //     icon: const Icon(
  //       Icons.refresh,
  //       color: Colors.black,
  //     ),
  //     onPressed: () async {
  //       ref.read(syncProvider.notifier).startSync();
  //     },
  //   );
  // }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


}