
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/rss_utils.dart';
import '../../data/models/entry.dart';

class EntryItemView extends StatelessWidget {
  final Entry item;

  const EntryItemView({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: item.summary == "" ? 2 : 1,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  item.summary == "" ? Container() :
                  Text(
                    item.summary,
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: item.summary == "" ? 0 : 8,
                  ),
                  Text(
                    RssUtils.timeAgo(item.publishedAt!),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ]),
          ),
          SizedBox(width: item.mainPic != null ? 16 : 0), // 左右间距
          item.mainPic != null ?
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0), // 圆角缩略图
            child: CachedNetworkImage(
              imageUrl: item.mainPic!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 80,
                height: 80,
                color: Colors.grey[300], // 错误时的背景颜色
                child: Icon(Icons.error, color: Colors.red), // 错误图标
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }

}
