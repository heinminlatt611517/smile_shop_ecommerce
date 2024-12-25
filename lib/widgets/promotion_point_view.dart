import 'package:flutter/material.dart';
import 'package:smile_shop/utils/images.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class PromotionPointView extends StatelessWidget {
  const PromotionPointView({super.key});

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
        const Text(
          '50 pt',
          style: TextStyle(
              fontSize: kTextSmall,
              fontWeight: FontWeight.bold,
              color: kSecondaryColor),
        )
      ],
    );
  }
}
