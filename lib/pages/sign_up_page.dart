import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smile_shop/pages/otp_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';

import '../data/dummy_data/country_code.dart';
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
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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

            //input
            normalPhoneTextField(
                controller: phoneController,
                hint: '9+**********',
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
            const TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 21),
                  hintText: 'Enter referral code',
                  hintStyle: TextStyle(color: Colors.grey)),
            ),

            const SizedBox(
              height: kMargin60,
            ),

            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => const OtpPage()));
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kPrimaryColor, borderRadius: BorderRadius.circular(4)),
                child: const Center(
                  child: Text(
                    'Sign Up',
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
                  text: 'If you already have an account.',
                  style:
                      TextStyle(fontSize: kTextRegular, color: Colors.black)),
              TextSpan(
                  text: ' Login',
                  style: const TextStyle(
                      fontSize: kTextRegular, color: kPrimaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      
                    }),
            ]))
          ],
        ),
      )),
    );
  }
}