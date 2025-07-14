import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/cart_item_vo.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smile_shop/widgets/custom_checkbox.dart';
import 'package:smile_shop/widgets/promotion_point_view.dart';

class CartListItemView extends StatelessWidget {
  final CartItemVo? productVO;
  final Function onTapCheck;
  final Function onTapIncreaseQty;
  final Function onTapDecreaseQty;
  const CartListItemView(
      {super.key,
      this.productVO,
      required this.onTapCheck,
      required this.onTapIncreaseQty,
      required this.onTapDecreaseQty});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 18,
              height: 18,
              child: CustomCheckbox(
                  value: productVO?.isSelected ?? false,
                  onChanged: (value) {
                    onTapCheck();
                  })
              // Checkbox(
              //     checkColor: kPrimaryColor,
              //     fillColor: WidgetStateProperty.all(Colors.transparent),
              //     value: productVO?.isSelected ?? false,
              //     onChanged: (value) {
              //       onTapCheck();
              //     }),
              ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kMarginMedium, vertical: kMarginMedium),
              decoration: BoxDecoration(
                  color: kCartItemContainerColor,
                  borderRadius: BorderRadius.circular(kMarginMedium)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      ///minus button
                    ],
                  ),
                  Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImageView(
                              imageHeight: 80,
                              imageWidth: 80,
                              imageUrl: productVO?.image ?? '')),
                      const SizedBox(
                        width: kMarginMedium3,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    productVO?.productName ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: kTextRegular2x,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  width: kMarginSmall,
                                ),
                                PromotionPointView(
                                  point: productVO?.promotionPoint,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: kMarginSmall,
                            ),

                            ///color
                            Row(
                              children: [
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  productVO?.subCategory ?? "",
                                  style: const TextStyle(
                                      color: kTpinTextColor,
                                      fontSize: kTextSmall),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 2,
                            ),

                            // /Color and size
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Color: ${productVO?.color}, Size: ${productVO?.size}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        const TextStyle(fontSize: kTextSmall),
                                  ),
                                )
                                // Expanded(
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //         color: kCartColor.withOpacity(0.4),
                                //         borderRadius: BorderRadius.circular(4)),
                                //     height: 22,
                                //     padding: const EdgeInsets.symmetric(
                                //       horizontal: 8,
                                //     ),
                                //     child: Center(
                                //       child: Text(
                                //         maxLines: 1,
                                //         overflow: TextOverflow.ellipsis,
                                //         'Color: ${productVO?.color}',
                                //         style:
                                //             const TextStyle(fontSize: kTextSmall),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   width: kMargin6 + 1,
                                // ),
                                // Expanded(
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //         color: kCartColor.withOpacity(0.4),
                                //         borderRadius: BorderRadius.circular(4)),
                                //     height: 22,
                                //     padding:
                                //         const EdgeInsets.symmetric(horizontal: 8),
                                //     child: Center(
                                //       child: Text(
                                //         'Size: ${productVO?.size}',
                                //         style:
                                //             const TextStyle(fontSize: kTextSmall),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),

                            const SizedBox(
                              height: kMarginSmall,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Ks ${productVO?.variantPrice?.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      const TextStyle(fontSize: kTextRegular2x),
                                ),
                               const Spacer(),
                               // Add And Remove Button
                                TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      onTapDecreaseQty();
                                    },
                                    child: const Icon(
                                      Icons.remove_circle,
                                      color: kCartColor,
                                      size: 26,
                                    )),
                                const SizedBox(
                                  width: kMarginMedium,
                                ),
                                Text(productVO?.quantity.toString() ?? ""),
                                const SizedBox(
                                  width: kMarginMedium,
                                ),

                                ///increase button
                                TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {
                                      onTapIncreaseQty();
                                    },
                                    child: const Icon(
                                      Icons.add_circle,
                                      color: kCartColor,
                                      size: 26,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
