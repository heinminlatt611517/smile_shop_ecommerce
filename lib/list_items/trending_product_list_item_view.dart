// import 'package:flutter/material.dart';
// import 'package:smile_shop/data/vos/product_vo.dart';
// import 'package:smile_shop/network/api_constants.dart';
// import 'package:smile_shop/pages/product_details_page.dart';
// import 'package:smile_shop/utils/colors.dart';
// import 'package:smile_shop/widgets/cached_network_image_view.dart';
//
// import '../utils/dimens.dart';
//
// class TrendingProductListItemView extends StatelessWidget {
//   final ProductVO? productVO;
//   final String? imageUrl;
//   final Function(ProductVO? productVO) onTapFavourite;
//
//   const TrendingProductListItemView({super.key, this.productVO, this.imageUrl, required this.onTapFavourite});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailsPage(productId: productVO?.id.toString() ?? ""),
//           ),
//         );
//       },
//       child: Container(
//         height: 208,
//         padding: const EdgeInsets.symmetric(vertical: kMarginMedium, horizontal: kMarginMedium),
//         decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: CachedNetworkImageView(
//                     imageHeight: 100,
//                     imageWidth: double.infinity,
//                     imageUrl: productVO?.image ?? errorImageUrl,
//                   ),
//                 ),
//                 Positioned(
//                     top: 10,
//                     right: 20,
//                     child: InkWell(
//                         onTap: () {
//                           onTapFavourite(productVO);
//                         },
//                         child: Icon(productVO?.isFavouriteProduct == true ? Icons.favorite_outlined : Icons.favorite_outline, color: kSecondaryColor))),
//               ],
//             ),
//             Text(
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               productVO?.name ?? "",
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: kTextRegular, height: 3),
//             ),
//             Text(
//               productVO?.subcategory?.name ?? "",
//               style: const TextStyle(fontWeight: FontWeight.normal, fontSize: kTextSmall, color: Colors.grey, height: 1),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Ks ${productVO?.price}',
//                   style: const TextStyle(
//                     height: 3,
//                     fontWeight: FontWeight.bold,
//                     fontSize: kTextRegular,
//                     color: kPrimaryColor,
//                   ),
//                 ),
//                 Text(
//                   '${productVO?.variantVO?.first.redeemPoint ?? 0} pt',
//                   style:const TextStyle(
//                     height: 3,
//                     fontWeight: FontWeight.normal,
//                     fontSize: kTextRegular,
//                     color: kSecondaryColor,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/product_details_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/responsive.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

class TrendingProductListItemView extends StatelessWidget {
  final ProductVO? productVO;
  final String? imageUrl;
  final Function(ProductVO? productVO) onTapFavourite;

  const TrendingProductListItemView(
      {super.key, this.productVO, this.imageUrl, required this.onTapFavourite});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
        padding: EdgeInsets.symmetric(
          vertical:
              Responsive(context).isTablet ? kMarginMedium2 : kMarginMedium,
          horizontal:
              Responsive(context).isTablet ? kMarginMedium2 : kMarginMedium,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize
              .min, // Makes the column take only as much space as needed
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImageView(
                    // Responsive image size
                    imageHeight: screenHeight *
                        (Responsive(context).isTablet ? 0.18 : 0.15),
                    imageWidth: screenWidth, // Full width of the screen
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
                      color: kSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kMargin6),
            Text(
              productVO?.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive(context).isTablet
                    ? kTextRegular18
                    : kTextRegular,
                height: 1.5,
              ),
            ),
            const SizedBox(height: kMargin6),
            Text(
              productVO?.subcategory?.name ?? "",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize:
                    Responsive(context).isTablet ? kTextRegular2x : kTextSmall,
                color: Colors.grey,
                height: 1.2,
              ),
            ),
            const SizedBox(height: kMargin6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Ks ${productVO?.price}',
                    style: TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive(context).isTablet
                          ? kTextRegular18
                          : kTextRegular,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    (productVO?.variantVO?.isNotEmpty ?? false)
                        ? '${productVO?.variantVO?.first.redeemPoint ?? 0} pt'
                        : '0 pt',
                    style: TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.normal,
                      fontSize: Responsive(context).isTablet
                          ? kTextRegular18
                          : kTextRegular,
                      color: kSecondaryColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
