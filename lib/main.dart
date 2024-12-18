import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/data/vos/user_vo.dart';
import 'package:smile_shop/network/responses/login_response.dart';
import 'package:smile_shop/pages/splash_page.dart';
import 'package:smile_shop/persistence/hive_constants.dart';
import 'package:smile_shop/utils/fonts.dart';
import 'data/vos/login_data_vo.dart';

void main() async {
  await Hive.initFlutter();

  ///register hive adapter
  Hive.registerAdapter(LoginResponseAdapter());
  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(SearchProductVOAdapter());

  ///open hive
  await Hive.openBox<LoginDataVO>(kBoxLoginResponse);
  await Hive.openBox<SearchProductVO>(kBoxSearchProduct);

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
      home: const SplashPage(),
    );
  }
}
