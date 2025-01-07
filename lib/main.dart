import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await GetStorage.init();

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
      providers: [ChangeNotifierProvider(
        create: (_) => MyAddressBloc(),
      ),],
      child: const SmileShopApp()));
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
