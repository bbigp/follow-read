
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:html/dom.dart' as dom;

import 'entry_image.dart';



class EntryContent extends StatelessWidget {

  final Entry entry;
  const EntryContent({super.key, required this.entry});


  @override
  Widget build(BuildContext context) {
    return Html(
      data: entry.content,
      extensions: [
        TagExtension(
            tagsToExtend: {'img'},
            builder: (context) {
              final element = context.node as dom.Element;
              final src = element.attributes['src'] ?? '';
              final alt = element.attributes["alt"] ?? "";
              return EntryImage(url: src, alt: alt, height: 241, width: double.infinity);
            }
        )
      ],
      style: {
        "*": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          color: AppColors.black95,
          fontSize: FontSize(15),
          fontWeight: FontWeight.w400,
          fontFamily: "DMSans",
          lineHeight: LineHeight(20 / 15), // 1.333 倍行高
        ),
        "a": Style(textDecoration: TextDecoration.underline), // 添加下划线
        "p": Style(margin: Margins.only(bottom: 12)),
        "div": Style(margin: Margins.only(bottom: 12)),
        "br": Style(display: Display.block, margin: Margins.only(bottom: 12)),
        "ol": Style(padding: HtmlPaddings.symmetric(horizontal: 16)),
        "ul": Style(padding: HtmlPaddings.symmetric(horizontal: 16)),
      },
      onLinkTap: (url, attributes, element) {
        final hasOnlyImageChild = element?.children.length == 1 && element?.children.first.localName == 'img';
        if (hasOnlyImageChild) {
          return; // 忽略点击
        }
        if (url != null) {
          Open.browser(url);
        }
      },
    );
  }


}