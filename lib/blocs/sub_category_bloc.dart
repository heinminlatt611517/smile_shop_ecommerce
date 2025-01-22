import 'package:flutter/material.dart';
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
  int pageNumber = 1;
  final int categoryId;
  ScrollController scrollController = ScrollController();

  SubCategoryBloc(this.categoryId) {
    scrollController.addListener(
      () {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          getProducts();
        }
      },
    );

    ///get data from database
    var authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var subCategoryRequest = SubCategoryRequest(categoryId: categoryId);

    _showLoading();

    ///get sub category list
    _smileShopModel.subCategoryByCategory(authToken, kAcceptLanguageEn, subCategoryRequest).then((subCategoriesResponse) {
      subCategories.addAll(subCategoriesResponse);
      notifyListeners();
    });

    getProducts().whenComplete(() => _hideLoading());
  }

  Future<void> getProducts() async {
    ///get data from database
    var authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ?? "";

    ///get product list
    return _smileShopModel.searchProductsCategoryId(authToken, kAcceptLanguageEn, endUserId, pageNumber, categoryId).then((productResponse) {
      pageNumber += 1;
      products.addAll(productResponse);
      notifyListeners();
    });
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
