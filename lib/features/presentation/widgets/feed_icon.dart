import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/providers/auth_provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/theme.dart';
import 'base64_icon.dart';

class FeedIcon extends ConsumerWidget {
  final String title;
  final String iconUrl;
  final double size;
  final TextStyle textStyle;
  final Color beginBackgroundColor;
  final Color endBackgroundColor;
  final double radius;

  const FeedIcon({
    super.key,
    required this.title,
    required this.iconUrl,
    this.size = 24,
    this.textStyle = const TextStyle(
      fontSize: 15,
      height: 1.33,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    this.beginBackgroundColor = AppTheme.black25, // 50% 透明度 (0x80 = 128)
    this.endBackgroundColor = AppTheme.black75, // 75% 透明度 (0xBF = 191)
    this.radius = 6,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider.select((state) => state.user));
    return SizedBox(
      width: size,
      height: size,
      child: iconUrl.isNotEmpty == true && user != null
          ? _buildCachedNetworkImage(user.token)
          : _buildInitialsAvatar(),
    );
  }

  Widget _buildCachedNetworkImage(String token) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Base64Icon(
          imageUrl: iconUrl,
          headers: {
            "X-Auth-Token": token,
          },
          width: size,
          height: size,
          placeholder: Shimmer.fromColors(
            baseColor: AppTheme.black4,
            highlightColor: AppTheme.black8,
            child: Container(width: size, height: size, color: Colors.white,), // 后续项复用
          ),
          errorWidget: _buildInitialsAvatar(),
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar() {
    final initials = _getInitials(title);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            beginBackgroundColor,
            endBackgroundColor,
          ],
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: textStyle,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }

  String _getInitials(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return "?";
    return trimmed[0].toUpperCase();

    // final firstSpaceIndex = trimmed.indexOf(' ');
    // if (firstSpaceIndex != -1 && firstSpaceIndex < trimmed.length - 1) {
    //   return '${trimmed[0]}${trimmed[firstSpaceIndex + 1]}'.toUpperCase();
    // }
    // return trimmed[0].toUpperCase();
  }
}
