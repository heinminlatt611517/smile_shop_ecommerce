import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/order_detail_bloc.dart';
import 'package:smile_shop/list_items/my_order_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/delivery_stepper_view.dart';
import 'package:smile_shop/widgets/loading_view.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage(
      {super.key, required this.orderNumber, required this.orderStatus});

  final String orderStatus;
  final String orderNumber;

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
          title: const Text('Order Detail'),
        ),
        body: Consumer<OrderDetailBloc>(
          builder: (context, bloc, child) =>
          bloc.isLoading == true
              ? const LoadingView(
              indicator: Indicator.ballBeat, indicatorColor: kPrimaryColor)
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Visibility(
                visible: orderStatus == "delivered",
                  child: const Text(
                    'Your order is completed.',
                    style: TextStyle(fontSize: kTextRegular),
                  ),
                ),
                Visibility(
                  visible: orderStatus == "cancel",
                  child: const Text(
                    'Your order is canceled.',
                    style: TextStyle(fontSize: kTextRegular),
                  ),
                ),
                Visibility(
                  visible: orderStatus == "paid",
                  child: const Text(
                    'Your order is shipping.',
                    style: TextStyle(fontSize: kTextRegular),
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
                        Icons.car_rental_outlined,
                        color: kFillingFastColor,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Visibility(
                        visible: orderStatus == "paid",
                        child: const Text(
                          'Your order is on the way.',
                          style: TextStyle(fontSize: kTextRegular),
                        ),
                      ),
                      Visibility(
                        visible: orderStatus == "cancel",
                        child: const Text(
                          'Your order is canceled.',
                          style: TextStyle(fontSize: kTextRegular),
                        ),
                      ),
                      Visibility(
                        visible: orderStatus == "delivered",
                        child: const Text(
                          'Your order has been delivered on.',
                          style: TextStyle(fontSize: kTextRegular),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                          padding:const EdgeInsets.only(right: 20),
                          child: Text(
                          bloc.orderDetails?.addressVO?.phone ?? "",
                          style:const TextStyle(fontSize: kTextRegular),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    bloc.orderDetails?.addressVO?.address ?? "",
                    style:const TextStyle(fontSize: kTextRegular),
                  ),
                  ],
                ))
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        MyOrderListItemView(
          isRefundView: true,
          orderVO: bloc.orderDetails,
          onTapRefund: (orderNo) {

          },
          onTapReview: (orderNo) {},
        ),
        const SizedBox(
          height: 20,
        ),

        ///stepper
        Visibility(
          visible: orderStatus == "ongoing" || orderStatus == "paid",
          child: const Text(
            'Your Order Tracking',
            style: TextStyle(fontSize: kTextRegular2x),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Visibility(
            visible: orderStatus == "ongoing" || orderStatus == "paid",
            child: const DeliveryStepperView()),

        const SizedBox(
          height: 50,
        ),
        //button
        ],
      ),
    ),)
    ,
    )
    ,
    )
    ,
    );
  }
}


