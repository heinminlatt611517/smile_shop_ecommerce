import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smile_shop/widgets/promotion_point_view.dart';

import '../pages/product_details_page.dart';

class FavouriteListItemView extends StatelessWidget {
  final ProductVO? productVO;
  final Function(ProductVO? product) onTapFavourite;
  const FavouriteListItemView({super.key,this.productVO,required this.onTapFavourite});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  ProductDetailsPage(productId: productVO?.id.toString() ?? "",),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        height: 140,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding:const EdgeInsets.symmetric(horizontal: kMarginMedium),
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(kMarginMedium)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: (){
                          onTapFavourite(productVO);
                        },
                        child:const Icon(Icons.favorite,color: kPrimaryColor,)),
                    const SizedBox(
                      height: kMarginMedium,
                    ),
                    Row(
                      children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:  CachedNetworkImageView(
                            imageHeight: 80,
                            imageWidth: 80,
                            imageUrl:productVO?.image ?? errorImageUrl),
                      ),
                      const SizedBox(
                        width: kMarginMedium3,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              productVO?.name ?? "",
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style:const TextStyle(
                                  fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: kMargin10,
                            ),
                            Row(
                              children: [
                                 Expanded(
                                   child: Text(
                                     maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    productVO?.subcategory?.name ?? "",
                                    style:const TextStyle(
                                        color: kTpinTextColor, fontSize: kTextSmall),
                                                                 ),
                                 ),
                              ],
                            ),
                            const SizedBox(
                              height: kMargin10,
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "Ks ${productVO?.price.toString() ?? ""}",
                                  style:const TextStyle(fontSize: kTextRegular2x),
                                ),
                                const SizedBox(
                                  width: kMargin30,
                                ),
                                 PromotionPointView(point: productVO?.variantVO?.first.promotionPoint ?? 0,)
                              ],
                            ),
                          ],
                        ),
                      )
                    ],),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
