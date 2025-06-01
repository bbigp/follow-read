
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/domain/cases/open.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/presentation/providers/entry_provider.dart';
import 'package:follow_read/features/presentation/widgets/components/buttonx.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_app_bar.dart';
import 'package:follow_read/features/presentation/widgets/components/padded_svg_icon.dart';
import 'package:follow_read/features/presentation/widgets/components/tab_barx.dart';
import 'package:follow_read/features/presentation/widgets/detail/entry_content.dart';
import 'package:follow_read/features/presentation/widgets/detail/entry_image.dart';
import 'package:follow_read/features/presentation/widgets/detail/entry_title.dart';
import 'package:follow_read/features/presentation/widgets/components/no_more.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:share_plus/share_plus.dart';

///
class EntryDetailPage extends ConsumerWidget {
  final int entryId;

  const EntryDetailPage({super.key,
    required this.entryId,
  });

  // var content =
  //     '<div>In the meantime, if you want more features, Voice PE can connect to supported AI models, such as ChatGPT or Gemini, to fully replace Assist or use it as a fallback for commands it doesn’t understand. But for many smart home users, there will be plenty of value in a simple, inexpensive device that lets you turn your lights on and off, start a timer, and execute other useful commands with your voice without relying on an internet connection.</div>'
  //     '<div>While the intention is to surpass “Big Tech voice assistants,” Paulus Schoutsen, founder of Home Assistant, recognizes it’s not there yet. Hence, Voice is launching as a Preview Edition. “For some, the current capabilities of our voice assistant will be all they need, especially those who just want to set timers, manage their shopping list, and control their most used devices,” says Schoutsen. “For others, we understand they want to ask their voice assistant to make whale sounds or to tell them how tall Taylor Swift is — our voice assistant doesn’t do those things… yet.”</div>';
  //
  // var content1 =
  //     '<p>Re-reading is a practice fits into every reader&#39;s life in a different way, and today&#39;s guest has embarked on a unique reading challenge that brings a fresh perspective to her re-reading. </p><p><br></p><p>Sarah Swarbrick joins Anne today from the outskirts of Sydney, Australia, to talk about the special project she&#39;s crafted in advance of her 53rd birthday. With her responsibilities shifting and her kids getting older, Sarah&#39;s finding more time for reading lately, and she&#39;s excited about having extra space to approach her books with a different kind of thoughtfulness and intention.</p><p><br></p><p>Sarah&#39;s decided to re-read a selection of her favorite books from childhood, and she&#39;s also trying to pair each childhood favorite with a more recent release. She&#39;s looking for books that have a lot to say to each other, that can really be in conversation with each other, and not just in the ways that are obvious on the surface. She and Anne discuss Sarah&#39;s project so far, and explore some unpaired re-reads to discover which new-to-her titles Sarah might enjoy matching with her long-standing favorites.</p><p><br></p><p>See the list of titles discussed today and leave your suggestions for Sarah on our show notes page at <a href="http://whatshouldireadnextpodcast.com/470" rel="noopener noreferrer" target="_blank" referrerpolicy="no-referrer">whatshouldireadnextpodcast.com/470</a>.</p><p><br></p><p>Our What Should I Read Next Patreon community makes a very real difference in our ability to do the work we do: as a way to say thank you for that ongoing financial support, we share weekly bonus episodes and invite our community members to join us for special events, like our upcoming Summer Reading Guide live unboxing. Thanks to everyone who is already a part of our Patreon community, we are so appreciative. If you would like to come join us, get the details at <a href="https://www.patreon.com/whatshouldireadnext" rel="noopener noreferrer" target="_blank" referrerpolicy="no-referrer">patreon.com/whatshouldireadnext</a>. </p><p> </p><p>Learn more about your ad choices. Visit <a href="https://megaphone.fm/adchoices" rel="noopener noreferrer" target="_blank" referrerpolicy="no-referrer">megaphone.fm/adchoices</a></p>';


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entryAsync = ref.watch(entryProvider(entryId));
    if (entryAsync.isLoading) {
      return CupertinoActivityIndicator(radius: 10,);
    }
    final entry = entryAsync.requireValue;


    return Scaffold(
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(Svgicons.arrow_left, onTap: (){
          Navigator.of(context).pop();
        },),
      ),
      body: Column(children: [
        Expanded(child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 48),
            child: Column(children: [
              if (entry.pic.isNotEmpty) ...[
                EntryImage(url: entry.pic, height: 241, onTap: (){
                  ref.read(routerProvider).pushNamed(RouteNames.imageGallery, extra: {
                    "imageUrls": entry.allImageUrls, "index": entry.allImageUrls.indexOf(entry.pic),
                  });
                },),
                const SizedBox(height: 12,),
              ],
              EntryTitle(entry: entry),
              const SizedBox(height: 12,),
              EntryContent(entry: entry),
              const SizedBox(height: 12,),
              NoMore(),
              const SizedBox(height: 12,),

              const SizedBox(height: 8,),
              IconButtonx(child: "View Website", icon: Svgicons.out_o, isLeftIcon: false,
                size: Sizex.custom, buttonSize: mediumCompact().copyWith(
                  padding: 32,
                ),
                type: ButtonxType.secondary,
                enabled: true, onPressed: () async {
                  Open.browser(context, entry.url);
                },
              ),
              // const SizedBox(height: 8,),//设计图8
              const SizedBox(height: 12,), //设计图48
            ],),
          ),
        )),
        TabBarx(tabs: [
          BottomBarItem(
            icon: entry.starred ? Svgicons.star_fill : Svgicons.star,
            onPressed: () async {
              await ref.read(entryProvider(entryId).notifier).starred();
            }
          ),
          BottomBarItem(
            icon: entry.status == Model.unread ? Svgicons.check_o : Svgicons.check_fill,
            onPressed: () async {
              await ref.read(entryProvider(entryId).notifier).read();
            },
          ),
          BottomBarItem(icon: Svgicons.chevron_down,),
          BottomBarItem(icon: Svgicons.explorer, onPressed: () async {
            Open.browser(context, entry.url);
          },),
          BottomBarItem(icon: Svgicons.share, onPressed: () async {
            Share.share("${entry.title}\n${entry.url}");
          },)
        ],)
      ],),
    );
  }

}
