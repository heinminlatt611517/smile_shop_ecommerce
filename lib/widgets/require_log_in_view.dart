import 'package:flutter/material.dart';
import 'package:smile_shop/pages/login_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/localization/app_localizations.dart';

class RequireLogInView extends StatelessWidget {
  const RequireLogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(
          horizontal: kMarginMedium2, vertical: kMarginMedium3),
      margin: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: kMarginMedium2,
        children: [
          Text(
            AppLocalizations.of(context)!.need_login,
            style: const TextStyle(
              fontSize: kTextRegular2x,
              fontWeight: FontWeight.w600,
            ),
          ),
          CommonButtonView(
            label: AppLocalizations.of(context)!.login,
            labelColor: Colors.white,
            bgColor: kPrimaryColor,
            onTapButton: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom)
        ],
      ),
    );
  }
}
