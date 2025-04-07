
import 'package:flutter/material.dart';
import 'package:follow_read/features/presentation/widgets/no_media.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LazyImage extends StatefulWidget {
  final String url;
  final double loadThreshold;
  final Duration debounceTime;

  const LazyImage({
    required this.url,
    this.loadThreshold = 0.2,
    this.debounceTime = const Duration(milliseconds: 300),
    Key? key,
  }) : super(key: key);

  @override
  _LazyImageState createState() => _LazyImageState();
}

class _LazyImageState extends State<LazyImage> {
  bool _shouldLoad = false;
  bool _hasLoaded = false;


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.url),
      onVisibilityChanged: _handleVisibilityChange,
      child: _buildContent(),
    );
  }

  void _handleVisibilityChange(VisibilityInfo info) {
    final isVisible = info.visibleFraction >= widget.loadThreshold;

    if (!mounted) return;

    if (isVisible && !_hasLoaded) {
      setState(() {
        _shouldLoad = true;
        _hasLoaded = true;
      });
    }
  }

  Widget _buildContent() {
    if (!_shouldLoad) {
      return _buildPlaceholder();
    }

    return CachedNetworkImage(
      imageUrl: widget.url,
      width: 80, height: 80,
      placeholder: (_, __) => _buildPlaceholder(),
      errorWidget: (_, __, ___) => NoMedia(width: 80, height: 80,),
      fadeInDuration: const Duration(milliseconds: 200),
      fit: BoxFit.cover,
    );
  }

  Widget _buildPlaceholder() {
    return NoMedia(width: 80, height: 80,);
  }
}

