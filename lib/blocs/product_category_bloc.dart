import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

class ProductCategoryBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  List<ProductVO> products = [];
  int? subCategoryId;
  var currentLanguage = kAcceptLanguageEn;
  var endUserId = "";
  var authToken = "";
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
    _smileShopModel
        .searchProductsBySubCategoryId(
            authToken, currentLanguage, endUserId, 1, subCategoryId ?? 0)
        .then((productResponse) {
      products = productResponse;
      notifyListeners();
    });
  }

  void onTapFavourite(ProductVO? product, BuildContext context) {
    _smileShopModel.saveFavouriteProductToHive(
        product?.copyWith(isFavourite: true) ?? ProductVO());

    showSnackBar(context, '${product?.name} added to favourite successfully!',
        Colors.green);
  }

  void getProducts() async {
    // isLoading = true;
    // notifyListeners();

    ///get data from database
    var authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ?? "";

    ///get product list
    await _smileShopModel.searchProductsBySubCategoryId(authToken, kAcceptLanguageEn, endUserId, pageNumber, subCategoryId ?? 0).then((productResponse) {
      pageNumber += 1;
      products.addAll(productResponse);
    });

    //isLoading = false;
    notifyListeners();
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

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
