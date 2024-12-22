import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class PaymentMethodListItemView extends StatelessWidget {
  final PaymentVO? paymentVO;
  final bool? isLastIndex;
  final bool? isSelected;
  final Function(int currentIndex) onTapPayment;
  final int currentIndex;

  const PaymentMethodListItemView(
      {super.key,
      this.paymentVO,
      this.isLastIndex,
      this.isSelected,
      required this.onTapPayment,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return isLastIndex == true
        ? GestureDetector(
            onTap: () {
              onTapPayment(currentIndex);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: isSelected == true
                          ? kPrimaryColor
                          : Colors.transparent),
                  borderRadius: BorderRadius.circular(kMarginMedium)),
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(
                  horizontal: kMargin25, vertical: kMarginMedium2),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      CachedNetworkImageView(
                          imageHeight: 45,
                          imageWidth: 45,
                          imageUrl: paymentVO?.image ?? errorImageUrl),
                      const SizedBox(
                        width: kMargin25,
                      ),
                      Text(paymentVO?.name ?? ""),
                    ],
                  ),
                  const SizedBox(
                    height: kMarginLarge,
                  ),

                  ///visa view
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 45,
                        width: 50,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: kFillingFastColor)),
                        child: const CachedNetworkImageView(
                            imageHeight: 45,
                            imageWidth: 45,
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3V1gApW44x8AYf4lZB7KVxWjMupExtAX2OA&s'),
                      ),
                      Container(
                        height: 45,
                        width: 50,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: kFillingFastColor)),
                        child: const CachedNetworkImageView(
                            imageHeight: 45,
                            imageWidth: 45,
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3V1gApW44x8AYf4lZB7KVxWjMupExtAX2OA&s'),
                      ),
                      Container(
                        height: 45,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: kFillingFastColor)),
                        padding: const EdgeInsets.all(3),
                        child: const CachedNetworkImageView(
                            imageHeight: 45,
                            imageWidth: 45,
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3V1gApW44x8AYf4lZB7KVxWjMupExtAX2OA&s'),
                      ),
                      Container(
                        height: 45,
                        width: 50,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: kFillingFastColor)),
                        child: const CachedNetworkImageView(
                            imageHeight: 45,
                            imageWidth: 45,
                            imageUrl:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3V1gApW44x8AYf4lZB7KVxWjMupExtAX2OA&s'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              onTapPayment(currentIndex);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: isSelected == true
                          ? kPrimaryColor
                          : Colors.transparent),
                  borderRadius: BorderRadius.circular(kMarginMedium)),
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: kMargin25),
              height: 70,
              width: double.infinity,
              child: Row(
                children: [
                  Image.network(
                    paymentVO?.image ?? errorImageUrl,
                    height: 45,
                    width: 45,
                  ),
                  const SizedBox(
                    width: kMargin25,
                  ),
                  Text(paymentVO?.name ?? ""),
                ],
              ),
            ),
          );
  }
}
