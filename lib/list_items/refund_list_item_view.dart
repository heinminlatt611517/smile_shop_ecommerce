import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/refund_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/utils/extensions.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../widgets/cached_network_image_view.dart';

class RefundListItemView extends StatelessWidget {
  final RefundVO? refundVO;
  const RefundListItemView({
    super.key,
    required this.refundVO
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            // height: 24,
            padding:const EdgeInsets.symmetric(horizontal: 25,vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: kFillingFastColor)),
            child:  Center(
              child: Row(
                children: [
                  const Icon(Icons.payment,size: 20,),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Visibility(
                      visible: refundVO?.status == 'approved',
                      child:const Text(
                        'Your payment has been done at Nov 30.',
                        style: TextStyle(fontSize: kTextSmall),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 7,),
           Row(
            children: [
              const Spacer(),
              Text(
                refundVO?.status?.toCapitalized ?? "",
                style:const TextStyle(color: kFillingFastColor),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:  CachedNetworkImageView(
                    imageHeight: 80,
                    imageWidth: 80,
                    imageUrl:
                        refundVO?.image ?? errorImageUrl),
              ),
              const SizedBox(
                width: kMarginMedium3,
              ),
               Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      refundVO?.name.toString() ?? "",
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style:const TextStyle(
                          fontSize: kTextRegular2x,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: kMargin10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          'Ks ${refundVO?.total.toString() ?? ""}',
                          style:const TextStyle(fontSize: kTextRegular2x),
                        ),
                        const SizedBox(
                          width: kMargin30,
                        ),
                        Text(
                          'Qty: ${refundVO?.qty.toString() ?? ""}',
                          style:const TextStyle(fontSize: kTextSmall),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: kMargin10,
                    ),
                     Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Total(1 item): Ks ${refundVO?.total.toString() ?? ""}',
                          style:const TextStyle(fontSize: kTextSmall),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
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
