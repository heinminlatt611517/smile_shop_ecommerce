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
  final int currentIndex;
  final Function(int currentIndex) onTapPayment;
  final Function(int subPaymentIndex) onTapSubPayment;
  final bool Function(int subPaymentIndex) isSelectedSubPayment;

  const PaymentMethodListItemView({
    super.key,
    this.paymentVO,
    this.isLastIndex,
    this.isSelected,
    required this.onTapPayment,
    required this.currentIndex,
    required this.onTapSubPayment,
    required this.isSelectedSubPayment,
  });

  @override
  Widget build(BuildContext context) {
    return isLastIndex == true
        ? GestureDetector(
            onTap: () {
              onTapPayment(currentIndex);
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: isSelected == true ? kPrimaryColor : Colors.transparent), borderRadius: BorderRadius.circular(kMarginMedium)),
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: kMargin25, vertical: kMarginMedium2),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      CachedNetworkImageView(imageHeight: 45, imageWidth: 45, imageUrl: paymentVO?.image ?? errorImageUrl),
                      const SizedBox(
                        width: kMargin25,
                      ),
                      Text(paymentVO?.name ?? ""),
                    ],
                  ),
                  const SizedBox(
                    height: kMarginLarge,
                  ),

                  /// Sub payment view
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: paymentVO?.subPaymentVO?.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 85,
                      mainAxisSpacing: 40,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          onTapSubPayment(index);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start, // Center vertically
                          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
                          children: [
                            Container(
                              height: 45,
                              width: 50,
                              padding: const EdgeInsets.all(3),
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: isSelectedSubPayment(index) ? kPrimaryColor : Colors.transparent,
                                ),
                              ),
                              child: CachedNetworkImageView(
                                imageHeight: 45,
                                imageWidth: 45,
                                imageUrl: paymentVO?.subPaymentVO?[index].image ?? errorImageUrl,
                              ),
                            ),
                            // Centering text horizontally and vertically
                            Padding(
                              padding: const EdgeInsets.only(top: 5), // Optional: Adjust spacing between image and text
                              child: Text(
                                paymentVO?.subPaymentVO?[index].getCodeFormatted() ?? "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: kTextSmall,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: isSelected == true ? kPrimaryColor : Colors.transparent), borderRadius: BorderRadius.circular(kMarginMedium)),
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
