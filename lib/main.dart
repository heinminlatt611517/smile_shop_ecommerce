import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/blocs/app_language_bloc.dart';
import 'package:smile_shop/blocs/my_address_bloc.dart';
import 'package:smile_shop/data/vos/brand_vo.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/color_vo.dart';
import 'package:smile_shop/data/vos/extended_price_vo.dart';
import 'package:smile_shop/data/vos/image_vo.dart';
import 'package:smile_shop/data/vos/inventory_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/refer_code_vo.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/data/vos/size_vo.dart';
import 'package:smile_shop/data/vos/user_vo.dart';
import 'package:smile_shop/data/vos/variant_vo.dart';
import 'package:smile_shop/pages/splash_page.dart';
import 'package:smile_shop/persistence/hive_constants.dart';
import 'package:smile_shop/utils/fonts.dart';
import 'data/vos/login_data_vo.dart';
import 'data/vos/sub_category_vo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';

Future<Locale> _getLocaleData() async {
  var prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('language_code');
  if (languageCode == null) {
    return window.locale;
  } else {
    return Locale(languageCode);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await GetStorage.init();
  Locale locale = await _getLocaleData();

  ///register hive adapter
  Hive.registerAdapter(LoginResponseAdapter());
  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(SearchProductVOAdapter());
  Hive.registerAdapter(ProductVOAdapter());
  Hive.registerAdapter(BrandVOAdapter());
  Hive.registerAdapter(ColorVOAdapter());
  Hive.registerAdapter(ImageVOAdapter());
  Hive.registerAdapter(ExtendedPriceVOAdapter());
  Hive.registerAdapter(InventoryVOAdapter());
  Hive.registerAdapter(SizeVOAdapter());
  Hive.registerAdapter(SubcategoryVOAdapter());
  Hive.registerAdapter(CategoryVOAdapter());
  Hive.registerAdapter(VariantVOAdapter());
  Hive.registerAdapter(ReferVOAdapter());

  ///open hive
  await Hive.openBox<LoginDataVO>(kBoxLoginResponse);
  await Hive.openBox<SearchProductVO>(kBoxSearchProduct);
  await Hive.openBox<ProductVO>(kBoxProduct);
  await Hive.openBox<ProductVO>(kBoxFavouriteProduct);
  await Hive.openBox<UserVO>(kBoxUser);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyAddressBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppLanguageBloc(locale),
        ),
      ],
      child: SmileShopApp(
        language: locale,
      )));
}

class SmileShopApp extends StatelessWidget {
  final Locale language;

  const SmileShopApp({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguageBloc>(
      create: (BuildContext context) => AppLanguageBloc(language),
      child: Consumer<AppLanguageBloc>(
        builder: (context, bloc, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: bloc.appLocal,
          supportedLocales: const [
            Locale('en', ''),
            Locale('my', ''),
            Locale('zh', 'CN'),
          ],
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                  primary: const Color.fromRGBO(255, 255, 255, 1.0)),
              useMaterial3: true,
              fontFamily: kInter),
          themeMode: ThemeMode.light,
          home: const SplashPage(),
        ),
      ),
    );
  }
}

