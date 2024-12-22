import 'package:flutter/material.dart';
import 'package:smile_shop/list_items/my_order_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text('Order Detail'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your order is shipping.',
                style: TextStyle(fontSize: kTextRegular),
              ),
              SizedBox(
                height: 30,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.car_rental_outlined,
                      color: kFillingFastColor,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Text(
                      'Your order is on the way.',
                      style: TextStyle(fontSize: kTextRegular),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: kFillingFastColor,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Smile Shop',
                              style: TextStyle(fontSize: kTextRegular),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                '09888888888',
                                style: TextStyle(fontSize: kTextRegular),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'No 34, Baho Road, Hlaing Township',
                          style: TextStyle(fontSize: kTextRegular),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MyOrderListItemView(
                isRefundView: true,
              ),
              SizedBox(
                height: 20,
              ),

              ///todo
              ///stepper

              SizedBox(
                height: 50,
              ),
              //button
            ],
          ),
        ),
      ),
    );
  }
}


