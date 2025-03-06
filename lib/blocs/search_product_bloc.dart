import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';
import '../network/requests/favourite_product_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchProductBloc extends ChangeNotifier {
  ///model
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///Stream controllers
  StreamController<String> queryStreamController = StreamController();

  ///state
  List<ProductVO> products = [];
  List<SearchProductVO> searchProducts = [];
  StreamSubscription? _searchProductListSubscription;
  bool isLoading = false;
  bool isDisposed = false;
  bool isScreenLaunch = true;
  bool isShowRatingView = false;
  bool isShowPriceView = false;
  var authToken = "";
  var accessToken = "";
  var endUserId = "";
  int? minRange;
  int? maxRange;
  double? ratingValue;
  String? queryString;
  var currentLanguage = kAcceptLanguageEn;

  SearchProductBloc() {
    ///first time get search product list from database
    getFirstTimeSearchProductsFromDatabase();

    ///get data from database
    authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    accessToken = _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    endUserId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ?? "0";

    _loadLanguage();

    ///search product history list from database
    _searchProductListSubscription = _smileShopModel.getSearchProductFromDatabase().listen((searchResults) {
      searchProducts = searchResults;
      notifyListeners();
    });

    queryStreamController.stream.debounceTime(const Duration(milliseconds: 800)).listen((query) {
      if (query.isNotEmpty) {
        _makeSearchProductNetworkCall(query, authToken, currentLanguage, endUserId);
      } else {
        isScreenLaunch = true;
        products = [];
        notifyListeners();
      }
    });
  }
  Future<void> _loadLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode == null) {
      currentLanguage = kAcceptLanguageEn;
    } else if (languageCode == "my" || languageCode == "my-MM") {
      currentLanguage = kAcceptLanguageMM;
    } else if (languageCode == "zh") {
      currentLanguage = kAcceptLanguageCh;
    } else {
      currentLanguage = kAcceptLanguageEn;
    }
    _notifySafely();
  }

  void onChangedMinMaxRange(double minRangeValue, double maxRangeValue) {
    if (minRangeValue != 5000.0) {
      minRange = minRangeValue.toInt();
    }
    if (maxRangeValue != 10000.0) {
      maxRange = maxRangeValue.toInt();
    }
    _notifySafely();
  }

  void onChangedRating(double? rating) {
    ratingValue = rating;
    _notifySafely();
  }

  void getFirstTimeSearchProductsFromDatabase() {
    searchProducts = _smileShopModel.getFirstTimeSearchProductFromDatabase();
    notifyListeners();
  }

  void _makeSearchProductNetworkCall(String query, String authToken, String acceptLanguage, String endUserId) {
    _showLoading();
    _smileShopModel.searchProductsByName(accessToken, acceptLanguage, endUserId, 1, query).whenComplete(() => _hideLoading()).then((searchResults) {
      query = query;
      queryString = query;
      products = searchResults;

      if (searchResults.isNotEmpty) {
        ///check search product is already exist in database
        var searchProductVOByNameFromDatabase = _smileShopModel.getSearchProductByNameFromDatabase(query);
        if (searchProductVOByNameFromDatabase == null) {
          var searchProductVO = SearchProductVO(name: query, timeStamp: DateTime.now().toString());
          _smileShopModel.addSingleSearchProductToDatabase(searchProductVO);
        }
      }
      isScreenLaunch = false;

      notifyListeners();
    });
  }

  searchProductByDynamicParam() {
    _showLoading();
    _smileShopModel
        .searchProductsWithDynamicParam(
          accessToken,
          kAcceptLanguageEn,
          endUserId,
          1,
          queryString,
          ratingValue,
          minRange,
          maxRange,
        )
        .whenComplete(() => _hideLoading())
        .then((searchResults) {
      products.clear();
      products = searchResults;
      if (searchResults.isEmpty) {
        isScreenLaunch = false;
        products = [];
      }
      _notifySafely();
      notifyListeners();
    });
  }

  void onTapClearAll() {
    _smileShopModel.clearSearchProduct();
  }

  void onTapClearSingleSearchProduct(String name) {
    _smileShopModel.clearSingleSearchProduct(name);
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  bool isChangeBackground() {
    return isShowRatingView == true || isShowPriceView == true ? true : false;
  }

  void onTapFavourite(ProductVO? product, BuildContext context) {
    // _smileShopModel.saveFavouriteProductToHive(
    //     product?.copyWith(isFavourite: true) ?? ProductVO());
    //
    // showSnackBar(context, '${product?.name} added to favourite successfully!',
    //     Colors.green);
    if (product == null) return;
    if (endUserId.isEmpty || endUserId == "0") {
      showSnackBar(context, AppLocalizations.of(context)!.need_login, Colors.deepOrange);
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

  void showSnackBar(BuildContext context, String description, Color snackBarColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(description),
        backgroundColor: snackBarColor,
        duration: const Duration(seconds: 2),
      ),
    );
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
    queryStreamController.close();
    _searchProductListSubscription?.cancel();
    isDisposed = true;
    super.dispose();
  }
}
