import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../network/api_constants.dart';

class CachedNetworkImageView extends StatelessWidget {
  final double? imageWidth;
  final double? imageHeight;
  final String imageUrl;
  final BoxFit? boxFit;
  const CachedNetworkImageView({super.key, required this.imageHeight, required this.imageWidth, required this.imageUrl, this.boxFit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        width: imageWidth,
        height: imageHeight,
        fit: boxFit ?? BoxFit.cover,
        imageUrl: imageUrl,
        errorWidget: (context, url, error) => Image.network(
              errorImageUrl,
              fit: BoxFit.cover,
            ));
  }
}
