import 'package:flutter/material.dart';
import 'package:smile_shop/pages/order_successful_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        surfaceTintColor: kBackgroundColor,
        centerTitle: true,
        title: const Text('Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose type of payment.'),
            const SizedBox(
              height: kMargin30,
            ),
            MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                removeTop: true,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding:
                            const EdgeInsets.symmetric(horizontal: kMargin25),
                        height: 70,
                        width: double.infinity,
                        child: const Row(
                          children: [
                            CachedNetworkImageView(
                                imageHeight: 45,
                                imageWidth: 45,
                                imageUrl:
                                    'https://play-lh.googleusercontent.com/cnKJYzzHFAE5ZRepCsGVhv7ZnoDfK8Wu5z6lMefeT-45fTNfUblK_gF3JyW5VZsjFc4'),
                            SizedBox(
                              width: kMargin25,
                            ),
                            Text('Kpay'),
                          ],
                        ),
                      );
                    })),
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
            const SizedBox(
              height: kMargin80,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => const OrderSuccessfulPage()));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(4)),
                child: const Center(
                  child: Text(
                    'Check Out',
                    style: TextStyle(color: kBackgroundColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
