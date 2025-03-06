import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageListDialogView extends StatefulWidget {
  final List<String> imageList;
  final int index;
  final String? video;
  const ImageListDialogView({super.key, required this.imageList, required this.index, this.video});

  @override
  State<ImageListDialogView> createState() => _ImageListDialogViewState();
}

class _ImageListDialogViewState extends State<ImageListDialogView> {
  late PageController pageController;
  VideoPlayerController? playerController;
  ChewieController? chewieController;
  TransformationController _transformationController = TransformationController();
  bool _isZoomed = false;
  final double _zoomScale = 2.5; // Zoom factor
  @override
  void initState() {
    super.initState();
    setState(() {
      // check video is contain , index will be -1
      int realIndex = ((widget.video?.isNotEmpty ?? false)) ? widget.index + 1 : widget.index;
      pageController = PageController(initialPage: realIndex);
    });
    videoInitialized();
  }

  void videoInitialized() async {
    if (widget.video != null) {
      playerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.video ?? ''),
      );
      await playerController!.initialize();
      if (playerController != null) {
        chewieController = ChewieController(
          videoPlayerController: playerController!,
          autoPlay: true,
          aspectRatio: playerController?.value.aspectRatio,
          showOptions: false,
          autoInitialize: true,
        );
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    playerController?.dispose();
    chewieController?.dispose();
    _transformationController.dispose();
  }

  void _resetZoom() {
    setState(() {
      _isZoomed = false;
      _transformationController.value = Matrix4.identity();
    });
  }

  double _getCurrentScale() {
    final matrix = _transformationController.value;
    return sqrt(matrix[0] * matrix[0] + matrix[1] * matrix[1]); // Extract scale from matrix
  }

  void _onDoubleTap(TapDownDetails details, BoxConstraints constraints) {
    if (_isZoomed) {
      _resetZoom();
    } else {
      // Convert tap position to viewport coordinates
      final tapPosition = details.localPosition;
      final x = -tapPosition.dx * (_zoomScale - 1);
      final y = -tapPosition.dy * (_zoomScale - 1);
      final Matrix4 zoomMatrix = Matrix4.identity()
        ..translate(x, y)
        ..scale(_zoomScale);

      setState(() {
        _isZoomed = true;
        _transformationController.value = zoomMatrix;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black87,
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              physics: _isZoomed ? const NeverScrollableScrollPhysics() : const PageScrollPhysics(),
              itemCount: widget.imageList.length + ((widget.video?.isNotEmpty ?? false) ? 1 : 0),
              itemBuilder: (context, index) {
                int realIndex = index - ((widget.video?.isNotEmpty ?? false) ? 1 : 0);
                if (realIndex == -1) {
                  // VIDEO EXISTS

                  return chewieController != null
                      ? LayoutBuilder(builder: (context, constraints) {
                          double videoAspectRatio = playerController?.value.aspectRatio ?? 1;
                          double maxWidth = constraints.maxWidth;
                          double calculatedHeight = maxWidth / videoAspectRatio;

                          return SizedBox(
                            width: maxWidth,
                            height: calculatedHeight,
                            child: Chewie(
                              controller: chewieController!,
                            ),
                          );
                        })
                      // AspectRatio(
                      //     aspectRatio: playerController?.value.aspectRatio ?? 1,
                      //     child: VideoPlayer(
                      //       playerController!,
                      //     ),
                      //   )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        );
                }
                return LayoutBuilder(builder: (context, constraints) {
                  return GestureDetector(
                    onDoubleTapDown: (details) {
                      if (_isZoomed) {
                        _resetZoom();
                      } else {
                        _onDoubleTap(details, constraints);
                      }
                    },
                    child: InteractiveViewer(
                      transformationController: _transformationController,
                      panEnabled: true,
                      scaleEnabled: true,
                      minScale: 1.0,
                      maxScale: 4.0,
                      onInteractionEnd: (details) {
                        double currentScale = _getCurrentScale();
                        if (currentScale < 1.1) {
                          setState(() => _isZoomed = false); // Allow PageView scrolling when nearly normal
                        } else {
                          setState(() => _isZoomed = true); // Disable scrolling when zoomed in
                        }
                      },
                      child: CachedNetworkImage(
                        height: 120,
                        width: double.infinity,
                        // imageBuilder: (context, imageProvider) => PhotoView(
                        //   imageProvider: imageProvider,
                        //   gestureDetectorBehavior: HitTestBehavior.opaque,
                        // ),
                        imageUrl: widget.imageList[realIndex],
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  );
                });
              },
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black38),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    AppLocalizations.of(context)!.doubleTapToZoom,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
