import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../network/requests/favourite_product_request.dart';

class ProductCategoryBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  List<ProductVO> products = [];
  int? subCategoryId;
  var currentLanguage = kAcceptLanguageEn;
  var endUserId = "";
  var authToken = "";
  var accessToken = "";
  var isDisposed = false;
  int pageNumber = 1;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  ProductCategoryBloc(this.subCategoryId) {
    scrollController.addListener(
      () {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          getProducts();
        }
      },
    );

    ///get data from database
    authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    accessToken = _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    endUserId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ?? "0";

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
    _smileShopModel.searchProductsBySubCategoryId(accessToken, currentLanguage, endUserId, 1, subCategoryId ?? 0).then((productResponse) {
      products = productResponse;
      _notifySafely();
    }).whenComplete(() => _hideLoading());
  }

  void onTapFavourite(ProductVO? product, BuildContext context) {
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

  Future<void> getProducts() async {
    ///get data from database
    var authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ?? "";

    ///get product list
    await _smileShopModel.searchProductsBySubCategoryId(accessToken, kAcceptLanguageEn, endUserId, pageNumber, subCategoryId ?? 0).then((productResponse) {
      pageNumber += 1;
      products.addAll(productResponse);
    });

    _notifySafely();
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
    isDisposed = true;
    super.dispose();
  }
}
