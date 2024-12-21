import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:smile_shop/network/requests/address_request.dart';
import 'package:smile_shop/network/requests/login_request.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/set_password_request.dart';
import 'package:smile_shop/network/requests/sub_category_request.dart';
import 'package:smile_shop/network/responses/address_categories_response.dart';
import 'package:smile_shop/network/responses/address_response.dart';
import 'package:smile_shop/network/responses/banner_response.dart';
import 'package:smile_shop/network/responses/brands_and_categories_response.dart';
import 'package:smile_shop/network/responses/category_response.dart';
import 'package:smile_shop/network/responses/login_response.dart';
import 'package:smile_shop/network/responses/otp_response.dart';
import 'package:smile_shop/network/responses/product_details_response.dart';
import 'package:smile_shop/network/responses/product_response.dart';
import 'package:smile_shop/network/responses/state_response.dart';
import 'package:smile_shop/network/responses/sub_category_response.dart';
import 'package:smile_shop/network/responses/township_response.dart';

import 'api_constants.dart';
import 'requests/otp_verify_request.dart';

part 'smile_shop_api.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class SmileShopApi {
  factory SmileShopApi(Dio dio) = _SmileShopApi;

  @POST(kEndPointLogin)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @POST(kEndPointSetPassword)
  Future<LoginResponse> setPassword(
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
  Future<CategoryResponse> categories(@Query(kParamType) String name,);

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
      @Body() AddressRequest addressRequest
      );

  @GET(kEndPointAddressCategory)
  Future<AddressCategoriesResponse> addressCategories(
      @Header(kHeaderAuthorization) String token,
      );

  @POST(kEndPointSubCategoryByCategory)
  Future<SubCategoryResponse> subCategoryByCategory(
      @Header(kHeaderAuthorization) String token,
      @Header(kHeaderAcceptLanguage) String acceptLanguage,
      @Body() SubCategoryRequest subCategoryRequest
      );
}
