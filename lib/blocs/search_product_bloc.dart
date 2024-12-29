import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

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
  var endUserId = "";

  SearchProductBloc() {
    ///first time get search product list from database
    getFirstTimeSearchProductsFromDatabase();

    ///get data from database
     authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
     endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "";

    ///search product history list from database
    _searchProductListSubscription =
        _smileShopModel.getSearchProductFromDatabase().listen((searchResults) {
      searchProducts = searchResults;
      notifyListeners();
    });

    queryStreamController.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen((query) {
      if (query.isNotEmpty) {
        _makeSearchProductNetworkCall(
            query, authToken, kAcceptLanguageEn, endUserId);
      }
      else {
        isScreenLaunch = true;
        products = [];
        notifyListeners();
      }
    });
  }

  void getFirstTimeSearchProductsFromDatabase() {
    searchProducts = _smileShopModel.getFirstTimeSearchProductFromDatabase();
    notifyListeners();
  }

  void _makeSearchProductNetworkCall(
      String query, String authToken, String acceptLanguage, String endUserId) {
    _showLoading();
    _smileShopModel
        .searchProductsByName( authToken, acceptLanguage, endUserId,1,query)
        .whenComplete(() => _hideLoading())
        .then((searchResults) {
      products = searchResults;

      if(searchResults.isNotEmpty){
        ///check search product is already exist in database
        var searchProductVOByNameFromDatabase =
        _smileShopModel.getSearchProductByNameFromDatabase(query);
        if (searchProductVOByNameFromDatabase == null) {
          var searchProductVO = SearchProductVO(name: query);
          _smileShopModel.addSingleSearchProductToDatabase(searchProductVO);
        }
      }
      isScreenLaunch = false;

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

  void onTapRating(double rating){
    debugPrint("Rating::::$rating");
    _smileShopModel
        .searchProductsByRating( authToken, kAcceptLanguageEn, endUserId,1,rating)
        .whenComplete(() => _hideLoading())
        .then((searchResults) {
      products = searchResults;
      if(searchResults.isEmpty){
        isScreenLaunch = false;
        products = [];
      }
      _notifySafely();
    });
  }

  void onTapPrice(int price){
    _smileShopModel
        .searchProductsByPrice( authToken, kAcceptLanguageEn, endUserId,1,price,"")
        .whenComplete(() => _hideLoading())
        .then((searchResults) {
      products = searchResults;
      if(searchResults.isEmpty){
        isScreenLaunch = false;
        products = [];
      }
      _notifySafely();
    });
  }

  bool isChangeBackground(){
    return isShowRatingView == true || isShowPriceView == true ? true : false;
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
