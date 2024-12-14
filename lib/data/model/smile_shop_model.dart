
import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/set_password_request.dart';
import 'package:smile_shop/network/responses/otp_response.dart';

import '../../network/requests/login_request.dart';
import '../../network/requests/otp_verify_request.dart';
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


  Future verifyOtp(OtpVerifyRequest otpVerifyRequest);

  Future setPassword(SetPasswordRequest setPasswordRequest);

  Future<OtpResponse> requestOtp(OtpRequest otpRequest);

  Future<BrandAndCategoryVO> getBrandsAndCategories(
      String token,
      String acceptLanguage,
      String endUserId,
      );

  Future<List<ProductVO>> searchProductsByName(
      String token,String acceptLanguage,String endUserId,int pageNo,String name);

  Future<List<ProductVO>> searchProductsByRating(
      String token,String acceptLanguage,String endUserId,int pageNo,int rating);

  ///get data from database
  LoginResponse? getLoginResponseFromDatabase();
  Stream<List<SearchProductVO>> getSearchProductFromDatabase();
  List<SearchProductVO> getFirstTimeSearchProductFromDatabase();
  SearchProductVO? getSearchProductByNameFromDatabase(String name);
  void clearSearchProduct();
  void clearSingleSearchProduct(String name);
  void addSingleSearchProductToDatabase(SearchProductVO searchProductVO);

}
