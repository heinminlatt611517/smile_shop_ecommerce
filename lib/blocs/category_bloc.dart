import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/utils/strings.dart';

class CategoryBloc extends ChangeNotifier {
  bool isDisposed = false;

  List<CategoryVO>? categoryList;
  String currentLanguage = kAcceptLanguageEn;

  final SmileShopModel _model = SmileShopModelImpl();

  CategoryBloc() {
    getCategoryList();
  }

  void getCategoryList() async {
    await loadLanguage();
    await _model.categories('', currentLanguage).then(
      (value) {
        CategoryVO category2000 = CategoryVO(
            name: getBelow3000Text(currentLanguage),
            image: "assets/images/3000.png",
            type: CategoryType.below3000);

        CategoryVO categoryPromotion = CategoryVO(
            name: getPromotionPointText(currentLanguage),
            image: "assets/images/promotions.png",
            type: CategoryType.promotionPoint);

        categoryList = [category2000, ...value, categoryPromotion];
        safeNotifyListeners();
      },
    );
  }

  Future<void> loadLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode == "my") {
      currentLanguage = kAcceptLanguageMM;
    } else if (languageCode == "zh") {
      currentLanguage = kAcceptLanguageCh;
    } else {
      currentLanguage = kAcceptLanguageEn;
    }
    safeNotifyListeners();
  }

  void safeNotifyListeners() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
