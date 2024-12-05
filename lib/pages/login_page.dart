import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smile_shop/pages/home_page.dart';
import 'package:smile_shop/pages/main_page.dart';
import 'package:smile_shop/pages/password_page.dart';
import 'package:smile_shop/pages/sign_up_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';

import '../data/dummy_data/country_code.dart';
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
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 116,),
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

              normalPhoneTextField(
                  controller: phoneController,
                  hint: 'Enter phone number',
                  phoneCode: "${selectedCountry.name} ${selectedCountry.code}",
                  context: context,
                  onChanged: (val) {
                    setState(() {
                      selectedCountry = val!;
                    });
                  }),

              const SizedBox(
                height: kMargin30,
              ),
              // referal
              SizedBox(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: kMarginMedium2),
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
                    const Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 21),
                            hintText: 'Type your password',
                            hintStyle: TextStyle(color: Colors.grey)),
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (builder) => const MainPage()));
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

              //
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: 'If you don\'t have an account.',
                    style:
                        TextStyle(fontSize: kTextRegular, color: Colors.black)),
                TextSpan(
                    text: ' Sign Up.',
                    style: const TextStyle(
                        fontSize: kTextRegular, color: kPrimaryColor),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (builder) => const SignUpPage()));
                    }),
              ]))
            ],
          ),
        ),
      )),
    );
  }
}
