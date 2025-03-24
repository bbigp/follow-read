


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageGalleryPage extends StatefulWidget {

  final List<String> imageUrls;
  final int initialIndex;

  const ImageGalleryPage({super.key, required this.imageUrls, this.initialIndex = 0});

  @override
  State<ImageGalleryPage> createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageGalleryPage> {


  late PageController _pageController;
  int _currentVirtualIndex = 0;
  final int _maxVirtualPages = 100000; // 虚拟页数，足够大的数值

  @override
  void initState() {
    super.initState();
    // 计算中间位置作为起点
    final middle = (_maxVirtualPages / 2).floor();
    _currentVirtualIndex = middle + widget.initialIndex;
    _pageController = PageController(
      initialPage: _currentVirtualIndex,
      viewportFraction: 1.0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int get _realIndex => _currentVirtualIndex % widget.imageUrls.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        actions: [
          // _buildRefreshButton(ref, feedsState.isSyncing),
          // const SizedBox(width: 12),
        ],
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: _maxVirtualPages, // 关键修改：使用大数虚拟页数
            builder: (context, index) {
              final realIndex = index % widget.imageUrls.length;
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(widget.imageUrls[realIndex]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentVirtualIndex = index;
                // 接近边界时自动跳转回中间
                if (index < 100 || index > _maxVirtualPages - 100) {
                  final newIndex = (_maxVirtualPages / 2).floor() + _realIndex;
                  _pageController.jumpToPage(newIndex);
                }
              });
            },
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            enableRotation: false,
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '${_realIndex + 1}/${widget.imageUrls.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}