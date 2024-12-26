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

  SubCategoryBloc(int categoryId) {
    ///get data from database
    var authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "";
    var subCategoryRequest = SubCategoryRequest(categoryId: categoryId);

    ///get sub category list
    _smileShopModel
        .subCategoryByCategory(authToken, kAcceptLanguageEn, subCategoryRequest)
        .then((subCategoriesResponse) {
      subCategories = subCategoriesResponse;
      notifyListeners();
    });

    ///get product list
    _smileShopModel
        .searchProductsCategoryId(
            authToken, kAcceptLanguageEn, endUserId, 1, categoryId)
        .then((productResponse) {
      products = productResponse;
      notifyListeners();
    });
  }
}
