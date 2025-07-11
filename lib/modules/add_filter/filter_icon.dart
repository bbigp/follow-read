
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/filter_icons.dart';

class FilterIcon extends StatelessWidget {
  final String icon;
  final double size;
  final BoxFit fit;
  const FilterIcon({super.key,
    required this.icon,
    this.size = 24,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    if (FilterIcons.iconMap.keys.contains(icon)) {
      return Icon(FilterIcons.iconMap[icon], size: size,);
    }
    return Align(
      alignment: Alignment.center,
      child: SvgPicture.asset(FilterIcons.icon(icon), width: size, height: size,
        fit: fit,
      ),
    );
  }
}