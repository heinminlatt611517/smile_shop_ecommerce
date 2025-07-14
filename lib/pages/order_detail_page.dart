import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/order_detail_bloc.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/list_items/my_order_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/delivery_stepper_view.dart';
import 'package:smile_shop/widgets/loading_view.dart';
import 'package:smile_shop/localization/app_localizations.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({
    super.key,
    required this.orderNumber,
  });

  // final String orderStatus;
  final String orderNumber;
  // final List<DeliveryHistoryVO> deliveryHistory;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderDetailBloc(orderNumber),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          toolbarHeight: 60,
          title: Text(AppLocalizations.of(context)?.order ?? ''),
        ),
        body: Consumer<OrderDetailBloc>(
          builder: (context, bloc, child) => bloc.isLoading == true
              ? const LoadingView(
                  indicator: Indicator.ballBeat, indicatorColor: kPrimaryColor)
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Visibility(
                                visible:
                                    bloc.orderDetails?.getStatus() == "paid",
                                child: const Icon(
                                  Icons.local_shipping,
                                  color: kFillingFastColor,
                                ),
                              ),
                              Visibility(
                                visible:
                                    bloc.orderDetails?.getStatus() == "paid",
                                child: const SizedBox(
                                  width: 24,
                                ),
                              ),
                              Visibility(
                                visible:
                                    bloc.orderDetails?.getStatus() == "paid",
                                child: Text(
                                  AppLocalizations.of(context)
                                          ?.yourOrderIsOnTheWay ??
                                      '',
                                  style:
                                      const TextStyle(fontSize: kTextRegular),
                                ),
                              ),
                              Visibility(
                                visible:
                                    bloc.orderDetails?.getStatus() == "cancel",
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .yourOrderIsCanceled,
                                  style:
                                      const TextStyle(fontSize: kTextRegular),
                                ),
                              ),
                              Visibility(
                                visible: bloc.orderDetails?.getStatus() ==
                                    "delivered",
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .yourOrderHasBeenDeliveredOn,
                                  style:
                                      const TextStyle(fontSize: kTextRegular),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: kFillingFastColor,
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bloc.orderDetails?.addressVO?.address ?? "",
                                    style:
                                        const TextStyle(fontSize: kTextRegular),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          bloc.orderDetails?.addressVO?.phone ??
                                              "",
                                          style: const TextStyle(
                                              fontSize: kTextRegular),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),

                        Visibility(
                          visible: bloc.orderDetails?.paymentType?.toString() ==
                                  "cod" ||
                              bloc.orderDetails?.paymentType?.toLowerCase() ==
                                  "cash on delivery",
                          child: const Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.payments,
                                  color: kFillingFastColor,
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                Text(
                                  "Cash On Delivery",
                                  style: TextStyle(fontSize: kTextRegular),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bloc.orderDetails?.orderProducts?.length,
                          itemBuilder: (context, index) {
                            return MyOrderListItemView(
                              isRefundView: false,
                              orderVO: bloc.orderDetails,
                              orderProductVO:
                                  bloc.orderDetails?.orderProducts?[index],
                              hideButton: true,
                              onTapRefund: (orderNo) {},
                              onTapReview: (orderNo) {},
                            );
                          },
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        const OrderSummarySection(),

                        const SizedBox(
                          height: 16,
                        ),

                        ///stepper
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMarginMedium, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                        ?.yourOrderTracking ??
                                    '',
                                style:
                                    const TextStyle(fontSize: kTextRegular2x),
                              ),
                              const SizedBox(
                                height: kMarginMedium,
                              ),
                              DeliveryStepperView(
                                deliveryList:
                                    bloc.orderDetails?.deliveryHistory ?? [],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 50,
                        ),
                        //button
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<OrderDetailBloc, OrderVO?>(
      selector: (context, bloc) => bloc.orderDetails,
      builder: (context, detail, child) => detail == null
          ? const SizedBox.shrink()
          : Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kMarginMedium2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)?.orderSummary ?? '',
                          style: const TextStyle(fontSize: kTextRegular2x),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product Price (${detail.orderProducts?.length} item)",
                              style: const TextStyle(fontSize: kTextRegular),
                            ),
                            Text(
                              "Ks ${detail.subtotal}",
                              style: const TextStyle(fontSize: kTextRegular),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)?.coupon ?? '',
                              style: const TextStyle(
                                  fontSize: kTextRegular, color: kPrimaryColor),
                            ),
                            Text(
                              "-Ks ${detail.couponDiscountAmount ?? 0}",
                              style: const TextStyle(
                                  fontSize: kTextRegular, color: kPrimaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)?.deliveryFee ?? '',
                              style: const TextStyle(fontSize: kTextRegular),
                            ),
                            Text(
                              "Ks ${detail.deliveryFee ?? 0}",
                              style: const TextStyle(fontSize: kTextRegular),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)?.promotionPoint ??
                                  '',
                              style: const TextStyle(
                                  fontSize: kTextRegular, color: kPrimaryColor),
                            ),
                            Text(
                              "- ${detail.usedPoints ?? 0} pt",
                              style: const TextStyle(
                                  fontSize: kTextRegular, color: kPrimaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMarginMedium2, vertical: kMarginMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.total ?? '',
                          style: const TextStyle(fontSize: kTextRegular),
                        ),
                        Text(
                          "Ks ${detail.getTotalFees()}",
                          style: const TextStyle(fontSize: kTextRegular),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
