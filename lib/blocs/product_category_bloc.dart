import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_response_data_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

class ProductCategoryBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ProductResponseDataVO? productResponseDataVO;

  ProductCategoryBloc() {
    ///get data from database
    var authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "";

    ///get product list
    _smileShopModel.products(authToken, kAcceptLanguageEn,int.parse(endUserId),1).then((productResponse){
      productResponseDataVO = productResponse;
      notifyListeners();
    });
  }
}
