import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smile_shop/widgets/promotion_point_view.dart';

class CheckOutItem extends StatelessWidget {
  final ProductVO productVO;
  const CheckOutItem({super.key, required this.productVO});

  @override
  Widget build(BuildContext context) {
    print("product vo ==============> ${productVO.toString()}");
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginMedium, vertical: kMarginMedium),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kMarginMedium)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImageView(
                      imageHeight: 80,
                      imageWidth: 80,
                      imageUrl:
                          productVO.variantVO?.first.image ?? '')),
              const SizedBox(
                width: kMarginMedium3,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      productVO.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                          fontSize: kTextRegular2x,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: kMarginSmall,
                    ),

                    ///color
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      productVO.subcategory?.name ?? "",
                      style: const TextStyle(
                          color: kTpinTextColor, fontSize: kTextSmall),
                    ),

                    const SizedBox(
                      height: 2,
                    ),

                    // /color and size
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: kCartColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(4)),
                            height: 22,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Center(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                'Color: ${productVO.variantVO?.first.colorVO?.value ?? ""}',
                                style: const TextStyle(
                                    fontSize: kTextSmall,
                                    color: kCartColorAndSizeColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: kMargin6 + 1,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: kCartColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(4)),
                            height: 22,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                              child: Text(
                                'Size: ${productVO.size ?? ""}',
                                style: const TextStyle(
                                    fontSize: kTextSmall,
                                    color: kCartColorAndSizeColor),
                              ),
                            ),
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
                          "Ks ${productVO.variantVO?.first.price ?? 0}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: kTextRegular2x),
                        ),
                        const SizedBox(
                          width: kMargin30,
                        ),
                        PromotionPointView(
                          point: productVO.variantVO?.first.promotionPoint ?? 0,
                        )
                      ],
                    ),
                    Text('Qty: ${productVO.variantVO?.first.qtyCount ?? 0}')
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
