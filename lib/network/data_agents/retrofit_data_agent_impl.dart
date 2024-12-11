import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/brand_and_category_vo.dart';
import 'package:smile_shop/data/vos/product_response_data_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/data_agents/smile_shop_data_agent.dart';
import 'package:smile_shop/network/requests/login_request.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/otp_verify_request.dart';
import 'package:smile_shop/network/responses/login_response.dart';
import 'package:smile_shop/network/smile_shop_api.dart';

import '../../data/vos/error_vo.dart';
import '../../exception/custom_exception.dart';

class RetrofitDataAgentImpl extends SmileShopDataAgent {
  late SmileShopApi mApi;

  static RetrofitDataAgentImpl? _singleton;

  ///singleton
  factory RetrofitDataAgentImpl() {
    _singleton ??= RetrofitDataAgentImpl._internal();
    return _singleton!;
  }

  ///private constructor
  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    mApi = SmileShopApi(dio);
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return mApi
        .login(loginRequest)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<BannerVO>> banners() {
    return mApi
        .banners()
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<ProductResponseDataVO> products(String token, String acceptLanguage,int endUserId,String page) {
    return mApi
        .products(token, acceptLanguage,endUserId,page)
        .asStream()
        .map((response) => response.data ?? ProductResponseDataVO())
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<ProductVO> getProductDetails(String endUserId, String productId, String acceptLanguage, String token
      ) {
    return mApi
        .productDetail(token,acceptLanguage,endUserId,int.parse(productId))
        .asStream()
        .map((response) => response.data ?? ProductVO())
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future verifyOtp(
      OtpVerifyRequest otpVerifyRequest) {
    return mApi
        .verifyOtp(otpVerifyRequest)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future requestOtp(OtpRequest otpRequest) {
    return mApi
        .requestOtp(otpRequest)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future register(String invitationCode, String name, String phone,
      String loginPassword, String paymentPassword) {
    return mApi
        .register(invitationCode, name, phone, loginPassword, paymentPassword)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<BrandAndCategoryVO> getBrandsAndCategories(String token, String acceptLanguage, String endUserId) {
    return mApi
        .getBrandsAndCategories(token,acceptLanguage,endUserId)
        .asStream()
        .map((response) => response.data ?? BrandAndCategoryVO())
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<ProductVO>> searchProducts(String query,String token,String acceptLanguage,String endUserId) {
    return mApi
        .searchProducts(token,acceptLanguage,int.parse(endUserId),query)
        .asStream()
        .map((response) => response.data?.products ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }
}

///custom exception
CustomException _createException(dynamic error) {
  ErrorVO errorVO;
  debugPrint("Error:$error");
  if (error is DioException) {
    errorVO = _parseDioError(error);
  } else {
    errorVO = ErrorVO(statusCode: 0, message: "UnExcepted error", error: []);
  }
  return CustomException(errorVO);
}

ErrorVO _parseDioError(DioException error) {
  try {
    if (error.response != null || error.response?.data != null) {
      var data = error.response?.data;

      ///Json string to Map<String,dynamic>
      if (data is String) {
        data = jsonDecode(data);
      }

      ///Map<String,dynamic> to ErrorVO
      return ErrorVO.fromJson(data);
    } else {
      return ErrorVO(statusCode: 0, message: "No response data", error: []);
    }
  } catch (e) {
    return ErrorVO(
        statusCode: 0, message: "Invalid DioException Format", error: []);
  }
}
