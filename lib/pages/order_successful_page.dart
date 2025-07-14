import 'package:flutter/material.dart';
import 'package:smile_shop/pages/main_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/localization/app_localizations.dart';

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
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.thankForShoppingWithUs,
              style: const TextStyle(fontSize: kTextRegular3x),
            ),
            const SizedBox(
              height: 23,
            ),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.weAppreciateYourSupportAndHope,
            ),
            const SizedBox(
              height: 23,
            ),
            CommonButtonView(
                label: AppLocalizations.of(context)!.back,
                labelColor: Colors.white,
                bgColor: kPrimaryColor,
                onTapButton: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (builder) => const MainPage()),
                      (Route<dynamic> route) => false);
                })
          ],
        ),
      ),
    );
  }
}
