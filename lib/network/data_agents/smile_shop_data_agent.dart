import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/brand_and_category_vo.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';
import 'package:smile_shop/data/vos/product_response_data_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/state_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/data/vos/township_data_vo.dart';
import 'package:smile_shop/network/requests/address_request.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/sub_category_request.dart';
import 'package:smile_shop/network/responses/address_response.dart';
import 'package:smile_shop/network/responses/otp_response.dart';

import '../requests/login_request.dart';
import '../requests/otp_verify_request.dart';
import '../requests/set_password_request.dart';
import '../responses/login_response.dart';

abstract class SmileShopDataAgent {
  Future<LoginResponse> login(LoginRequest loginRequest);

  Future register(String invitationCode, String name, String phone,
      String loginPassword, String paymentPassword);

  Future<List<BannerVO>> banners(String acceptLanguage);

  Future<List<CategoryVO>> categories(String type);

  Future<ProductResponseDataVO> products(String token, String acceptLanguage,
      int endUserId, int page);

  Future<ProductVO> getProductDetails(String endUserId, String productId,
      String acceptLanguage, String token);

  Future verifyOtp(OtpVerifyRequest otpVerifyRequest);

  Future setPassword(SetPasswordRequest setPasswordRequest);

  Future<OtpResponse> requestOtp(OtpRequest otpRequest);

  Future<BrandAndCategoryVO> getBrandsAndCategories(String token,
      String acceptLanguage,
      String endUserId,);

  Future<List<ProductVO>> searchProductsByName(String token,
      String acceptLanguage, String endUserId, int pageNo, String name);

  Future<List<ProductVO>> searchProductsByRating(String token,
      String acceptLanguage, String endUserId, int pageNo, double rating);

  Future addNewAddress(String accessToken, String acceptLanguage,
      AddressRequest addressRequest);

  Future<List<StateVO>> states();

  Future<TownshipDataVO> townships(int stateId);

  Future<AddressResponse> address(String accessToken, String acceptLanguage);

  Future deleteAddress(String accessToken, int addressId);

  Future editAddress(String accessToken, int addressId,
      AddressRequest addressRequest);

  Future<List<CategoryVO>> addressCategories(String accessToken);

  Future<List<SubcategoryVO>> subCategoryByCategory(String token,
      String acceptLanguage, SubCategoryRequest subCategoryRequest);

  Future<void> postOrder(String token,
      String acceptLanguage,
      int productId,
      int subTotal,
      int paymentType,
      String itemList);

  Future<List<PaymentVO>> payments(String token, String acceptLanguage);
}
