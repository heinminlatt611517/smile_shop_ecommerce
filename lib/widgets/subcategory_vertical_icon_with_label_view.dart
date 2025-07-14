import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/utils/dimens.dart';

import '../network/api_constants.dart';
import 'cached_network_image_view.dart';

class SubCategoryVerticalIconWithLabelView extends StatelessWidget {
  final SubcategoryVO? subcategoryVO;

  const SubCategoryVerticalIconWithLabelView({super.key, this.subcategoryVO});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(kMarginMedium)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // decoration: BoxDecoration(
            //   color: kSecondaryColor,
            //   borderRadius: BorderRadius.circular(kMarginMedium),
            // ),
            padding: const EdgeInsets.all(10),
            child: CachedNetworkImageView(imageHeight: 45, imageWidth: 45, imageUrl: subcategoryVO?.image ?? errorImageUrl),
          ),
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
