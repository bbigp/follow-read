
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/modules/entry/entry_controller.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;

import 'entry_image.dart';



class EntryContent extends StatelessWidget {

  final Entry entry;
  EntryContent({super.key, required this.entry});

  final ec = Get.find<EntryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Html(
        data: ec.isReaderMode ? entry.readableContent : entry.content,
        extensions: [
          TagExtension(
              tagsToExtend: {'img'},
              builder: (context) {
                final element = context.node as dom.Element;
                final src = element.attributes['src'] ?? '';
                final alt = element.attributes["alt"] ?? "";
                return EntryImage(url: src, alt: alt, width: double.infinity, referer: entry.url,);
              }
          )
        ],
        style: {
          "*": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            color: AppColors.black95,
            fontSize: FontSize(16),
            fontWeight: FontWeight.w400,
            fontFamily: "DMSans",
            lineHeight: LineHeight(24 / 16),
          ),
          "a": Style(textDecoration: TextDecoration.underline), // 添加下划线
          "p, div": Style(margin: Margins.only(bottom: 16)),
          "br": Style(display: Display.block, margin: Margins.only(bottom: 16)),
          "ol, ul": Style(padding: HtmlPaddings.symmetric(horizontal: 16), margin: Margins.only(bottom: 16)),
          "li": Style(fontWeight: FontWeight.w500, margin: Margins.only(bottom: 7)),
          "h1": Style(fontSize: FontSize(20), lineHeight: LineHeight(26/20), fontWeight: FontWeight.w500, margin: Margins.only(top: 32, bottom: 16)),
          "h2, h3, h4, h5, h6": Style(fontSize: FontSize(18), lineHeight: LineHeight(24/18), fontWeight: FontWeight.w500, margin: Margins.only(top: 24, bottom: 16)),
          "strong": Style(fontWeight: FontWeight.w500),
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
    });
  }


}