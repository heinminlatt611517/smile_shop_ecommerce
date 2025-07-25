import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/signup_bloc.dart';
import 'package:smile_shop/pages/otp_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/localization/app_localizations.dart';

import '../data/dummy_data/country_code.dart';
import '../widgets/common_dialog.dart';
import '../widgets/error_dialog_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/phone_input_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  CountryCode selectedCountry = countries.first;
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignupBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Selector<SignupBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 116,
                      ),
                      Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            kAppLogoImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 58,
                      ),

                      //input
                      Consumer<SignupBloc>(
                        builder: (context, bloc, child) => normalPhoneTextField(
                            controller: phoneController,
                            hint: '09**********',
                            phoneCode:
                                "${selectedCountry.name} ${selectedCountry.code}",
                            context: context,
                            onChangeTextField: (value) {
                              bloc.onPhoneNumberChanged(value);
                            },
                            onChanged: (val) {
                              setState(() {
                                selectedCountry = val!;
                              });
                            }),
                      ),

                      const SizedBox(
                        height: kMargin30,
                      ),
                      // referal
                      Consumer<SignupBloc>(
                        builder: (context, bloc, child) => Container(
                          color: kLoginTextFieldFillColor,
                          height: 55,
                          child: Center(
                            child: TextField(
                              cursorColor: Colors.black,
                              onChanged: (value) {
                                bloc.onReferralCodeChanged(value);
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: kLoginTextFieldFillColor,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 21),
                                  hintText: AppLocalizations.of(context)!
                                      .enterReferralCode,
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kMarginSmall,
                      ),
                      Text(
                        AppLocalizations.of(context)!.leftReferralCodeEmpty,
                        style: const TextStyle(
                          letterSpacing: 0,
                          fontSize: kTextSmall,
                        ),
                      ),
                      const SizedBox(
                        height: kMargin60,
                      ),

                      Consumer<SignupBloc>(
                        builder: (context, bloc, child) => GestureDetector(
                          onTap: () {
                            var bloc =
                                Provider.of<SignupBloc>(context, listen: false);

                            bloc.onTapSignUp().then((value) {
                              if (value.status == 200) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => OtpPage(
                                          requestId:
                                              value.data?.requestId.toString(),
                                          phone: value.data?.to,
                                          referralCode:
                                              value.data?.referralCode,
                                          isFromForgotPasswordPage: false,
                                        )));
                              }
                            }).catchError((error) {
                              showCommonDialog(
                                  context: context,
                                  dialogWidget: ErrorDialogView(
                                      errorMessage: error.toString()));
                            });
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.signUp,
                                style: const TextStyle(color: kBackgroundColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kMargin30,
                      ),

                      //
                      Center(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: AppLocalizations.of(context)!
                                  .ifYouAlreadyHaveAnAccount,
                              style: const TextStyle(
                                  fontSize: kTextRegular, color: Colors.black)),
                          TextSpan(
                              text: ' ${AppLocalizations.of(context)!.login}',
                              style: const TextStyle(
                                  fontSize: kTextRegular, color: kPrimaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                }),
                        ])),
                      )
                    ],
                  ),
                ),
              )),

              ///loading view
              if (isLoading)
                Container(
                  color: Colors.black12,
                  child: const Center(
                    child: LoadingView(
                      indicatorColor: kPrimaryColor,
                      indicator: Indicator.ballSpinFadeLoader,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
