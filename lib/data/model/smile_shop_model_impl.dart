import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/brand_and_category_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/network/requests/login_request.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/set_password_request.dart';
import 'package:smile_shop/network/responses/login_response.dart';
import 'package:smile_shop/network/responses/otp_response.dart';
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

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return mDataAgent.login(loginRequest).then((response) {
      var loginResponse = LoginResponse(
          status: response.status,
          message: response.message,
          data: response.data,
          refreshToken: response.refreshToken,
          expire: response.expire,
          accessToken: response.accessToken);

      ///save login data to hive
      _loginDataDao.saveLoginData(loginResponse);
      return loginResponse;
    });
  }

  @override
  Future<List<BannerVO>> banners() {
    return mDataAgent.banners();
  }

  @override
  Future<ProductResponseDataVO> products(
      String token, String acceptLanguage, int endUserId, String page) {
    return mDataAgent.products(token, acceptLanguage, endUserId, page);
  }

  @override
  Future verifyOtp(
      OtpVerifyRequest otpVerifyRequest) {
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
  Future<List<ProductVO>> searchProductsByName(
      String token, String acceptLanguage, String endUserId,int pageNo,String name) {
    return mDataAgent.searchProductsByName( token, acceptLanguage, endUserId,pageNo,name);
  }

  @override
  Future<List<ProductVO>> searchProductsByRating(
      String token, String acceptLanguage, String endUserId,int pageNo,int rating) {
    return mDataAgent.searchProductsByRating( token, acceptLanguage, endUserId,pageNo,rating);
  }

  @override
  Future setPassword(SetPasswordRequest setPasswordRequest) {
    return mDataAgent.setPassword(setPasswordRequest);
  }

  ///get data from hive database
  @override
  LoginResponse? getLoginResponseFromDatabase() {
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
}
