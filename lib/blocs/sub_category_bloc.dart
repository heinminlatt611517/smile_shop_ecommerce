import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/requests/sub_category_request.dart';

import '../network/requests/favourite_product_request.dart';
import 'package:smile_shop/localization/app_localizations.dart';

class SubCategoryBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  List<SubcategoryVO> subCategories = [];
  List<ProductVO> products = [];
  bool isLoading = false;
  bool isDisposed = false;
  var currentLanguage = kAcceptLanguageEn;
  var authToken = "";
  var endUserId = "";
  var accessToken = "";
  final int categoryId;
  int pageNumber = 1;
  ScrollController scrollController = ScrollController();
  int? minPrice;
  int? maxPrice;

  SubCategoryBloc(this.categoryId, {this.minPrice, this.maxPrice}) {
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          getProducts();
        }
      },
    );

    ///get data from database
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "0";
    _loadLanguage();
  }

  Future<void> getProducts() async {
    ///get data from database
    var authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "0";

    ///get product list
    return _smileShopModel
        .searchProductsCategoryId(accessToken, kAcceptLanguageEn, endUserId,
            pageNumber, categoryId, minPrice, maxPrice)
        .then((productResponse) {
      pageNumber += 1;
      products.addAll(productResponse);
      notifyListeners();
    });
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
        .subCategoryByCategory(accessToken, currentLanguage, subCategoryRequest)
        .then((subCategoriesResponse) {
      subCategories = subCategoriesResponse;
      notifyListeners();
    });

    ///get product list
    _smileShopModel
        .searchProductsCategoryId(accessToken, currentLanguage, endUserId, 1,
            categoryId ?? 0, minPrice, maxPrice)
        .then((productResponse) {
      products = productResponse;
      notifyListeners();
    }).whenComplete(() => _hideLoading());
  }

  void onTapFavourite(ProductVO? product, BuildContext context) {
    if (product == null) return;
    if (endUserId.isEmpty || endUserId == "0") {
      showSnackBar(
          context, AppLocalizations.of(context)!.need_login, Colors.deepOrange);
      return;
    }
    var favoriteProductRequest = FavouriteProductRequest(
      productId: product.id,
      status: product.isFavouriteProduct == true ? 'unfavourite' : 'favourite',
    );

    _smileShopModel
        .addFavouriteProduct(
      accessToken,
      kAcceptLanguageEn,
      favoriteProductRequest,
    )
        .then((response) {
      if (response.status == 200) {
        final updatedProduct = product.copyWith(
          isFavouriteProduct: !(product.isFavouriteProduct ?? false),
        );

        final productIndex = products.indexWhere((p) => p.id == product.id);
        if (productIndex != -1) {
          products[productIndex] = updatedProduct;
        }

        _notifySafely();

        showSnackBar(
          context,
          '${product.name} ${updatedProduct.isFavouriteProduct ?? true ? 'added to' : 'removed from'} favourites!',
          updatedProduct.isFavouriteProduct ?? true ? Colors.green : Colors.red,
        );
      }
    }).catchError((error) {
      showSnackBar(context, 'Error updating favourite status', Colors.red);
    });
  }

  void showSnackBar(
      BuildContext context, String description, Color snackBarColor) {
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

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
