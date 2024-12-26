import 'package:flutter/cupertino.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/brand_and_category_vo.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/login_data_vo.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/data/vos/state_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/data/vos/township_data_vo.dart';
import 'package:smile_shop/network/requests/address_request.dart';
import 'package:smile_shop/network/requests/login_request.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/set_password_request.dart';
import 'package:smile_shop/network/requests/sub_category_request.dart';
import 'package:smile_shop/network/responses/address_response.dart';
import 'package:smile_shop/network/responses/login_response.dart';
import 'package:smile_shop/network/responses/otp_response.dart';
import 'package:smile_shop/persistence/product_dao.dart';
import 'package:smile_shop/persistence/search_product_dao.dart';

import '../../network/data_agents/retrofit_data_agent_impl.dart';
import '../../network/data_agents/smile_shop_data_agent.dart';
import '../../network/requests/otp_verify_request.dart';
import '../../persistence/login_data_dao.dart';
import '../vos/product_response_data_vo.dart';

class SmileShopModelImpl extends SmileShopModel {
  static final SmileShopModelImpl _singleton = SmileShopModelImpl._internal();

  factory SmileShopModelImpl() {
    return _singleton;
  }

  SmileShopModelImpl._internal();

  ///Data agent
  SmileShopDataAgent mDataAgent = RetrofitDataAgentImpl();

