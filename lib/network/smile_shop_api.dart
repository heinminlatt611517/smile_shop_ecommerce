import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:smile_shop/network/requests/favourite_product_request.dart';
import 'package:smile_shop/network/requests/pop_up_request.dart';
import 'package:smile_shop/network/responses/campaign_history_response.dart';
import 'package:smile_shop/network/requests/address_request.dart';
import 'package:smile_shop/network/requests/campaign_join_request.dart';
import 'package:smile_shop/network/requests/checkIn_request.dart';
import 'package:smile_shop/network/requests/check_wallet_amount_request.dart';
import 'package:smile_shop/network/requests/check_wallet_password_request.dart';
import 'package:smile_shop/network/requests/dealer_login_request.dart';
import 'package:smile_shop/network/requests/login_request.dart';
import 'package:smile_shop/network/requests/order_cancel_request.dart';
import 'package:smile_shop/network/requests/order_status_request.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/set_password_request.dart';
import 'package:smile_shop/network/requests/set_wallet_password_request.dart';
import 'package:smile_shop/network/requests/sub_category_request.dart';
import 'package:smile_shop/network/requests/wallet_transition_request.dart';
import 'package:smile_shop/network/responses/address_categories_response.dart';
import 'package:smile_shop/network/responses/address_response.dart';
import 'package:smile_shop/network/responses/banner_response.dart';
import 'package:smile_shop/network/responses/brands_and_categories_response.dart';
import 'package:smile_shop/network/responses/campaign_detail_response.dart';
import 'package:smile_shop/network/responses/campaign_participant_response.dart';
import 'package:smile_shop/network/responses/campaign_response.dart';
import 'package:smile_shop/network/responses/category_response.dart';
import 'package:smile_shop/network/responses/checkIn_response.dart';
import 'package:smile_shop/network/responses/home_popup_data_response.dart';
import 'package:smile_shop/network/responses/login_response.dart';
import 'package:smile_shop/network/responses/my_team_response.dart';
import 'package:smile_shop/network/responses/order_details_response.dart';
import 'package:smile_shop/network/responses/order_response.dart';
import 'package:smile_shop/network/responses/otp_response.dart';
import 'package:smile_shop/network/responses/package_details_response.dart';
import 'package:smile_shop/network/responses/packages_response.dart';
import 'package:smile_shop/network/responses/payment_response.dart';
import 'package:smile_shop/network/responses/product_details_response.dart';
import 'package:smile_shop/network/responses/product_response.dart';
import 'package:smile_shop/network/responses/profile_response.dart';
import 'package:smile_shop/network/responses/promotion_response.dart';
import 'package:smile_shop/network/responses/refund_reason_response.dart';
import 'package:smile_shop/network/responses/refund_response.dart';
import 'package:smile_shop/network/responses/set_password_response.dart';
import 'package:smile_shop/network/responses/state_response.dart';
import 'package:smile_shop/network/responses/sub_category_response.dart';
import 'package:smile_shop/network/responses/success_network_response.dart';
import 'package:smile_shop/network/responses/success_payment_response.dart';
import 'package:smile_shop/network/responses/township_response.dart';
import 'package:smile_shop/network/responses/wallet_response.dart';
import 'package:smile_shop/network/responses/wallet_transaction_response.dart';

import 'api_constants.dart';
import 'requests/campaign_detail_request.dart';
import 'requests/otp_verify_request.dart';

