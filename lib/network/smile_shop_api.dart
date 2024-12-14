import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:smile_shop/network/requests/login_request.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/set_password_request.dart';
import 'package:smile_shop/network/responses/banner_response.dart';
import 'package:smile_shop/network/responses/brands_and_categories_response.dart';
import 'package:smile_shop/network/responses/login_response.dart';
import 'package:smile_shop/network/responses/otp_response.dart';
import 'package:smile_shop/network/responses/product_details_response.dart';
import 'package:smile_shop/network/responses/product_response.dart';

import 'api_constants.dart';
import 'requests/otp_verify_request.dart';

part 'smile_shop_api.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class SmileShopApi {
  factory SmileShopApi(Dio dio) = _SmileShopApi;

  @POST(kEndPointLogin)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @POST(kEndPointSetPassword)
  Future<LoginResponse> setPassword(@Body() SetPasswordRequest setPasswordRequest);

  @POST(kEndPointRegister)
  Future register(
    @Field(kFieldInvitationCode) String invitationCode,
    @Field(kFieldName) String name,
    @Field(kFieldPhone) String phone,
    @Field(kFieldLoginPassword) String loginPassword,
    @Field(kFieldPaymentPassword) String paymentPassword,
  );

  @GET(kEndPointBanners)
  Future<BannerResponse> banners();

  @POST(kEndPointProducts)
  Future<ProductResponse> products(
    @Header(kHeaderAuthorization) String token,
    @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Field(kFieldEndUserId) int endUserId,
      @Field(kFieldPage) String page,
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
  Future verifyOtp(
    @Body() OtpVerifyRequest otpVerifyRequest
  );

  @POST(kEndPointOtpRequest)
  Future<OtpResponse> requestOtp(@Body() OtpRequest otpRequest);

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
      @Query(kParamRating) int rating,
      );
}
