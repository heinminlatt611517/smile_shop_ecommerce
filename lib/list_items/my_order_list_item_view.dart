import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../widgets/cached_network_image_view.dart';

class MyOrderListItemView extends StatelessWidget {
  const MyOrderListItemView({super.key, required this.isRefundView,this.onTapRefund,this.onTapReview});
  final bool isRefundView;
  final Function()? onTapRefund;
  final Function()? onTapReview;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: isRefundView ? 0 : 16, vertical: 13),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      child: Column(
        children: [
          isRefundView == true
              ? const SizedBox.shrink()
              : const Row(
                  children: [
                    Spacer(),
                    Text(
                      'To Pay',
                      style: TextStyle(color: kFillingFastColor),
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
                child: const CachedNetworkImageView(
                    imageHeight: 80,
                    imageWidth: 80,
                    imageUrl:
                        'https://media.istockphoto.com/id/1311107708/photo/focused-cute-stylish-african-american-female-student-with-afro-dreadlocks-studying-remotely.jpg?s=612x612&w=0&k=20&c=OwxBza5YzLWkE_2abTKqLLW4hwhmM2PW9BotzOMMS5w='),
              ),
              const SizedBox(
                width: kMarginMedium3,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Name',
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: kTextRegular2x,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: kMargin10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          'Ks 100000.00',
                          style: TextStyle(fontSize: kTextRegular2x),
                        ),
                        SizedBox(
                          width: kMargin30,
                        ),
                        Text(
                          'Qty: 1',
                          style: TextStyle(fontSize: kTextSmall),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: kMargin10,
                    ),
                    const Row(
                      children: [
                        Spacer(),
                        Text(
                          'Total(1 item): Ks 3,500',
                          style: TextStyle(fontSize: kTextSmall),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    isRefundView == true
                        ? Row(
                      children: [
                        const Spacer(),
                        Container(
                          height: 26,
                          width: 57,
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: kFillingFastColor),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                            child: Text(
                              'Refund',
                              style: TextStyle(fontSize: kTextSmall),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 26,
                          width: 68,
                          decoration: BoxDecoration(
                              color: kFillingFastColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                            child: Text(
                              'Review',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: kTextSmall),
                            ),
                          ),
                        )
                      ],
                    )
                        : Row(
                            children: [
                              const Spacer(),
                              Container(
                                height: 26,
                                width: 57,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: kFillingFastColor),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: kTextSmall),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                height: 26,
                                width: 68,
                                decoration: BoxDecoration(
                                    color: kFillingFastColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Center(
                                  child: Text(
                                    'Payment',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: kTextSmall),
                                  ),
                                ),
                              )
                            ],
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





