import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';

import '../network/api_constants.dart';
import '../network/requests/favourite_product_request.dart';

class MyFavouriteBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///Products to show
  List<ProductVO> favouriteProductList = [];
  StreamSubscription? _productListSubscription;
  bool isDisposed = false;
  var currentLanguage = kAcceptLanguageEn;
  bool isLoading = false;
  var authToken = "";
  var accessToken = "";

  MyFavouriteBloc() {
    ///first time get products from database
    firstTimeGetProductsFromDatabase();

    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    ///get products from database
    _productListSubscription =
        _smileShopModel.getFavouriteProductFromDatabase().listen((products) {
      favouriteProductList = products.where((product) => product.isFavourite == true).toList();
      _notifySafely();
    });

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
    _showLoading();
    _smileShopModel
        .getFavouriteProducts(accessToken, currentLanguage)
        .then((productResponse) {
      favouriteProductList = productResponse;
      _notifySafely();
    }).whenComplete(() => _hideLoading());
  }

  void firstTimeGetProductsFromDatabase() {
    favouriteProductList = _smileShopModel
        .firstTimeGetFavouriteProductFromDatabase()
        .where((product) => product.isFavourite == true).toList();
    _notifySafely();
  }

  void onTapFavourite(ProductVO? productVO,BuildContext context) {
    if (productVO == null) return;
    var favoriteProductRequest = FavouriteProductRequest(
      productId: productVO.id,
      status: productVO.isFavouriteProduct == true ? 'unfavourite' : 'favourite',
    );

    _smileShopModel
        .addFavouriteProduct(
      accessToken,
      kAcceptLanguageEn,
      favoriteProductRequest,
    )
        .then((response) {
      if (response.status == 200) {
        _showLoading();
        _smileShopModel
            .getFavouriteProducts(accessToken, currentLanguage)
            .then((productResponse) {
          favouriteProductList = productResponse;
          _notifySafely();
        }).whenComplete(() => _hideLoading());
      }
    }).catchError((error) {
      showSnackBar(context, 'Error updating favourite status', Colors.red);
    });
    // _smileShopModel.deleteFavouriteProductById(productVO?.id ?? 0);
    // firstTimeGetProductsFromDatabase();
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


  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  @override
  void dispose() {
    super.dispose();
    _productListSubscription?.cancel();
    isDisposed = true;
  }
}
