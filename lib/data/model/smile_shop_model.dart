import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/login_data_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/data/vos/township_data_vo.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/set_password_request.dart';
import 'package:smile_shop/network/responses/otp_response.dart';

import '../../network/requests/address_request.dart';
import '../../network/requests/login_request.dart';
import '../../network/requests/otp_verify_request.dart';
import '../../network/requests/sub_category_request.dart';
import '../../network/responses/address_response.dart';
import '../../network/responses/login_response.dart';
import '../vos/brand_and_category_vo.dart';
import '../vos/order_vo.dart';
import '../vos/payment_vo.dart';
import '../vos/product_response_data_vo.dart';
import '../vos/state_vo.dart';
import '../vos/sub_category_vo.dart';

abstract class SmileShopModel {
  Future<LoginResponse> login(LoginRequest loginRequest);

  Future register(String invitationCode, String name, String phone,
      String loginPassword, String paymentPassword);

  Future<List<BannerVO>> banners(String acceptLanguage);

  Future<List<CategoryVO>> categories(String type);

  Future<ProductResponseDataVO> products(
      String token, String acceptLanguage, int endUserId, int page);

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

  Future<List<ProductVO>> searchProductsByName(String token,
      String acceptLanguage, String endUserId, int pageNo, String name);

  Future<List<ProductVO>> searchProductsByRating(String token,
      String acceptLanguage, String endUserId, int pageNo, double rating);

  Future<List<ProductVO>> searchProductsByPrice(String token,
      String acceptLanguage, String endUserId, int pageNo, int price,String operator);

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

  ///get data from database
  LoginDataVO? getLoginResponseFromDatabase();

  Stream<List<SearchProductVO>> getSearchProductFromDatabase();

  List<SearchProductVO> getFirstTimeSearchProductFromDatabase();

  SearchProductVO? getSearchProductByNameFromDatabase(String name);

  void clearSaveLoginData();

  void clearSaveAddToCartProduct();

  void clearSaveAddToCartProductByProductId(int productId);

  void clearSearchProduct();

  void clearSingleSearchProduct(String name);

  void addSingleSearchProductToDatabase(SearchProductVO searchProductVO);

  Future<void> postOrder(String token,
      String acceptLanguage,
      int productId,
      int subTotal,
      String paymentType,
      List itemList,
      String appType);

  Future<List<PaymentVO>> payments(String token, String acceptLanguage);
  Future<List<ProductVO>> searchProductsCategoryId(String token,
      String acceptLanguage, String endUserId, int pageNo, int categoryId);

  Future<List<ProductVO>> searchProductsBySubCategoryId(String token,
      String acceptLanguage, String endUserId, int pageNo, int subCategoryId);

  ///for cart list
  List<ProductVO> firstTimeGetProductFromDatabase();
  void saveProductToHive(ProductVO product);
  void deleteProductById(int productId);
  Stream<List<ProductVO>> getProductFromDatabase();
  ProductVO? getProductByIdFromDatabase(int id);

  Future<List<OrderVO>> orderList(String token,String acceptLanguage);
  Future<OrderVO> orderDetails(String token,String acceptLanguage,int orderId);
}
