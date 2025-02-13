import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../widgets/cached_network_image_view.dart';

class MyOrderListItemView extends StatelessWidget {
  const MyOrderListItemView({super.key, required this.isRefundView, this.onTapRefund, this.onTapReview, this.orderVO, this.onTapCancel, this.onTapPayment});

  final bool isRefundView;
  final Function(OrderVO? orderVo)? onTapRefund;
  final Function(int orderId)? onTapReview;
  final Function(int orderId, int subTotal)? onTapPayment;
  final Function(String orderId)? onTapCancel;
  final OrderVO? orderVO;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isRefundView ? 0 : 16, vertical: 13),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Order ID - ${orderVO?.orderNo ?? ''}",
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Visibility(
                visible: orderVO?.paymentType?.toString() == "cod" || orderVO?.paymentType?.toString() == "cod",
                child: const Text(
                  "Cash on Delivery | ",
                  style: TextStyle(fontSize: kTextRegular, color: kFillingFastColor),
                ),
              ),
              Text(
                getStatusMessage(orderVO?.paymentStatus ?? ""),
                style: const TextStyle(color: kFillingFastColor),
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
                child: CachedNetworkImageView(
                  imageHeight: 80,
                  imageWidth: 80,
                  imageUrl: orderVO?.orderProducts?.first.product?.image ?? errorImageUrl,
                ),
              ),
              const SizedBox(
                width: kMarginMedium3,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderVO?.orderProducts?.first.product?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: kMargin10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          'Ks ${orderVO?.orderProducts?.first.price ?? ''}',
                          style: const TextStyle(fontSize: kTextRegular2x),
                        ),
                        const SizedBox(
                          width: kMargin30,
                        ),
                        Text(
                          'Qty: ${orderVO?.orderProducts?.first.qty ?? ''}',
                          style: const TextStyle(fontSize: kTextSmall),
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
                          'Total(${orderVO?.orderProducts?.first.qty ?? ''} item): Ks ${orderVO?.orderProducts?.first.subtotal ?? ''}',
                          style: const TextStyle(fontSize: kTextSmall),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: orderVO?.paymentStatus == "ongoing",
                      child: Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              onTapRefund!(orderVO);
                            },
                            child: Container(
                              height: 26,
                              width: 57,
                              decoration: BoxDecoration(border: Border.all(color: kFillingFastColor), borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                child: Text(
                                  'Refund',
                                  style: TextStyle(fontSize: kTextSmall),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Visibility(
                            visible: false,
                            child: Container(
                              height: 26,
                              width: 68,
                              decoration: BoxDecoration(color: kFillingFastColor, borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                child: Text(
                                  'Review',
                                  style: TextStyle(color: Colors.white, fontSize: kTextSmall),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: orderVO?.deliveryStatus == "delivered",
                          child: InkWell(
                            onTap: () {
                              onTapRefund!(orderVO);
                            },
                            child: Container(
                              height: 36,
                              width: 68,
                              decoration: BoxDecoration(border: Border.all(color: kFillingFastColor), borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                child: Text(
                                  'Refund',
                                  style: TextStyle(fontSize: kTextSmall),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Visibility(
                          visible: orderVO?.paymentStatus != "paid" && orderVO?.paymentStatus != 'cancel',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // const Spacer(),
                              // InkWell(
                              //   onTap: () {
                              //     onTapCancel!(orderVO?.orderNo.toString() ?? "");
                              //   },
                              //   child: Container(
                              //     height: 26,
                              //     width: 57,
                              //     decoration: BoxDecoration(border: Border.all(color: kFillingFastColor), borderRadius: BorderRadius.circular(5)),
                              //     child: const Center(
                              //       child: Text(
                              //         'Cancel',
                              //         style: TextStyle(fontSize: kTextSmall),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   width: 15,
                              // ),
                              InkWell(
                                onTap: () {
                                  onTapPayment!(int.parse(orderVO?.orderNo.toString() ?? ""), int.parse(orderVO?.subtotal.toString() ?? ""));
                                },
                                child: Container(
                                  height: 36,
                                  width: 68,
                                  decoration: BoxDecoration(color: kFillingFastColor, borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                    child: Text(
                                      'Payment',
                                      style: TextStyle(color: Colors.white, fontSize: kTextSmall),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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

String getStatusMessage(String status) {
  switch (status) {
    case 'not_pay':
      return 'To Pay';
    case 'paid':
      return 'To Ship';
    case 'ongoing':
      return 'To Receive';
    case 'delivered':
      return 'Delivered';
    case 'cancel':
      return 'Cancel';
    default:
      return 'Unknown Status';
  }
}
