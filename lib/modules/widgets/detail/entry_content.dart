
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:html/dom.dart' as dom;

import 'entry_image.dart';


class EntryContent extends ConsumerWidget {

  final Entry entry;
  const EntryContent({super.key, required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Html(
      data: entry.content,
      extensions: [
        TagExtension(
            tagsToExtend: {'img'},
            builder: (context) {
              final element = context.node as dom.Element;
              final src = element.attributes['src'] ?? '';
              return EntryImage(url: src, onTap: (){
                // ref.read(routerProvider).pushNamed(RouteNames.imageGallery, extra: {
                //   "imageUrls": entry.allImageUrls, "index": entry.allImageUrls.indexOf(src),
                // });
              },);
            }
        )
      ],
      style: {
        "*": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          color: Color.fromRGBO(0, 0, 0, 0.95),
          // 降级到 RGBA
          fontSize: FontSize(15),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          lineHeight: LineHeight(20 / 15), // 1.333 倍行高
        ),
      },
    );
  }


}