import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/requests/sub_category_request.dart';

class SubCategoryBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  List<SubcategoryVO> subCategories = [];
  List<ProductVO> products = [];
  bool isLoading = false;
  bool isDisposed = false;
  var currentLanguage = kAcceptLanguageEn;
  var authToken = "";
  var endUserId = "";
  int? categoryId;

  SubCategoryBloc(this.categoryId) {
    ///get data from database
     authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
     endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "";
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode == null) {
      currentLanguage = kAcceptLanguageEn;
    } else if (languageCode == "my") {
      currentLanguage = kAcceptLanguageMM;
    } else if (languageCode == "zh") {
      currentLanguage = kAcceptLanguageCh;
    } else {
      currentLanguage = kAcceptLanguageEn;
    }
    _notifySafely();

    var subCategoryRequest = SubCategoryRequest(categoryId: categoryId);
    _showLoading();
    ///get sub category list
    _smileShopModel
        .subCategoryByCategory(authToken, currentLanguage, subCategoryRequest)
        .then((subCategoriesResponse) {
      subCategories = subCategoriesResponse;
      notifyListeners();
    });

    ///get product list
    _smileShopModel
        .searchProductsCategoryId(
        authToken, currentLanguage, endUserId, 1, categoryId ?? 0)
        .then((productResponse) {
      products = productResponse;
      notifyListeners();
    }).whenComplete(()=> _hideLoading());
  }



  void onTapFavourite(ProductVO? product,BuildContext context){
    _smileShopModel.saveFavouriteProductToHive(
        product?.copyWith(isFavourite: true) ??
            ProductVO());

    showSnackBar(context, '${product?.name} added to favourite successfully!',Colors.green);
  }

  void showSnackBar(BuildContext context, String description,Color snackBarColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(description),
        backgroundColor: snackBarColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}
