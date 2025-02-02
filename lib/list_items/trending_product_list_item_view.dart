import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/product_details_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

import '../utils/dimens.dart';

class TrendingProductListItemView extends StatelessWidget {
  final ProductVO? productVO;
  final String? imageUrl;
  final Function(ProductVO? productVO) onTapFavourite;

  const TrendingProductListItemView(
      {super.key, this.productVO, this.imageUrl, required this.onTapFavourite});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailsPage(productId: productVO?.id.toString() ?? ""),
          ),
        );
      },
      child: Container(
        height: 208,
        padding: const EdgeInsets.symmetric(
            vertical: kMarginMedium, horizontal: kMarginMedium),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImageView(
                    imageHeight: 100,
                    imageWidth: double.infinity,
                    imageUrl: productVO?.image ?? errorImageUrl,
                  ),
                ),
                Positioned(
                    top: 10,
                    right: 20,
                    child: InkWell(
                        onTap: () {
                          onTapFavourite(productVO);
                        },
                        child: Icon(
                            productVO?.isFavouriteProduct == true
                                ? Icons.favorite_outlined
                                : Icons.favorite_outline,
                            color: kSecondaryColor))),
              ],
            ),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              productVO?.name ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: kTextRegular,
                  height: 3),
            ),
            Text(
              productVO?.subcategory?.name ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: kTextSmall,
                  color: Colors.grey,
                  height: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ks ${productVO?.price}',
                  style: const TextStyle(
                    height: 3,
                    fontWeight: FontWeight.bold,
                    fontSize: kTextRegular,
                    color: kPrimaryColor,
                  ),
                ),
                const Text(
                  '100 pt',
                  style: TextStyle(
                    height: 3,
                    fontWeight: FontWeight.normal,
                    fontSize: kTextRegular,
                    color: kSecondaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
