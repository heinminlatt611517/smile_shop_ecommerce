import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/pages/sign_up_page.dart';
import 'package:smile_shop/pages/splash_page.dart';
import 'package:smile_shop/utils/fonts.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const SmileShopApp());
}

class SmileShopApp extends StatelessWidget {
  const SmileShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              primary: const Color.fromRGBO(255, 255, 255, 1.0)),
          useMaterial3: true,
          fontFamily: kInter),
      home: const SignUpPage(),
    );
  }
}