part 'smile_shop_api.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class SmileShopApi {
  factory SmileShopApi(Dio dio) = _SmileShopApi;

  @POST(kEndPointLogin)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @POST(kEndPointLogin)
  Future<LoginResponse> dealerLogin(@Body() DealerLoginRequest loginRequest);

  @POST(kEndPointSetPassword)
  Future<SetPasswordResponse> setPassword(
      @Body() SetPasswordRequest setPasswordRequest);

  @POST(kEndPointRegister)
  Future register(
    @Field(kFieldInvitationCode) String invitationCode,
    @Field(kFieldName) String name,
    @Field(kFieldPhone) String phone,
    @Field(kFieldLoginPassword) String loginPassword,
    @Field(kFieldPaymentPassword) String paymentPassword,
  );

  @GET(kEndPointBanners)
  Future<BannerResponse> banners(
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
  );

  @GET(kEndPointCategories)
  Future<CategoryResponse> categories(
    @Query(kParamType) String name,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
  );

  @POST(kEndPointProducts)
  Future<ProductResponse> products(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Field(kFieldEndUserId) int endUserId,
    @Field(kFieldPage) int page,
  );

  @POST(kEndPointBrandsAndCategories)
  Future<BrandsAndCategoriesResponse> getBrandsAndCategories(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Field(kFieldEndUserId) String endUserId,
  );

  @POST(kEndPointProductDetails)
  Future<ProductDetailsResponse> productDetail(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Field(kFieldEndUserId) String endUserId,
      @Field(kFieldProductId) int productId);

  @POST(kEndPointOtpVerify)
  Future verifyOtp(@Body() OtpVerifyRequest otpVerifyRequest);

  @POST(kEndPointOtpRequest)
  Future<OtpResponse> requestOtp(@Body() OtpRequest otpRequest);

  @POST(kEndPointForgotPasswordOtpVerify)
  Future forgotPasswordVerifyOtp(@Body() OtpVerifyRequest otpVerifyRequest);

  @POST(kEndPointForgotPasswordOtpRequest)
  Future<OtpResponse> forgotPasswordRequestOtp(@Body() OtpRequest otpRequest);

  @POST(kEndPointForgotPasswordSetPassword)
  Future<SetPasswordResponse> forgotPasswordSetPassword(
      @Body() SetPasswordRequest setPasswordRequest);

  @POST(kEndPointSearchProducts)
  Future<ProductResponse> searchProductsByName(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Field(kFieldEndUserId) int endUserId,
    @Field(kFieldPage) int page,
    @Query(kParamName) String name,
  );

  @POST(kEndPointSearchProducts)
  Future<ProductResponse> searchProductsByRating(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Field(kFieldEndUserId) int endUserId,
    @Field(kFieldPage) int page,
    @Query(kParamRating) double rating,
  );

  @POST(kEndPointSearchProducts)
  Future<ProductResponse> searchProductsByCategoryId(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Field(kFieldEndUserId) int endUserId,
    @Field(kFieldPage) int page,
    @Query(kParamCategoryId) int categoryID,
  );

  @POST(kEndPointSearchProducts)
  Future<ProductResponse> searchWithDynamic(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Field(kFieldEndUserId) int endUserId,
    @Field(kFieldPage) int page,
    @Query(kParamName) String? name,
    @Query(kParamRating) double? rating,
    @Query(kParamMinPrice) int? minPrice,
    @Query(kParamMaxPrice) int? maxPrice,
  );

  @POST(kEndPointSearchProducts)
  Future<ProductResponse> searchProductsBySubCategoryId(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Field(kFieldEndUserId) int endUserId,
    @Field(kFieldPage) int page,
    @Query(kParamSubCategoryId) int subcategoryID,
  );

  @POST(kEndPointSearchProducts)
  Future<ProductResponse> searchProductsByPrice(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Field(kFieldEndUserId) int endUserId,
    @Field(kFieldPage) int page,
    @Query(kParamPrice) int price,
    @Query(kParamOperator) String operator,
  );

  @POST(kEndPointAddNewAddress)
  Future<void> addNewAddress(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Body() AddressRequest addressRequest);

  @GET(kEndPointStates)
  Future<StateResponse> states();

  @GET("$kEndPointTownships/{state_id}")
  Future<TownshipResponse> townships(
    @Path("state_id") int stateId,
  );

  @POST(kEndPointAddressList)
  Future<AddressResponse> address(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
  );

  @GET("$kEndPointDeleteAddress/{address_id}")
  Future<TownshipResponse> deleteAddress(
    @Header(kHeaderAuthorization) String token,
    @Path("address_id") int addressId,
  );

  @POST("$kEndPointEditAddress/{address_id}")
  Future<TownshipResponse> editAddress(
      @Header(kHeaderAuthorization) String token,
      @Path("address_id") int addressId,
      @Body() AddressRequest addressRequest);

  @GET(kEndPointAddressCategory)
  Future<AddressCategoriesResponse> addressCategories(
    @Header(kHeaderAuthorization) String token,
  );

  @POST(kEndPointSubCategoryByCategory)
  Future<SubCategoryResponse> subCategoryByCategory(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Body() SubCategoryRequest subCategoryRequest);

  @POST(kEndPointOrder)
  Future<SuccessPaymentResponse> postOrder(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Field(kFieldSubTotal) int subTotal,
    @Field(kFieldPaymentType) String paymentType,
    @Field(kFieldItems) String itemList,
    @Field(kFieldAppType) String appType,
    @Field(kFieldPaymentData) String paymentData,
    @Field(kFieldUsedPoint) int usedPoint,
  );

  @POST(kEndPointMakePayment)
  Future<SuccessPaymentResponse> makePayment(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Field(kFieldPaymentType) String paymentType,
      @Field(kFieldPaymentData) String paymentData,
      @Field(kFieldOrderNo) String orderNo,
      @Field(kFieldAppType) String appType,
      );

  @GET(kEndPointPayments)
  Future<PaymentResponse> payments(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Query(kParamAction) String action,
  );

  @GET(kEndPointProfile)
  Future<ProfileResponse> profile(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
  );

  @GET(kEndPointOrderList)
  Future<OrderResponse> orders(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
  );

  @GET(kEndPointOrderList)
  Future<OrderResponse> ordersByOrderType(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Query(kParamOrderType) String orderType,
  );

  @GET("$kEndPointOrderDetails/{order_id}")
  Future<OrderDetailsResponse> orderDetails(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Path("order_id") String addressId,
  );

  @MultiPart()
  @POST(kEndPointUpdateProfile)
  Future<ProfileResponse> updateProfile(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Part() String name,
      @Part() File image);

  @POST(kEndPointUpdateProfile)
  Future<ProfileResponse> updateProfileName(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Field(kFieldName) String name,
  );

  @GET(kEndPointWallet)
  Future<WalletResponse> getWallet(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
  );

  @POST(kEndPointWalletTransitionLogs)
  Future<WalletTransactionResponse> getWalletTransitionLogs(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Body() WalletTransitionRequest walletTransitionRequest);

  @POST(kEndPointCheckWalletAmount)
  Future checkWalletAmount(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Body() CheckWalletAmountRequest checkWalletRequest);

  @POST(kEndPointCheckWalletPassword)
  Future<SuccessNetworkResponse> checkWalletPassword(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Body() CheckWalletPasswordRequest checkWalletPassword);

  @POST(kEndPointSetWalletPassword)
  Future<SuccessNetworkResponse> setWalletPassword(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Body() SetWalletPasswordRequest setWalletRequest);

  @POST(kEndPointRechargeWallet)
  Future<SuccessPaymentResponse> rechargeWallet(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Field(kFieldTotal) int total,
    @Field(kFieldPaymentType) String paymentType,
    @Field(kFieldAppType) String appType,
    @Field(kFieldPaymentData) String paymentData,
  );

  @GET(kEndPointGetUserCheckIn)
  Future<CheckInResponse> getUserCheckIn(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
  );

  @POST(kEndPointPostUserCheckIn)
  Future<SuccessNetworkResponse> postUserCheck(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Body() CheckInRequest checkInRequest);

  @GET(kEndPointCampaign)
  Future<CampaignResponse> getCampaign(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
    @Header(kHeaderAuthorization) String token,
  );

  @POST(kEndPointCampaignDetail)
  Future<CampaignDetailResponse> getCampaignDetail(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      @Body() CampaignDetailRequest request);

  @POST(kEndPointCampaignJoin)
  Future<void> joinCampaign(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      @Body() CampaignJoinRequest request);

  @POST(kEndPointCampaignParticipant)
  Future<CampaignParticipantResponse> getCampaignParticipants(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      @Body() CampaignDetailRequest request);

  @POST(kEndPointOrderCancel)
  Future<SuccessNetworkResponse> orderCancel(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      @Body() OrderCancelRequest request);

  @MultiPart()
  @POST(kEndPointPostRefund)
  Future<SuccessNetworkResponse> postRefund(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      @Part() int orderNo,
      @Part() int reasonId,
      @Part() File image);

  @GET(kEndPointGetRefunds)
  Future<RefundResponse> getRefunds(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      );

  @GET(kEndPointGetRefunds)
  Future<RefundResponse> getRefundsByStatus(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      @Query(kParamStatus) int status
      );

  @GET(kEndPointGetPromotionLogs)
  Future<PromotionResponse> getPromotionLogByStatus(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      @Query(kParamLogType) String status
      );

  @GET(kEndPointGetMyTeams)
  Future<MyTeamResponse> getMyTeams(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      );

  @GET(kEndPointGetPackages)
  Future<PackagesResponse> getPackages(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      );

  @GET("$kEndPointGetPackages/{id}")
  Future<PackageDetailsResponse> getPackageDetails(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Path("id") int id
      );

  @POST(kEndPointCheckOrderStatus)
  Future<SuccessNetworkResponse> checkOrderStatus(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      @Body() OrderStatusRequest request);

  @GET(kEndPointCampaignHistory)
  Future<CampaignHistoryResponse> getCampaignHistory(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token);

  @POST(kEndPointUpdateHomePagePopupData)
  Future<SuccessNetworkResponse> updateHomePagePopup(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      @Body() PopupRequest request);

  @POST(kEndPointGetHomePagePopupData)
  Future<HomePopupDataResponse> getHomePagePopup(
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Header(kHeaderAuthorization) String token,
      @Body() PopupRequest request);

  @POST(kEndPointChangePassword)
  Future<SuccessNetworkResponse> changePassword(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Field(kFieldEndUserId) int endUserId,
      @Field(kFieldOldPassword) String oldPassword,
      @Field(kFieldNewPassword) String newPassword,
      @Field(kFieldConfirmPassword) String confirmPassword,
      @Field(kFieldPasswordType) String passwordType,
      );

  @GET(kEndPointGetRefundReason)
  Future<RefundReasonResponse> getRefundReasons(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      );

  @GET(kEndPointAccountDelete)
  Future<SuccessNetworkResponse> deleteAccount(
      @Header(kHeaderAuthorization) String token,
      );

  @POST(kEndPointAddFavouriteProduct)
  Future<SuccessNetworkResponse> addFavouriteProduct(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Body() FavouriteProductRequest request);

}
