import 'dart:async';
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

  SearchProductBloc() {
    ///first time get search product list from database
    getFirstTimeSearchProductsFromDatabase();

    ///get data from database
    var authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId =
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
            query, authToken, kAcceptLanguageMM, endUserId);
      }
      else {
        products.clear();
        _notifySafely();
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

      ///check search product is already exist in database
      var searchProductVOByNameFromDatabase =
          _smileShopModel.getSearchProductByNameFromDatabase(query);
      if (searchProductVOByNameFromDatabase == null) {
        var searchProductVO = SearchProductVO(name: query);
        _smileShopModel.addSingleSearchProductToDatabase(searchProductVO);
      }

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
