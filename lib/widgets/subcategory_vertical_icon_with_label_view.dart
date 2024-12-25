import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/utils/dimens.dart';

import '../data/dummy_data/accessories_dummy_data.dart';
import '../network/api_constants.dart';
import '../utils/colors.dart';
import 'cached_network_image_view.dart';

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
          CachedNetworkImageView(
          imageHeight: 45, imageWidth: 45, imageUrl: subcategoryVO?.image ?? errorImageUrl),
          const SizedBox(
            height: 4,
          ),
          Text(
            textAlign: TextAlign.center,
            subcategoryVO?.name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black, fontSize: kTextSmall),
          )
        ],
      ),
    );
  }
}
