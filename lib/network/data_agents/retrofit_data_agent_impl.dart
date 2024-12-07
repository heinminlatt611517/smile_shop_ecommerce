import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smile_shop/network/data_agents/smile_shop_data_agent.dart';
import 'package:smile_shop/network/requests/login_request.dart';
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
}

///custom exception
CustomException _createException(dynamic error) {
  ErrorVO errorVO;
  debugPrint("Error:$error");
  if (error is DioException) {
    errorVO = _parseDioError(error);
  } else {
    errorVO = ErrorVO(
        statusCode: 0, statusMessage: "UnExcepted error", success: false);
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
      return ErrorVO(
          statusCode: 0, statusMessage: "No response data", success: false);
    }
  } catch (e) {
    return ErrorVO(
        statusCode: 0,
        statusMessage: "Invalid DioException Format",
        success: false);
  }
}