import 'package:flutter/material.dart';
import 'package:smile_shop/pages/main_page.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../utils/images.dart';
import '../utils/strings.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: kMarginMedium2,
            ),
            Image.asset(
              kAppLogoImage,
              fit: BoxFit.contain,
              height: kSplashAppLogoHeight,
              width: kSplashAppLogoWidth,
            ),
            const SizedBox(
              height: kMarginMedium2,
            ),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  width: kMarginMedium,
                ),
                Text(
                  kLoadingLabel,
                  style: TextStyle(
                      color: kLoadingLabelColor, fontSize: kTextRegular3x),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