  ///Dao
  final LoginDataDao _loginDataDao = LoginDataDao();
  final SearchProductDao _searchProductDao = SearchProductDao();
  final ProductDao _productDao = ProductDao();

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return mDataAgent.login(loginRequest).then((response) async {
      debugPrint("UserDataVO>>>>${response.data?.data?.id}");

      var loginResponse = LoginDataVO(
          status: response.data?.status,
          message: response.data?.message,
          data: response.data?.data,
          refreshToken: response.data?.refreshToken,
          expire: response.data?.expire,
          accessToken: response.data?.accessToken);

      ///save login data to hive
      await _loginDataDao.saveLoginData(loginResponse);
      return response;
    });
  }

  @override
  Future<List<BannerVO>> banners(String acceptLanguage) {
    return mDataAgent.banners(acceptLanguage);
  }

  @override
  Future verifyOtp(OtpVerifyRequest otpVerifyRequest) {
    return mDataAgent.verifyOtp(otpVerifyRequest);
  }

  @override
  Future<OtpResponse> requestOtp(OtpRequest otpRequest) {
    return mDataAgent.requestOtp(otpRequest);
  }

  @override
  Future register(String invitationCode, String name, String phone,
      String loginPassword, String paymentPassword) {
    return mDataAgent.register(
        invitationCode, name, phone, loginPassword, paymentPassword);
  }

  @override
  Future<ProductVO> getProductDetails(
      String endUserId, String productId, String acceptLanguage, String token) {
    return mDataAgent.getProductDetails(
        endUserId, productId, acceptLanguage, token);
  }

  @override
  Future<BrandAndCategoryVO> getBrandsAndCategories(
      String token, String acceptLanguage, String endUserId) {
    return mDataAgent.getBrandsAndCategories(token, acceptLanguage, endUserId);
  }

  @override
  Future<List<ProductVO>> searchProductsByName(String token,
      String acceptLanguage, String endUserId, int pageNo, String name) {
    return mDataAgent.searchProductsByName(
        token, acceptLanguage, endUserId, pageNo, name);
  }

  @override
  Future<List<ProductVO>> searchProductsByRating(String token,
      String acceptLanguage, String endUserId, int pageNo, double rating) {
    return mDataAgent.searchProductsByRating(
        token, acceptLanguage, endUserId, pageNo, rating);
  }

  @override
  Future setPassword(SetPasswordRequest setPasswordRequest) {
    return mDataAgent.setPassword(setPasswordRequest);
  }

  @override
  Future<List<CategoryVO>> categories(String type) {
    return mDataAgent.categories(type);
  }

  @override
  Future addNewAddress(String accessToken, String acceptLanguage,
      AddressRequest addressRequest) {
    return mDataAgent.addNewAddress(
        accessToken, acceptLanguage, addressRequest);
  }

  @override
  Future<List<StateVO>> states() {
    return mDataAgent.states();
  }

  @override
  Future<TownshipDataVO> townships(int stateId) {
    return mDataAgent.townships(stateId);
  }

  @override
  Future<AddressResponse> address(String accessToken, String acceptLanguage) {
    return mDataAgent.address(accessToken, acceptLanguage);
  }

  @override
  Future<ProductResponseDataVO> products(
      String token, String acceptLanguage, int endUserId, int page) {
    debugPrint("Token:::$token");
    return mDataAgent.products(token, acceptLanguage, endUserId, page);
  }

  @override
  Future deleteAddress(String accessToken, int addressId) {
    return mDataAgent.deleteAddress(accessToken, addressId);
  }

  @override
  Future editAddress(
      String accessToken, int addressId, AddressRequest addressRequest) {
    return mDataAgent.editAddress(accessToken, addressId, addressRequest);
  }

  @override
  Future<List<CategoryVO>> addressCategories(String accessToken) {
    return mDataAgent.addressCategories(accessToken);
  }

  @override
  Future<List<SubcategoryVO>> subCategoryByCategory(String token,
      String acceptLanguage, SubCategoryRequest subCategoryRequest) {
    return mDataAgent.subCategoryByCategory(
        token, acceptLanguage, subCategoryRequest);
  }

  @override
  Future<void> postOrder(String token, String acceptLanguage, int subTotal, String paymentType, List itemList,String appType) {
    return mDataAgent.postOrder(token, acceptLanguage, subTotal, paymentType, itemList,appType);
  }

  @override
  Future<List<PaymentVO>> payments(String token, String acceptLanguage) {
   return mDataAgent.payments(token, acceptLanguage);
  }

  ///get data from hive database
  @override
  LoginDataVO? getLoginResponseFromDatabase() {
    return _loginDataDao.getLoginData();
  }

  @override
  void clearSearchProduct() {
    _searchProductDao.clearSearchProduct();
  }

  @override
  SearchProductVO? getSearchProductByNameFromDatabase(String name) {
    return _searchProductDao.getSearchProductByName(name);
  }

  @override
  Stream<List<SearchProductVO>> getSearchProductFromDatabase() {
    return _searchProductDao
        .watchSearchProductBox()
        .map((_) => _searchProductDao.getSearchProducts());
  }

  @override
  void clearSingleSearchProduct(String name) {
    _searchProductDao.deleteSearchProduct(name);
  }

  @override
  void addSingleSearchProductToDatabase(SearchProductVO searchProductVO) {
    _searchProductDao.saveSingleSearchProduct(searchProductVO);
  }

  @override
  List<SearchProductVO> getFirstTimeSearchProductFromDatabase() {
    return _searchProductDao.getSearchProducts();
  }

  @override
  void clearSaveLoginData() {
    _loginDataDao.clearUserData();
  }

  @override
  Future<OrderVO> orderDetails(String token, String acceptLanguage, int orderId) {
   return mDataAgent.orderDetails(token, acceptLanguage, orderId);
  }

  @override
  Future<List<OrderVO>> orderList(String token, String acceptLanguage) {
    return mDataAgent.orderList(token, acceptLanguage);
  }

  ///get add to cart product list from database
  @override
  List<ProductVO> firstTimeGetProductFromDatabase() {
    return _productDao.getProducts();
  }

  @override
  Stream<List<ProductVO>> getProductFromDatabase() {
    return _productDao.watchProductBox().map((_) => _productDao.getProducts());
  }

  @override
  void saveProductToHive(ProductVO product) {
    return _productDao.saveSearchProduct(product);
  }

  @override
  void deleteProductById(int productId) {
    return _productDao.deleteSearchProduct(productId);
  }

  @override
  ProductVO? getProductByIdFromDatabase(int id) {
   return _productDao.getProductById(id);
  }

  @override
  void clearSaveAddToCartProduct() {
    _productDao.clearProduct();
  }

  @override
  void clearSaveAddToCartProductByProductId(int productId) {
    _productDao.deleteSearchProduct(productId);
  }

  @override
  Future<List<ProductVO>> searchProductsByPrice(String token, String acceptLanguage, String endUserId, int pageNo, int price, String operator) {
   return mDataAgent.searchProductsByPrice(token, acceptLanguage, endUserId, pageNo, price, operator);
  }

  @override
  Future<List<ProductVO>> searchProductsBySubCategoryId(String token, String acceptLanguage, String endUserId, int pageNo, int subCategoryId) {
    return mDataAgent.searchProductsBySubCategoryId(token, acceptLanguage, endUserId, pageNo, subCategoryId);
  }

  @override
  Future<List<ProductVO>> searchProductsCategoryId(String token, String acceptLanguage, String endUserId, int pageNo, int categoryId
      ) {
    return mDataAgent.searchProductsCategoryId(token, acceptLanguage, endUserId, pageNo, categoryId);
  }

}
