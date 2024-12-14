import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/login_bloc.dart';
import 'package:smile_shop/pages/main_page.dart';
import 'package:smile_shop/pages/sign_up_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/common_dialog.dart';
import 'package:smile_shop/widgets/error_dialog_view.dart';

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
                        height: 116,
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
                            hint: 'Enter phone number',
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
                        height: kMargin30,
                      ),
                      // referal
                      SizedBox(
                        child: Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: kMarginMedium2),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.lock_outline,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: 1,
                                    height: 34,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Consumer<LogInBloc>(
                                builder: (context, bloc, child) => TextField(
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 21),
                                      hintText: 'Type your password',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  onChanged: (v) {
                                    bloc.onPasswordChanged(v);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: kMarginMedium3,
                      ),

                      //forgot password
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(color: kPrimaryColor),
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
                            if (value.status == 1) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => const MainPage()));
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
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(color: kBackgroundColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kMargin30,
                      ),

                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: 'If you don\'t have an account.',
                            style: TextStyle(
                                fontSize: kTextRegular, color: Colors.black)),
                        TextSpan(
                            text: ' Sign Up.',
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
