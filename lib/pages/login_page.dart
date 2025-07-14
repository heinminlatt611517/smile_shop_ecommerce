import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/login_bloc.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/dealer_login_page.dart';
import 'package:smile_shop/pages/forgot_password_page.dart';
import 'package:smile_shop/pages/main_page.dart';
import 'package:smile_shop/pages/sign_up_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/utils/strings.dart';
import 'package:smile_shop/widgets/common_dialog.dart';
import 'package:smile_shop/widgets/error_dialog_view.dart';
import 'package:smile_shop/widgets/input_view_lock_icon.dart';
import 'package:smile_shop/localization/app_localizations.dart';

import '../data/dummy_data/country_code.dart';
import '../widgets/loading_view.dart';
import '../widgets/phone_input_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  CountryCode selectedCountry = countries.first;
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LogInBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Selector<LogInBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      ///dealer
                      Align(
                        alignment: Alignment.centerRight,
                        child: IntrinsicWidth(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) =>
                                      const DealerLoginPage()));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: kMarginSmall,
                                  horizontal: kMarginMedium),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(kMarginMedium),
                                  border: Border.all(
                                    color: Colors.black,
                                  )),
                              child: const Center(
                                child: Column(
                                  children: [
                                    Icon(Icons.face),
                                    Text(
                                      'Dealer',
                                      style: TextStyle(fontSize: kTextSmall),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          kAppLogoImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 58,
                      ),

                      Consumer<LogInBloc>(
                        builder: (context, bloc, child) => normalPhoneTextField(
                            controller: phoneController,
                            hint:
                                AppLocalizations.of(context)!.enterPhoneNumber,
                            phoneCode:
                                "${selectedCountry.name} ${selectedCountry.code}",
                            context: context,
                            onChangeTextField: (v) {
                              bloc.onPhoneNumberChanged(v);
                            },
                            onChanged: (val) {
                              // setState(() {
                              //   selectedCountry = val!;
                              // });
                            }),
                      ),

                      const SizedBox(
                        height: kMargin34,
                      ),

                      ///password input view
                      Consumer<LogInBloc>(
                        builder: (context, bloc, child) => InputViewLockIcon(
                            toggleObscured: () {
                              bloc.onTapShowPassword();
                            },
                            isSecure: bloc.isShowPassword,
                            hintLabel:
                                AppLocalizations.of(context)!.typeYourPassword,
                            onChangeValue: (value) {
                              bloc.onPasswordChanged(value);
                            }),
                      ),

                      const SizedBox(
                        height: kMarginMedium3,
                      ),

                      //forgot password
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) =>
                                        const ForgotPasswordPage()));
                              },
                              child: Text(
                                AppLocalizations.of(context)!.forgotPassword,
                                style: const TextStyle(color: kPrimaryColor),
                              ))
                        ],
                      ),

                      const SizedBox(
                        height: kMargin30,
                      ),

                      GestureDetector(
                        onTap: () {
                          var bloc =
                              Provider.of<LogInBloc>(context, listen: false);

                          bloc.onTapSign().then((value) {
                            if (value.statusCode == 200) {
                              GetStorage()
                                  .write(kBoxKeyLoginUserType, kTypeEndUser);
                              GetStorage().write(kBoxKeyPromotionPoint,
                                  value.data?.data?.promotionPoints ?? 0);
                              bloc.crateFirebaseChatUser(
                                  id: value.data?.data?.id ?? 0,
                                  name: value.data?.data?.name ?? "",
                                  phone: value.data?.data?.phone ?? "");
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (builder) => const MainPage()),
                                  (Route<dynamic> route) => false);
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
                              AppLocalizations.of(context)!.login,
                              style: const TextStyle(color: kBackgroundColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kMargin30,
                      ),

                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: AppLocalizations.of(context)!
                                .ifYouDontHaveAccount,
                            style: const TextStyle(
                                fontSize: kTextRegular, color: Colors.black)),
                        TextSpan(
                            text: AppLocalizations.of(context)!.signUp,
                            style: const TextStyle(
                                fontSize: kTextRegular, color: kPrimaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => const SignUpPage()));
                              }),
                      ]))
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
