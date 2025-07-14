import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/coupon_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/user_vo.dart';
import 'package:smile_shop/localization/app_localizations.dart';

import '../data/vos/address_vo.dart';
import '../network/api_constants.dart';
import '../widgets/common_dialog.dart';
import '../widgets/session_expired_dialog_view.dart';

class CheckOutBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();
  UserVO? userVo;

  ///states
  StreamSubscription? _productListSubscription;
  int? totalProductPrice;
  int? totalSummaryProductPrice;
  int deliveryFeePrice = 0;
  List<int> subTotalPrice = [];
  List<AddressVO> addressList = [];
  AddressVO? defaultAddressVO;
  bool isDisposed = false;
  bool isLoading = false;
  DeliveryOptions? selectedDeliveryOption = DeliveryOptions.standard;
  BuildContext? context;
  CouponVO? selectedCoupon;
  final SmileShopModel _model = SmileShopModelImpl();
  List<ProductVO> productList;

  int availalePromotionPoints = 0;
  int usedPromotionPoints = 0;
  int userCurrentPromotionPoints = 0;

  List<CouponVO> couponList = [];
  CheckOutBloc(this.productList, this.context) {
    ///load address
    _loadAddress();
    getUser();
    if (productList.isNotEmpty) {
      calculateTotalProductPrice(productList);
      calculateLargestPromotionPoints();
      getCouponList();
    }
  }

  void getCouponList() {
    String? token = _smileShopModel.getLoginResponseFromDatabase()?.accessToken;
    _smileShopModel.getCouponList(token ?? '').then((coupons) {
      couponList = coupons
          .where(
            (element) => element.isValid(totalProductPrice ?? 0),
          )
          .toList();
      _notifySafely();
    }).catchError((error) {
      if (error.toString().toLowerCase() == 'unauthenticated') {
        showCommonDialog(
          context: context!,
          dialogWidget: SessionExpiredDialogView(),
        );
      }
    });
  }

  void calculateLargestPromotionPoints() {
    if (productList.isNotEmpty) {
      int largestPromotionPoints = 0;
      for (var product in productList) {
        if (product.variantVO?.firstOrNull?.redeemPoint != null &&
            (product.variantVO?.firstOrNull?.redeemPoint ?? 0) >
                largestPromotionPoints) {
          largestPromotionPoints =
              product.variantVO?.firstOrNull?.redeemPoint ?? 0;

        }
      }
      availalePromotionPoints = largestPromotionPoints;
      usedPromotionPoints = 0; // Reset used points
      _notifySafely();
    }
  }

  void changePromotionPointStatus(bool isUsed) {
    if (isUsed) {
      if (availalePromotionPoints > userCurrentPromotionPoints) {
        showSnackBar(
          context!,
          "Not Enough Promotion Points",
          Colors.red,
        );
        return;
      }
      usedPromotionPoints = availalePromotionPoints;
      totalSummaryProductPrice = (totalProductPrice ?? 0) +
          deliveryFeePrice -
          usedPromotionPoints -
          (selectedCoupon?.getDiscountValue().floor() ?? 0);
    } else {
      usedPromotionPoints = 0;
      totalSummaryProductPrice = (totalProductPrice ?? 0) +
          deliveryFeePrice -
          (selectedCoupon?.getDiscountValue().floor() ?? 0);
    }
    _notifySafely();
  }

  void selectCoupon(CouponVO? coupon) {
    if (coupon != null) {
      selectedCoupon = coupon;
      totalSummaryProductPrice = (totalProductPrice ?? 0) +
          deliveryFeePrice -
          (coupon.getDiscountValue().floor()) -
          usedPromotionPoints;
      _notifySafely();
    } else {
      selectedCoupon = null;
      totalSummaryProductPrice =
          (totalProductPrice ?? 0) + deliveryFeePrice - usedPromotionPoints;
      _notifySafely();
    }
  }

  void getUser() async {
    String? token = _smileShopModel.getLoginResponseFromDatabase()?.accessToken;
    userVo = await _model.userProfile(token ?? '', kAcceptLanguageEn);
    userCurrentPromotionPoints = userVo?.promotionPoints ?? 0;
    _notifySafely();
  }

  /// Call the API to load the address
  void _loadAddress() {
    _showLoading();
    var accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    _smileShopModel
        .address(accessToken, kAcceptLanguageEn)
        .then((addressResponse) {
      addressList = addressResponse.data?.addressVO ?? [];
      if (addressList.isNotEmpty) {
        defaultAddressVO = addressList.firstWhere((e) => e.isDefault == 1,
            orElse: () => addressList.first);
      } else {
        defaultAddressVO = null;
      }
      deliveryFeePrice = defaultAddressVO?.townshipVO?.deliveryFees ?? 0;
      calculateTotalProductPrice(productList);
      _notifySafely();
    }).catchError((error) {
      if (error.toString().toLowerCase() == 'unauthenticated') {
        showCommonDialog(
          context: context!,
          dialogWidget: SessionExpiredDialogView(),
        );
      }
    }).whenComplete(() => _hideLoading());
  }

  void refreshAddress() {
    _loadAddress();
  }

  void calculateTotalProductPrice(List<ProductVO> productList) {
    if (productList.isNotEmpty) {
      subTotalPrice = productList.map((e) => e.totalPrice ?? 0).toList();
      totalProductPrice =
          subTotalPrice.reduce((first, second) => first + second);
      totalSummaryProductPrice = (totalProductPrice! + deliveryFeePrice);
      _notifySafely();
    } else {
      totalProductPrice = 0;
      _notifySafely();
    }
  }

  void showSnackBar(BuildContext context, String message, Color snackBarColor) {
    final scaffold = ScaffoldMessenger.of(context);

    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: snackBarColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
    scaffold.showSnackBar(snackBar);
  }

  void changeAddress(AddressVO addressVo) {
    defaultAddressVO = addressVo;
    deliveryFeePrice = defaultAddressVO?.townshipVO?.deliveryFees ?? 0;
    totalSummaryProductPrice = (totalProductPrice ?? 0) + deliveryFeePrice;
    _notifySafely();
  }

  void changeSelectedDeliveryOption(DeliveryOptions option) {
    selectedDeliveryOption = option;
    if (selectedDeliveryOption == DeliveryOptions.special ||
        selectedDeliveryOption == DeliveryOptions.pickup) {
      deliveryFeePrice = 0;
      totalSummaryProductPrice = totalProductPrice;
    } else {
      deliveryFeePrice = defaultAddressVO?.townshipVO?.deliveryFees ?? 0;
      totalSummaryProductPrice = (totalProductPrice ?? 0) + deliveryFeePrice;
    }
    _notifySafely();
  }

  // void onTapUsePromotion() {
  //   isSelectedNoPromotion = !isSelectedNoPromotion;
  //   isSelectedUsePromotion = !isSelectedUsePromotion;
  //   notifyListeners();
  // }

  String getTextAccordingToDeliveryOption(BuildContext context) {
    switch (selectedDeliveryOption) {
      case DeliveryOptions.standard:
        return AppLocalizations.of(context)!.standardDelivery;
      case DeliveryOptions.special:
        return AppLocalizations.of(context)!.specialDelivery;
      case DeliveryOptions.pickup:
        return AppLocalizations.of(context)!.pickUp;
      default:
        return '';
    }
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  @override
  void dispose() {
    super.dispose();
    _productListSubscription?.cancel();
    isDisposed = true;
  }
}

enum DeliveryOptions { standard, special, pickup }
