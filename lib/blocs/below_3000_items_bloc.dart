import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/localization/app_localizations.dart';
import 'package:smile_shop/network/requests/favourite_product_request.dart';

class Below3000ItemsBloc extends ChangeNotifier {
  bool isDisposed = false;
  List<CategoryVO>? categoryList;
  List<ProductVO>? productList;
  String currentLanguage = kAcceptLanguageEn;
  int page = 1;
  ScrollController scrollController = ScrollController();

  final SmileShopModel _model = SmileShopModelImpl();

  Below3000ItemsBloc() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getProductList();
      }
    });
    getCategoryList();
    getProductList();
  }
  void getCategoryList() async {
    await loadLanguage();
    await _model.categories('', currentLanguage).then(
      (value) {
        categoryList = value;
        safeNotifyListeners();
      },
    );
  }

  void getProductList() async {
    String accessToken =
        _model.getLoginResponseFromDatabase()?.accessToken ?? "";
    String endUserId =
        _model.getLoginResponseFromDatabase()?.data?.id.toString() ?? "0";
    await _model
        .searchProductsWithDynamicParam(
      accessToken,
      kAcceptLanguageEn,
      endUserId,
      page,
      null,
      null,
      0,
      3000,
    )
        .then((searchResults) {
      if (productList != null) {
        productList?.addAll(searchResults);
      } else {
        productList = searchResults;
      }
      page++;

      notifyListeners();
    });
  }

  void onTapFavourite(ProductVO? product, BuildContext context) {
    if (product == null) return;
    String accessToken =
        _model.getLoginResponseFromDatabase()?.accessToken ?? "";
    String endUserId =
        _model.getLoginResponseFromDatabase()?.data?.id.toString() ?? "0";

    if (endUserId.isEmpty || endUserId == "0") {
      showSnackBar(
          context, AppLocalizations.of(context)!.need_login, Colors.deepOrange);
      return;
    }
    var favoriteProductRequest = FavouriteProductRequest(
      productId: product.id,
      status: product.isFavouriteProduct == true ? 'unfavourite' : 'favourite',
    );

    _model
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

        final productIndex = productList?.indexWhere((p) => p.id == product.id);
        if (productIndex != -1) {
          productList?[productIndex ?? 0] = updatedProduct;
        }

        safeNotifyListeners();

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

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
