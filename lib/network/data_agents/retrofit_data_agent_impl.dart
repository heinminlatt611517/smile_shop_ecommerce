import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/brand_and_category_vo.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';
import 'package:smile_shop/data/vos/product_response_data_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/profile_vo.dart';
import 'package:smile_shop/data/vos/state_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/data/vos/township_data_vo.dart';
import 'package:smile_shop/data/vos/wallet_transaction_vo.dart';
import 'package:smile_shop/data/vos/wallet_vo.dart';
import 'package:smile_shop/network/data_agents/smile_shop_data_agent.dart';
import 'package:smile_shop/network/requests/address_request.dart';
import 'package:smile_shop/network/requests/check_wallet_amount_request.dart';
import 'package:smile_shop/network/requests/check_wallet_password_request.dart';
import 'package:smile_shop/network/requests/login_request.dart';
import 'package:smile_shop/network/requests/otp_request.dart';
import 'package:smile_shop/network/requests/otp_verify_request.dart';
import 'package:smile_shop/network/requests/set_password_request.dart';
import 'package:smile_shop/network/requests/set_wallet_password_request.dart';
import 'package:smile_shop/network/requests/sub_category_request.dart';
import 'package:smile_shop/network/requests/wallet_transition_request.dart';
import 'package:smile_shop/network/responses/address_response.dart';
import 'package:smile_shop/network/responses/login_response.dart';
import 'package:smile_shop/network/responses/otp_response.dart';
import 'package:smile_shop/network/responses/profile_response.dart';
import 'package:smile_shop/network/responses/set_password_response.dart';
import 'package:smile_shop/network/responses/success_network_response.dart';
import 'package:smile_shop/network/responses/success_payment_response.dart';
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
  Future<List<BannerVO>> banners(String acceptLanguage) {
    return mApi
        .banners(acceptLanguage)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<ProductResponseDataVO> products(
      String token, String acceptLanguage, int endUserId, int page) {
    return mApi
        .products(token, acceptLanguage, endUserId, page)
        .asStream()
        .map((response) => response.data ?? ProductResponseDataVO())
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<ProductVO> getProductDetails(
      String endUserId, String productId, String acceptLanguage, String token) {
    return mApi
        .productDetail(token, acceptLanguage, endUserId, int.parse(productId))
        .asStream()
        .map((response) => response.data ?? ProductVO())
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future verifyOtp(OtpVerifyRequest otpVerifyRequest) {
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
  Future<OtpResponse> requestOtp(OtpRequest otpRequest) {
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
  Future<BrandAndCategoryVO> getBrandsAndCategories(
      String token, String acceptLanguage, String endUserId) {
    return mApi
        .getBrandsAndCategories(token, acceptLanguage, endUserId)
        .asStream()
        .map((response) => response.data ?? BrandAndCategoryVO())
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<ProductVO>> searchProductsByName(String token,
      String acceptLanguage, String endUserId, int pageNo, String name) {
    return mApi
        .searchProductsByName(
            token, acceptLanguage, int.parse(endUserId), pageNo, name)
        .asStream()
        .map((response) => response.data?.products ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<ProductVO>> searchProductsByRating(String token,
      String acceptLanguage, String endUserId, int pageNo, double rating) {
    return mApi
        .searchProductsByRating(
            token, acceptLanguage, int.parse(endUserId), pageNo, rating)
        .asStream()
        .map((response) => response.data?.products ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<ProductVO>> searchProductsByPrice(
      String token,
      String acceptLanguage,
      String endUserId,
      int pageNo,
      int price,
      String operator) {
    return mApi
        .searchProductsByPrice(token, acceptLanguage, int.parse(endUserId),
            pageNo, price, operator)
        .asStream()
        .map((response) => response.data?.products ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<SetPasswordResponse> setPassword(
      SetPasswordRequest setPasswordRequest) {
    return mApi
        .setPassword(setPasswordRequest)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<CategoryVO>> categories(String type) {
    return mApi
        .categories(type)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future addNewAddress(String accessToken, String acceptLanguage,
      AddressRequest addressRequest) {
    return mApi
        .addNewAddress('Bearer $accessToken', acceptLanguage, addressRequest)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<StateVO>> states() {
    return mApi
        .states()
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<TownshipDataVO> townships(int stateId) {
    return mApi
        .townships(stateId)
        .asStream()
        .map((response) => response.townshipDataVO ?? TownshipDataVO())
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<AddressResponse> address(String accessToken, String acceptLanguage) {
    return mApi
        .address("Bearer $accessToken", acceptLanguage)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future deleteAddress(String accessToken, int addressId) {
    return mApi
        .deleteAddress("Bearer $accessToken", addressId)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future editAddress(
      String accessToken, int addressId, AddressRequest addressRequest) {
    return mApi
        .editAddress("Bearer $accessToken", addressId, addressRequest)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<CategoryVO>> addressCategories(String accessToken) {
    return mApi
        .addressCategories(accessToken)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<SubcategoryVO>> subCategoryByCategory(String token,
      String acceptLanguage, SubCategoryRequest subCategoryRequest) {
    return mApi
        .subCategoryByCategory(token, acceptLanguage, subCategoryRequest)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<PaymentVO>> payments(String token, String acceptLanguage,String action) {
    return mApi
        .payments(token, acceptLanguage,action)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<OrderVO> orderDetails(
      String token, String acceptLanguage, int orderId) {
    return mApi
        .orderDetails('Bearer $token', acceptLanguage, orderId)
        .asStream()
        .map((response) => response.data ?? OrderVO())
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<OrderVO>> orderList(String token, String acceptLanguage) {
    return mApi
        .orders("Bearer $token", acceptLanguage)
        .asStream()
        .map((response) => response.data ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<OrderVO>> getOrderListByOrderType(
      String token, String acceptLanguage, String orderType) {
    return mApi
        .ordersByOrderType('Bearer $token', acceptLanguage, orderType)
        .asStream()
        .map((response) {
          return response.data ?? [];
        })
        .first
        .catchError((error) {
          throw _createException(error);
        });
  }

  @override
  Future<List<ProductVO>> searchProductsBySubCategoryId(String token,
      String acceptLanguage, String endUserId, int pageNo, int subCategoryId) {
    return mApi
        .searchProductsBySubCategoryId(
            token, acceptLanguage, int.parse(endUserId), pageNo, subCategoryId)
        .asStream()
        .map((response) => response.data?.products ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<ProductVO>> searchProductsCategoryId(String token,
      String acceptLanguage, String endUserId, int pageNo, int categoryId) {
    return mApi
        .searchProductsByCategoryId(
            token, acceptLanguage, int.parse(endUserId), pageNo, categoryId)
        .asStream()
        .map((response) => response.data?.products ?? [])
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<ProfileVO> userProfile(String token, String acceptLanguage) {
    return mApi
        .profile('Bearer $token', acceptLanguage)
        .asStream()
        .map((response) {
          return response.data ?? ProfileVO();
        })
        .first
        .catchError((error) {
          throw _createException(error);
        });
  }

  @override
  Future<ProfileResponse> updateProfile(
      String token, String acceptLanguage, String name, File? image) {
    return mApi
        .updateProfile('Bearer $token', acceptLanguage, name, image!)
        .asStream()
        .map((response) {
          return response;
        })
        .first
        .catchError((error) {
          throw _createException(error);
        });
  }

  @override
  Future<ProfileResponse> updateProfileName(
      String token, String acceptLanguage, String name) {
    return mApi
        .updateProfileName(
          'Bearer $token',
          acceptLanguage,
          name,
        )
        .asStream()
        .map((response) {
          return response;
        })
        .first
        .catchError((error) {
          throw _createException(error);
        });
  }

  @override
  Future<WalletVO> getWallet(String token, String acceptLanguage) {
    return mApi
        .getWallet('Bearer $token', acceptLanguage)
        .asStream()
        .map((response) {
          return response.data ?? WalletVO();
        })
        .first
        .catchError((error) {
          throw _createException(error);
        });
  }

  @override
  Future checkWalletAmount(String token, String acceptLanguage,
      CheckWalletAmountRequest checkWalletAmountRequest) {
    return mApi
        .checkWalletAmount(
            'Bearer $token', acceptLanguage, checkWalletAmountRequest)
        .asStream()
        .map((response) {
          return response;
        })
        .first
        .catchError((error) {
          throw _createException(error);
        });
  }

  @override
  Future checkWalletPassword(String token, String acceptLanguage,
      CheckWalletPasswordRequest checkWalletPasswordRequest) {
    return mApi
        .checkWalletPassword(
            'Bearer $token', acceptLanguage, checkWalletPasswordRequest)
        .asStream()
        .map((response) {
          return response;
        })
        .first
        .catchError((error) {
          throw _createException(error);
        });
  }

  @override
  Future<SuccessNetworkResponse> setWalletPassword(
      String token,
      String acceptLanguage,
      SetWalletPasswordRequest setWalletPasswordRequest) {
    return mApi
        .setWalletPassword(
            'Bearer $token', acceptLanguage, setWalletPasswordRequest)
        .asStream()
        .map((response) {
          return response;
        })
        .first
        .catchError((error) {
          throw _createException(error);
        });
  }


  @override
  Future<SuccessPaymentResponse> postOrder(String token, String acceptLanguage, int subTotal, String paymentType, String itemList, String appType, String paymentData, int usedPoint) {
    return mApi
        .postOrder(
        "Bearer $token",
        acceptLanguage,
        subTotal,
        paymentType,
        itemList,
        appType,paymentData,usedPoint)
        .asStream()
        .map((response) => response)
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<List<WalletTransactionVO>> getWalletTransactions(String token, String acceptLanguage, WalletTransitionRequest walletTransactionRequest) {
    return mApi
        .getWalletTransitionLogs(
        'Bearer $token', acceptLanguage,walletTransactionRequest)
        .asStream()
        .map((response) {
      return response.data?.walletTransactions ?? [];
    })
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }

  @override
  Future<SuccessPaymentResponse> rechargeWallet(String token, String acceptLanguage, int total, String paymentType, String appType, String paymentData) {
    return mApi
        .rechargeWallet(
        'Bearer $token', acceptLanguage,total,paymentType,appType,paymentData)
        .asStream()
        .map((response) {
      return response;
    })
        .first
        .catchError((error) {
      throw _createException(error);
    });
  }
}

///custom exception
CustomException _createException(dynamic error) {
  ErrorVO errorVO;
  if (error is DioException) {
    errorVO = _parseDioError(error);
  } else {
    errorVO = ErrorVO(
      statusCode: 0,
      message: "UnExcepted error",
    );
  }
  return CustomException(errorVO);
}

ErrorVO _parseDioError(DioException error) {
  debugPrint("Error:$error");
  try {
    if (error.response != null || error.response?.data != null) {
      var data = error.response?.data;

      debugPrint("Data$data");

      ///Json string to Map<String,dynamic>
      if (data is String) {
        data = jsonDecode(data);
      }

      ///Map<String,dynamic> to ErrorVO
      return ErrorVO.fromJson(data);
    } else {
      return ErrorVO(statusCode: 0, message: "No response data");
    }
  } catch (e) {
    return ErrorVO(statusCode: 0, message: "Invalid DioException Format");
  }
}
