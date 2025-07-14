import 'package:flutter/material.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';
import '../pages/login_page.dart';
import '../utils/colors.dart';
import '../utils/dimens.dart';

class SessionExpiredDialogView extends StatelessWidget {

  final SmileShopModel _model = SmileShopModelImpl();

  SessionExpiredDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      surfaceTintColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(kMarginMedium2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kMarginMedium2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(kMarginMedium2),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.timer_off,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Session Expired",
              style: TextStyle(
                fontSize: kTextRegular2x,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Your session has expired. Please log in again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: kTextRegular,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  _model.clearSaveLoginData();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (builder) => const LoginPage()),
                          (Route<dynamic> route) => false);
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Center(
                    child: Text(
                      'Log In Again',
                      style: TextStyle(color: kBackgroundColor),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
