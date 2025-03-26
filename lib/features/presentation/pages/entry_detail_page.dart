
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/providers/entry_detail_provider.dart';
import 'package:follow_read/features/presentation/widgets/entry_detail_bottom_bar.dart';
import 'package:follow_read/features/presentation/widgets/no_more_loading.dart';
import 'package:follow_read/features/presentation/widgets/view_website_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:html/dom.dart' as dom;

import '../../../routes/app_route.dart';
import '../../domain/models/entry.dart';

class EntryDetailPage extends ConsumerStatefulWidget {
  final int entryId;

  const EntryDetailPage({
    required this.entryId,
    super.key,
  });

  @override
  ConsumerState<EntryDetailPage> createState() => _EntryDetailPageState();
}

class _EntryDetailPageState extends ConsumerState<EntryDetailPage> {
  var content =
      '<div>In the meantime, if you want more features, Voice PE can connect to supported AI models, such as ChatGPT or Gemini, to fully replace Assist or use it as a fallback for commands it doesn’t understand. But for many smart home users, there will be plenty of value in a simple, inexpensive device that lets you turn your lights on and off, start a timer, and execute other useful commands with your voice without relying on an internet connection.</div>'
      '<div>While the intention is to surpass “Big Tech voice assistants,” Paulus Schoutsen, founder of Home Assistant, recognizes it’s not there yet. Hence, Voice is launching as a Preview Edition. “For some, the current capabilities of our voice assistant will be all they need, especially those who just want to set timers, manage their shopping list, and control their most used devices,” says Schoutsen. “For others, we understand they want to ask their voice assistant to make whale sounds or to tell them how tall Taylor Swift is — our voice assistant doesn’t do those things… yet.”</div>';

  var content1 =
      '<p>Re-reading is a practice fits into every reader&#39;s life in a different way, and today&#39;s guest has embarked on a unique reading challenge that brings a fresh perspective to her re-reading. </p><p><br></p><p>Sarah Swarbrick joins Anne today from the outskirts of Sydney, Australia, to talk about the special project she&#39;s crafted in advance of her 53rd birthday. With her responsibilities shifting and her kids getting older, Sarah&#39;s finding more time for reading lately, and she&#39;s excited about having extra space to approach her books with a different kind of thoughtfulness and intention.</p><p><br></p><p>Sarah&#39;s decided to re-read a selection of her favorite books from childhood, and she&#39;s also trying to pair each childhood favorite with a more recent release. She&#39;s looking for books that have a lot to say to each other, that can really be in conversation with each other, and not just in the ways that are obvious on the surface. She and Anne discuss Sarah&#39;s project so far, and explore some unpaired re-reads to discover which new-to-her titles Sarah might enjoy matching with her long-standing favorites.</p><p><br></p><p>See the list of titles discussed today and leave your suggestions for Sarah on our show notes page at <a href="http://whatshouldireadnextpodcast.com/470" rel="noopener noreferrer" target="_blank" referrerpolicy="no-referrer">whatshouldireadnextpodcast.com/470</a>.</p><p><br></p><p>Our What Should I Read Next Patreon community makes a very real difference in our ability to do the work we do: as a way to say thank you for that ongoing financial support, we share weekly bonus episodes and invite our community members to join us for special events, like our upcoming Summer Reading Guide live unboxing. Thanks to everyone who is already a part of our Patreon community, we are so appreciative. If you would like to come join us, get the details at <a href="https://www.patreon.com/whatshouldireadnext" rel="noopener noreferrer" target="_blank" referrerpolicy="no-referrer">patreon.com/whatshouldireadnext</a>. </p><p> </p><p>Learn more about your ad choices. Visit <a href="https://megaphone.fm/adchoices" rel="noopener noreferrer" target="_blank" referrerpolicy="no-referrer">megaphone.fm/adchoices</a></p>';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(entryDetailProvider(widget.entryId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(entryDetailProvider(widget.entryId));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        actions: [
          // _buildRefreshButton(ref, feedsState.isSyncing),
          // const SizedBox(width: 12),
        ],
      ),
      body: Stack(
        children: [
          _buildScrollableContent(state.entry),
          EntryDetailBottomBar(entryId: state.entry.id),
        ],
      ),
    );
  }


  Widget _buildScrollableContent(Entry entry) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          // 添加滚动容器
          physics: const BouncingScrollPhysics(), // 推荐添加弹性滚动效果
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 8),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 8, // 保证最小高度填满屏幕
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 自适应内容高度
                children: [
                  if (entry.pic != "")
                    _buildImage(entry),
                    SizedBox(
                      height: 12,
                    ),
                  _buildTitle(entry),
                  _buildContent(entry),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: NoMoreLoading(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 48 + 60),
                    child: ViewWebsiteButton(url: entry.url),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void openImageGallery(Entry entry, String currentImage){
    final images = entry.allImageUrls;
    ref.watch(routerProvider).pushNamed(RouteNames.imageGallery, extra: {
      "imageUrls": images, "index": images.indexOf(currentImage),
    });
  }


  Widget _buildContent(Entry entry) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Html(
        data: entry.content,
        extensions: [
          TagExtension(
            tagsToExtend: {'img'},
            builder: (context) {
              final element = context.node as dom.Element;
              final src = element.attributes['src'] ?? '';
              return GestureDetector(
                onTap: () {
                  openImageGallery(entry, src);
                },
                child: CachedNetworkImage(
                  imageUrl: src,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(color: Colors.white,),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.broken_image),
                ),
              );
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
      ),
    );
  }

  Widget _buildTitle(Entry entry) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              height: 1.27,
              color: AppTheme.black95,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Text(
                  entry.author,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    height: 1.18,
                    color: AppTheme.black50,
                  ),
                ),
                if (entry.author != "" && entry.feed.title != "")
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset(
                        'assets/svg/vector.svg',
                        width: 2,
                        height: 6,
                      )),
                Text(
                  entry.feed.title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    height: 1.18,
                    color: AppTheme.black50,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              entry.publishedAt.toShowTime(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                height: 1.18,
                color: AppTheme.black50,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage(Entry entry) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: GestureDetector(
                onTap: () {
                  openImageGallery(entry, entry.pic);
                },
                child: CachedNetworkImage(
                  imageUrl: entry.pic,
                  height: 241,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      // width: 18,
                      height: 241,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    // width: 18,
                    height: 241,
                    color: Colors.grey[300], // 错误时的背景颜色
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 10,
                    ), // 错误图标
                  ),
                ),
              ),
            ),
          ),
          // if (false)
          //   Padding(
          //     padding: EdgeInsets.only(top: 12),
          //     child: Text(
          //       'The Home Assistant Voice Preview Edition is the first hardware from the open-source smart home platform that’s designed for voice control. Image: Nabu Casa',
          //       style: TextStyle(
          //         fontSize: 11,
          //         fontWeight: FontWeight.w500,
          //         height: 1.18,
          //         color: AppTheme.black25,
          //       ),
          //     ),
          //   )
        ],
      ),
    );
  }
}
