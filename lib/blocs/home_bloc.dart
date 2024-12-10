import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/brand_and_category_vo.dart';
import 'package:smile_shop/data/vos/product_response_data_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

class HomeBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  List<BannerVO> banners = [];
  ProductResponseDataVO? productResponseDataVO;
  BrandAndCategoryVO? brandAndCategoryVO;

  HomeBloc(){
    ///get data from database
    var authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ?? "";

    ///get banner list
    _smileShopModel.banners().then((bannerResponse){
      banners = bannerResponse;
      notifyListeners();
    });

    ///get product list
    _smileShopModel.products(authToken, kAcceptLanguageMM,int.parse(endUserId),"1").then((productResponse){
      productResponseDataVO = productResponse;
      notifyListeners();
    });

    ///get brands and categories
    _smileShopModel.getBrandsAndCategories(authToken, kAcceptLanguageMM,endUserId).then((brandsAndCategoriesResponse){
      brandAndCategoryVO = brandsAndCategoriesResponse;
      notifyListeners();
    });

  }

}
