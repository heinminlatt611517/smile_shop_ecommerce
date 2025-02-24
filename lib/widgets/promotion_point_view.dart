import 'package:flutter/material.dart';
import 'package:smile_shop/utils/images.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class PromotionPointView extends StatelessWidget {
  final int? point;
  const PromotionPointView({super.key,this.point});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Image.asset(
          kCoinIcon,
          fit: BoxFit.contain,
          height: 14,
          width: 14,
        ),
         Text(
          '$point pt',
          style:const TextStyle(
              fontSize: kTextRegular,
              fontWeight: FontWeight.bold,
              color: kSecondaryColor),
        )
      ],
    );
  }
}
