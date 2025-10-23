
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
          "body": Style(
            fontSize: FontSize(16.0),
            margin: Margins.zero,
            padding: HtmlPaddings.only(left: 20, right: 20, bottom: 12),
            color: AppColors.black95,
            backgroundColor: Colors.white,
            lineHeight: LineHeight.rem(1.5),
            fontFamily: 'DMMono',
          ),
          "p, div": Style(fontWeight: FontWeight.w400,
              letterSpacing: 0,
              margin: Margins.only(top: 16, bottom: 16)),
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