import 'package:flutter/material.dart';
import 'package:smile_shop/pages/main_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';

import '../data/dummy_data/country_code.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
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
            const SizedBox(
              height: kMargin30,
            ),
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
                          hintText: 'Set your password',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kMarginMedium3,
            ),
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
                          hintText: 'Retype your password',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
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
                    'Confirm',
                    style: TextStyle(color: kBackgroundColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
