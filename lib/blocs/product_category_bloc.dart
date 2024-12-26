import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

class ProductCategoryBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  List<ProductVO> products = [];
  int? subCategoryId;

  ProductCategoryBloc(this.subCategoryId) {
    ///get data from database
    var authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "";

    ///get product list
    _smileShopModel.searchProductsBySubCategoryId(authToken, kAcceptLanguageEn,endUserId,1,subCategoryId ?? 0).then((productResponse){
      products = productResponse;
      notifyListeners();
    });
  }
}
