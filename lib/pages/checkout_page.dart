import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:smile_shop/list_items/cart_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';

import '../widgets/cached_network_image_view.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        surfaceTintColor: kBackgroundColor,
        centerTitle: true,
        title: const Text('Check Out'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 13,
            ),
            CartListItemView(isCheckout: true),
            _BuildAddressView(),
            SizedBox(
              height: 20,
            ),
            _BuildDeliveryOptionView(),
            SizedBox(
              height: 20,
            ),
            _BuildPromotionPointView(),
            SizedBox(
              height: 20,
            ),
            _BuildOrderSummaryView()
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //           builder: (builder) => const OtpPage()));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(4)),
          child: const Center(
            child: Text(
              'Pay Now',
              style: TextStyle(color: kBackgroundColor),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildAddressView extends StatelessWidget {
  const _BuildAddressView();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: kFillingFastColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: const Row(
        children: [
          Text('Address'),
          SizedBox(
            width: 50,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                    child: Text(
                  'No3 Baho Road..',
                  overflow: TextOverflow.ellipsis,
                )),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.chevron_right)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BuildDeliveryOptionView extends StatelessWidget {
  const _BuildDeliveryOptionView();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) => deliveryOptionModalSheet(context));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: kFillingFastColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: const Row(
          children: [
            Text('Delivery Options'),
            SizedBox(
              width: 50,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: Text(
                    'Standard Delivery',
                    overflow: TextOverflow.ellipsis,
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.chevron_right)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BuildOrderSummaryView extends StatelessWidget {
  const _BuildOrderSummaryView();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kFillingFastColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary'),
          SizedBox(
            height: 20,
          ),
          DottedLine(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Order'), Text('Ks 35000')],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Delivery'), Text('Ks 35000')],
          ),
          SizedBox(
            height: 20,
          ),
          DottedLine(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Total'), Text('Ks 35000')],
          ),
        ],
      ),
    );
  }
}

class _BuildPromotionPointView extends StatelessWidget {
  const _BuildPromotionPointView();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) => promotionPointModalSheet(context));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: kFillingFastColor),
            borderRadius: BorderRadius.circular(10)),
        child: const Row(
          children: [
            Text('Promotion Points'),
            SizedBox(
              width: 50,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: Text(
                    '-700',
                    style: TextStyle(color: kFillingFastColor),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.chevron_right)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget deliveryOptionModalSheet(BuildContext context) {
  return Container(
    height: 200,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    width: double.infinity,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            const SizedBox(),
            const Text(
              'Delivery Options',
              style: TextStyle(fontSize: kTextRegular2x),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 18,
                ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 40,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: kFillingFastColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Standard Delivery'), Text('Free')],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: kFillingFastColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Special Delivery'), Text('Ks 3500')],
          ),
        )
      ],
    ),
  );
}

Widget promotionPointModalSheet(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    width: double.infinity,
    child: Column(
      children: [
        const Text(
          'Promotion Point',
          style: TextStyle(fontSize: kTextRegular2x),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Use Promotion'),
                  Row(
                    children: [
                      Text(
                        'use 7000 Points',
                        style: TextStyle(color: Colors.yellow),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.circle_outlined,
                        color: Colors.yellow,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
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
                    width: kMargin25,
                  ),
                  const Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Name',
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: kTextRegular2x,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: kMargin12,
                      ),
                      Row(
                        children: [
                          Text(
                            'Ks 350000',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Ks 28000',
                              style: TextStyle(
                                  color: Colors.yellow, fontSize: kTextSmall))
                        ],
                      )
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: kMargin45,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('No Use'),
                  Icon(
                    Icons.circle_outlined,
                    color: Colors.yellow,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Spacer(),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: kFillingFastColor,
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
              child: Text(
            'Okay',
            style: TextStyle(color: kBackgroundColor),
          )),
        )
      ],
    ),
  );
}
