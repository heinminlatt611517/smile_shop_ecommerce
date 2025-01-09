import 'dart:io';

import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/brand_and_category_vo.dart';
import 'package:smile_shop/data/vos/campaign_participant_vo.dart';
import 'package:smile_shop/data/vos/campaign_vo.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/checkIn_vo.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';
import 'package:smile_shop/data/vos/product_response_data_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/state_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/data/vos/township_data_vo.dart';
import 'package:smile_shop/data/vos/user_vo.dart';
import 'package:smile_shop/data/vos/wallet_transaction_vo.dart';
import 'package:smile_shop/data/vos/wallet_vo.dart';
import 'package:smile_shop/network/requests/address_request.dart';
import 'package:smile_shop/network/requests/campaign_detail_request.dart';
import 'package:smile_shop/network/requests/campaign_join_request.dart';
import 'package:smile_shop/network/requests/checkIn_request.dart';
import 'package:smile_shop/network/requests/check_wallet_amount_request.dart';
import 'package:smile_shop/network/requests/check_wallet_password_request.dart';
import 'package:smile_shop/network/requests/dealer_login_request.dart';
import 'package:smile_shop/network/requests/order_cancel_request.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/set_wallet_password_request.dart';
import 'package:smile_shop/network/requests/sub_category_request.dart';
import 'package:smile_shop/network/requests/wallet_transition_request.dart';
import 'package:smile_shop/network/responses/address_response.dart';
import 'package:smile_shop/network/responses/otp_response.dart';
import 'package:smile_shop/network/responses/profile_response.dart';
import 'package:smile_shop/network/responses/set_password_response.dart';
import 'package:smile_shop/network/responses/success_network_response.dart';
import 'package:smile_shop/network/responses/success_payment_response.dart';

import '../requests/login_request.dart';
import '../requests/otp_verify_request.dart';
import '../requests/set_password_request.dart';
import '../responses/login_response.dart';

abstract class SmileShopDataAgent {
  Future<LoginResponse> login(LoginRequest loginRequest);

  Future<LoginResponse> dealerLogin(DealerLoginRequest loginRequest);

  Future register(String invitationCode, String name, String phone,
      String loginPassword, String paymentPassword);

  Future<List<BannerVO>> banners(String acceptLanguage);

  Future<List<CategoryVO>> categories(String type);

  Future<ProductResponseDataVO> products(
      String token, String acceptLanguage, int endUserId, int page);

  Future<ProductVO> getProductDetails(
      String endUserId, String productId, String acceptLanguage, String token);

  Future verifyOtp(OtpVerifyRequest otpVerifyRequest);

  Future<SetPasswordResponse> setPassword(
      SetPasswordRequest setPasswordRequest);

  Future<OtpResponse> requestOtp(OtpRequest otpRequest);

  Future<BrandAndCategoryVO> getBrandsAndCategories(
    String token,
    String acceptLanguage,
    String endUserId,
  );

  Future<List<ProductVO>> searchProductsByName(String token,
      String acceptLanguage, String endUserId, int pageNo, String name);

  Future<List<ProductVO>> searchProductsCategoryId(String token,
      String acceptLanguage, String endUserId, int pageNo, int categoryId);

  Future<List<ProductVO>> searchProductsBySubCategoryId(String token,
      String acceptLanguage, String endUserId, int pageNo, int subCategoryId);

  Future<List<ProductVO>> searchProductsByRating(String token,
      String acceptLanguage, String endUserId, int pageNo, double rating);

  Future<List<ProductVO>> searchProductsByPrice(
      String token,
      String acceptLanguage,
      String endUserId,
      int pageNo,
      int price,
      String operator);

  Future<List<ProductVO>> searchProductsWithDynamicParam(
      String token,
      String acceptLanguage,
      String endUserId,
      int pageNo,
      String? name,
      double? rating,
      int? minRange,
      int? maxRange);

  Future addNewAddress(
      String accessToken, String acceptLanguage, AddressRequest addressRequest);

  Future<List<StateVO>> states();

  Future<TownshipDataVO> townships(int stateId);

  Future<AddressResponse> address(String accessToken, String acceptLanguage);

  Future deleteAddress(String accessToken, int addressId);

  Future editAddress(
      String accessToken, int addressId, AddressRequest addressRequest);

  Future<List<CategoryVO>> addressCategories(String accessToken);

  Future<List<SubcategoryVO>> subCategoryByCategory(String token,
      String acceptLanguage, SubCategoryRequest subCategoryRequest);

  Future<SuccessPaymentResponse> postOrder(String token, String acceptLanguage, int subTotal,
      String paymentType, String itemList, String appType,String paymentData,int usedPoint);

  Future<SuccessPaymentResponse> makePayment(String token, String acceptLanguage,
      String paymentType,String paymentData,String orderNo,String appType);

  Future<List<PaymentVO>> payments(String token, String acceptLanguage,String action);

  Future<List<OrderVO>> orderList(String token, String acceptLanguage);

  Future<List<OrderVO>> getOrderListByOrderType(
      String token, String acceptLanguage, String orderType);

  Future<OrderVO> orderDetails(
      String token, String acceptLanguage, String orderId);

  Future<UserVO> userProfile(String token, String acceptLanguage);

  Future<ProfileResponse> updateProfile(
      String token, String acceptLanguage, String name, File? image);

  Future<ProfileResponse> updateProfileName(
      String token, String acceptLanguage, String name);

  Future<WalletVO> getWallet(String token, String acceptLanguage);

  Future checkWalletAmount(String token, String acceptLanguage,
      CheckWalletAmountRequest checkWalletAmountRequest);

  Future checkWalletPassword(String token, String acceptLanguage,
      CheckWalletPasswordRequest checkWalletPasswordRequest);

  Future<SuccessNetworkResponse> setWalletPassword(String token, String acceptLanguage,
      SetWalletPasswordRequest setWalletPasswordRequest);

  Future<SuccessPaymentResponse> rechargeWallet(String token, String acceptLanguage,
      int total,String paymentType,String appType,String paymentData );

  Future<List<WalletTransactionVO>> getWalletTransactions(
      String token, String acceptLanguage, WalletTransitionRequest walletTransactionRequest);

  Future<CheckInVO> getUserCheckIn(
      String token, String acceptLanguage);

  Future<SuccessNetworkResponse> postUserCheckIn(
      String token, String acceptLanguage, CheckInRequest checkInRequest);

  Future<List<CampaignVo>> getCampaign(
      String token,String acceptLanguage);
  Future<CampaignVo> getCampaignDetail(
      String token,String acceptLanguage,CampaignDetailRequest request);

  Future<void> joinCampaign(
      String token,String acceptLanguage,CampaignJoinRequest request);

  Future<List<CampaignParticipantVo>> getCampaignParticipants(
      String token,String acceptLanguage,CampaignDetailRequest request);

  Future<SuccessNetworkResponse> cancelOrder(
      String token, String acceptLanguage, OrderCancelRequest request);
}
