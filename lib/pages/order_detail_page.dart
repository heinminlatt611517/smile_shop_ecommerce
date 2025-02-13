import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/order_detail_bloc.dart';
import 'package:smile_shop/data/vos/delivery_history_vo.dart';
import 'package:smile_shop/list_items/my_order_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/delivery_stepper_view.dart';
import 'package:smile_shop/widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              ? const LoadingView(indicator: Indicator.ballBeat, indicatorColor: kPrimaryColor)
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: bloc.orderDetails?.getStatus() == "delivered",
                          child: Text(
                            AppLocalizations.of(context)?.yourOrderIsCompleted ?? '',
                            style: const TextStyle(fontSize: kTextRegular),
                          ),
                        ),
                        Visibility(
                          visible: bloc.orderDetails?.getStatus() == "cancel",
                          child: Text(
                            AppLocalizations.of(context)!.yourOrderIsCanceled,
                            style: const TextStyle(fontSize: kTextRegular),
                          ),
                        ),
                        Visibility(
                          visible: bloc.orderDetails?.getStatus() == "paid",
                          child: Text(
                            AppLocalizations.of(context)?.yourOrderIsShipping ?? '',
                            style: const TextStyle(fontSize: kTextRegular),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.local_shipping,
                                color: kFillingFastColor,
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              Visibility(
                                visible: bloc.orderDetails?.getStatus() == "paid",
                                child: Text(
                                  AppLocalizations.of(context)?.yourOrderIsOnTheWay ?? '',
                                  style: const TextStyle(fontSize: kTextRegular),
                                ),
                              ),
                              Visibility(
                                visible: bloc.orderDetails?.getStatus() == "cancel",
                                child: Text(
                                  AppLocalizations.of(context)!.yourOrderIsCanceled,
                                  style: const TextStyle(fontSize: kTextRegular),
                                ),
                              ),
                              Visibility(
                                visible: bloc.orderDetails?.getStatus() == "delivered",
                                child: Text(
                                  AppLocalizations.of(context)!.yourOrderHasBeenDeliveredOn,
                                  style: const TextStyle(fontSize: kTextRegular),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Smile Shop',
                                        style: TextStyle(fontSize: kTextRegular),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Text(
                                          bloc.orderDetails?.addressVO?.phone ?? "",
                                          style: const TextStyle(fontSize: kTextRegular),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    bloc.orderDetails?.addressVO?.address ?? "",
                                    style: const TextStyle(fontSize: kTextRegular),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),

                        Visibility(
                          visible: bloc.orderDetails?.paymentType?.toString() == "cod" || bloc.orderDetails?.paymentType?.toString() == "cod",
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          height: 30,
                        ),
                        MyOrderListItemView(
                          isRefundView: true,
                          orderVO: bloc.orderDetails,
                          onTapRefund: (orderNo) {},
                          onTapReview: (orderNo) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        ///stepper
                        Visibility(
                          // visible: bloc.orderDetails?.getStatus() == "on_going" || bloc.orderDetails?.getStatus() == "paid",
                          child: Text(
                            AppLocalizations.of(context)?.yourOrderTracking ?? '',
                            style: const TextStyle(fontSize: kTextRegular2x),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Visibility(
                            // visible: bloc.orderDetails?.getStatus() == "on_going" || bloc.orderDetails?.getStatus() == "paid",
                            child: DeliveryStepperView(
                          deliveryList: bloc.orderDetails?.deliveryHistory ?? [],
                        )),

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
