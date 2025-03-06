import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/cart_bloc.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smile_shop/widgets/promotion_point_view.dart';

class CartListItemView extends StatelessWidget {
  final bool isCheckout;
  final ProductVO? productVO;
  const CartListItemView({super.key, required this.isCheckout,this.productVO});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 164,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isCheckout == true
              ? const SizedBox.shrink()
              : SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                checkColor: kPrimaryColor,
                value: productVO?.isChecked ?? false, onChanged: (value){
                            var bloc = Provider.of<CartBloc>(context,
                  listen: false);
                            bloc.onTapChecked(productVO!);
                          }),
              ),
           Visibility(
             visible: isCheckout == false,
             child:const SizedBox(
              width: 10,
             ),
           ),
          Expanded(
            child: Container(
              padding:const EdgeInsets.symmetric(horizontal: kMarginMedium),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(kMarginMedium)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                          imageUrl:productVO?.images?.isNotEmpty ?? true ? productVO?.images?.first ?? errorImageUrl : errorImageUrl),
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
                          ///color
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
                              const SizedBox(
                                width: kMargin6 + 1,
                              ),
                              Expanded(
                                child: Container(
                                  color: kCartColor.withOpacity(0.4),
                                  height: 22,
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child:  Center(
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      'Color Family: ${productVO?.colorName}',
                                      style:const TextStyle(fontSize: kTextSmall),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 2,
                          ),

                          ///size
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                   "",
                                  style:TextStyle(
                                      color: kTpinTextColor, fontSize: kTextSmall),
                                ),
                              ),
                              const SizedBox(
                                width: kMargin6 + 1,
                              ),
                              Container(
                                color: kCartColor.withOpacity(0.4),
                                height: 22,
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child:  Center(
                                  child: Text(
                                    'Size: ${productVO?.size}',
                                    style:const TextStyle(fontSize: kTextSmall),
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
                                overflow: TextOverflow.ellipsis,
                                productVO?.totalPrice.toString() == "0" ? 'Ks ${productVO?.variantVO?.first.price.toString()}' : 'Ks ${productVO?.totalPrice.toString()}',
                                style:const TextStyle(fontSize: kTextRegular2x),
                              ),
                              const SizedBox(
                                width: kMargin30,
                              ),
                              PromotionPointView(point: productVO?.variantVO?.first.promotionPoint ?? 0,)
                            ],
                          ),
                          isCheckout == true
                              ?  Text(
                              'Qty: ${productVO?.qtyCount.toString()}')
                              : const SizedBox.shrink(),

                        ],
                      ),
                    )
                  ],),
                  isCheckout == true
                      ? const SizedBox.shrink()
                      : Row(
                    children: [
                      const Spacer(),
                      ///minus button
                      TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            var bloc = Provider.of<CartBloc>(context,
                                listen: false);
                            bloc.onTapDecreaseQty(productVO!);
                          },
                          child: const Icon(
                            Icons.remove_circle,
                            color: kCartColor,
                            size: 26,
                          )),
                      const SizedBox(
                        width: kMarginMedium,
                      ),
                       Text(productVO?.qtyCount.toString() ?? ""),
                      const SizedBox(
                        width: kMarginMedium,
                      ),

                      ///increase button
                      TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            var bloc = Provider.of<CartBloc>(context,
                                listen: false);
                            bloc.onTapIncreaseQty(productVO!);
                          },
                          child: const Icon(
                            Icons.add_circle,
                            color: kCartColor,
                            size: 26,
                          )),
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
