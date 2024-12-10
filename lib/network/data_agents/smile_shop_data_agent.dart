import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/brand_and_category_vo.dart';
import 'package:smile_shop/data/vos/product_response_data_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/requests/otp_request.dart';

import '../requests/login_request.dart';
import '../responses/login_response.dart';

abstract class SmileShopDataAgent {
  Future<LoginResponse> login(LoginRequest loginRequest);

  Future register(String invitationCode, String name, String phone,
      String loginPassword, String paymentPassword);

  Future<List<BannerVO>> banners();

  Future<ProductResponseDataVO> products(String token, String acceptLanguage,int endUserId,String page);

  Future<ProductVO> getProductDetails(
      String endUserId, String productId, String acceptLanguage, String token);

  Future verifyOtp(
      String endUserId, String code, String deviceId, String fcmToken);

  Future requestOtp(OtpRequest otpRequest);

  Future<BrandAndCategoryVO> getBrandsAndCategories(
    String token,
    String acceptLanguage,
    String endUserId,
  );

  Future<List<ProductVO>> searchProducts(
      String query,String token,String acceptLanguage,String endUserId);
}
