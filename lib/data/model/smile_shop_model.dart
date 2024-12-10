
import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/network/requests/otp_request.dart';

import '../../network/requests/login_request.dart';
import '../../network/responses/login_response.dart';
import '../vos/brand_and_category_vo.dart';
import '../vos/product_response_data_vo.dart';

abstract class SmileShopModel {
  Future<LoginResponse> login(LoginRequest loginRequest);

  Future register(String invitationCode, String name, String phone,
      String loginPassword, String paymentPassword);

  Future<List<BannerVO>> banners();

  Future<ProductResponseDataVO> products(String token,String acceptLanguage,int endUserId,String page);

  Future<ProductVO> getProductDetails(
      String endUserId, String productId, String acceptLanguage, String token);


  Future verifyOtp(String endUserId,String code,String deviceId,String fcmToken);

  Future requestOtp(OtpRequest otpRequest);

  Future<BrandAndCategoryVO> getBrandsAndCategories(
      String token,
      String acceptLanguage,
      String endUserId,
      );

  Future<List<ProductVO>> searchProducts(
      String query,String token,String acceptLanguage,String endUserId);

  ///get data from database
  LoginResponse? getLoginResponseFromDatabase();

  Stream<List<SearchProductVO>> getSearchProductFromDatabase();
  List<SearchProductVO> getFirstTimeSearchProductFromDatabase();
  SearchProductVO? getSearchProductByNameFromDatabase(String name);
  void clearSearchProduct();
  void clearSingleSearchProduct(String name);
  void addSingleSearchProductToDatabase(SearchProductVO searchProductVO);

}
