import 'package:flutter/material.dart';
import 'package:smile_shop/pages/main_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';

class OrderSuccessfulPage extends StatelessWidget {
  const OrderSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kThankImage,
              width: 194,
              height: 194,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Thanks for shopping with us.',
              style: TextStyle(fontSize: kTextRegular3x),
            ),
            const SizedBox(
              height: 23,
            ),
            const Text(
                'We appreciate your support and hope you enjoy your purchase. Feel free to reach out if you need any assistance. We look forward to serving you again!',textAlign: TextAlign.center,),
            const SizedBox(
              height: 23,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => const MainPage()));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kPrimaryColor, borderRadius: BorderRadius.circular(4)),
                child: const Center(
                  child: Text(
                    'Back',
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
