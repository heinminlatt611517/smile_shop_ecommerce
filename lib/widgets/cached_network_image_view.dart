import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../network/api_constants.dart';

class CachedNetworkImageView extends StatelessWidget {
  final double imageWidth;
  final double imageHeight;
  final String imageUrl;
  final BoxFit? boxFit;
  final bool canView;
  const CachedNetworkImageView({super.key, required this.imageHeight, required this.imageWidth, required this.imageUrl, this.boxFit, this.canView = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: canView? () {
        showDialog(
          context: context,
          builder: (context) => ExpandImageView(url: imageUrl),
        );
      } : null,
      child: CachedNetworkImage(
          width: imageWidth,
          height: imageHeight,
          fit: boxFit ?? BoxFit.cover,
          imageUrl: imageUrl,
          errorWidget: (context, url, error) => Image.network(
                errorImageUrl,
                fit: BoxFit.cover,
              )),
    );
  }
}

class ExpandImageView extends StatelessWidget {
  final String url;
  const ExpandImageView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black87,
        child: Stack(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fitWidth,
              imageUrl: url,
              errorWidget: (context, url, error) => Image.network(
                errorImageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
