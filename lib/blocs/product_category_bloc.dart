import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

class ProductCategoryBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  int pageNumber = 1;
  List<ProductVO> products = [];
  int? subCategoryId;
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
    getProducts();
  }

  void getProducts() async {
    isLoading = true;
    notifyListeners();

    ///get data from database
    var authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ?? "";

    ///get product list
    await _smileShopModel.searchProductsBySubCategoryId(authToken, kAcceptLanguageEn, endUserId, pageNumber, subCategoryId ?? 0).then((productResponse) {
      pageNumber += 1;
      products.addAll(productResponse);
    });

    isLoading = false;
    notifyListeners();
  }

  void onTapFavourite(ProductVO? product, BuildContext context) {
    _smileShopModel.saveFavouriteProductToHive(product?.copyWith(isFavourite: true) ?? ProductVO());

    showSnackBar(context, '${product?.name} added to favourite successfully!', Colors.green);
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
}
