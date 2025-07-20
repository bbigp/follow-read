import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/global/widgets/pg_text.dart';

class EntryVideo extends StatefulWidget {
  final String url;

  const EntryVideo({super.key, required this.url});

  @override
  State<EntryVideo> createState() => _EntryVideoState();
}

class _EntryVideoState extends State<EntryVideo> {
  // late VideoPlayerController _videoPlayerController;
  // bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url))
    //   ..initialize().then((_) {
    //     setState(() {
    //       _isInitialized = true;
    //     });
    //     _videoPlayerController.play();
    //   });
  }

  @override
  void dispose() {
    // _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget view = CardView(
      borderRadius: 12,
      color: AppColors.black04,
      padding: EdgeInsets.all(12),
      child: Row(children: [
        CardView(width: 56, height: 56,
          color: AppColors.black04,
          borderRadius: 6,
          padding: EdgeInsets.all(12),
          child: Stack(children: [
            CardView(
              borderRadius: 99,
              width: 32, height: 32,child: const SizedBox.shrink(),
            ),
            Center(child: SizedBox(
              width: 20, height: 20,
              child: SvgPicture.asset(SvgIcons.play, width: 18, height: 18, fit: BoxFit.contain,),
            ),)
          ],),
        ),
        const SizedBox(width: 12,),
        Expanded(child: Column(children: [
          PgText(getFileNameFromUrl(widget.url), style: AppTextStyles.M15),
          const SizedBox(height: 4,),
          PgText(widget.url, style: AppTextStyles.R13B50),
        ],))
      ],)
    );
    return Column(children: [
      const SizedBox(height: 8,),
      InkWell(child: view, onTap: () => Open.browser(widget.url)),
      const SizedBox(height: 8,),
    ],);
    // if (!_isInitialized) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    // return AspectRatio(
    //   aspectRatio: _videoPlayerController.value.aspectRatio,
    //   child: VideoPlayer(_videoPlayerController),
    // );
  }

  String getFileNameFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path; // /codrops/wp-content/uploads/2025/06/video-13.mp4
    return path.split('/').last; // video-13.mp4
  }
}
