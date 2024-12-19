import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImageView extends StatelessWidget {
  final String imageName;
  final double? imageHeight;
  final double? imageWidth;
  final Color? iconColor;
  const SvgImageView({super.key,required this.imageName,required this.imageHeight,required this.imageWidth,this.iconColor});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageName,
      height: imageHeight,
      width: imageWidth,
      fit: BoxFit.cover,
      color: iconColor,
    );
  }
}
