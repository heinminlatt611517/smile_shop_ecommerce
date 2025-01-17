import 'package:flutter/material.dart';
import 'package:smile_shop/utils/images.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class WelcomeDialogView extends StatelessWidget {
  final Function() onPressOk;
  final String? title;
  final String? message;
  final bool showLoading;

  const WelcomeDialogView(
      {super.key,
      required this.onPressOk,
      required this.title,
      required this.message,
      required this.showLoading});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      surfaceTintColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(kMarginMedium2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 180,
              decoration: const BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kMarginMedium2),
                      topRight: Radius.circular(kMarginMedium2))),
              child: Stack(
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(kMarginMedium2),
                            topRight: Radius.circular(kMarginMedium2))),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            top: 20,
                            child: Image.asset(
                              kWelcomeIcon,
                              width: 125,
                              height: 48,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
              child: Text(
                message ?? "",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ///ok button
            GestureDetector(
              onTap: () {
                onPressOk();
              },
              child: IntrinsicWidth(
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: showLoading == true
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Ok',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
