import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/utils/dimens.dart';

import '../data/dummy_data/accessories_dummy_data.dart';
import '../utils/colors.dart';

class SubCategoryVerticalIconWithLabelView extends StatelessWidget {
  final SubcategoryVO? subcategoryVO;

  const SubCategoryVerticalIconWithLabelView(
      {super.key,this.subcategoryVO});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kMarginMedium)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_bag_rounded,
            color: kPrimaryColor,
            size: 30,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            textAlign: TextAlign.center,
            subcategoryVO?.name ?? "",
            style: const TextStyle(color: Colors.black, fontSize: 12),
          )
        ],
      ),
    );
  }
}
