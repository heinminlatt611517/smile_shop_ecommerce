import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';

import '../data/vos/address_vo.dart';
import '../network/api_constants.dart';
import '../widgets/common_dialog.dart';
import '../widgets/session_expired_dialog_view.dart';

class CheckOutBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///states
  StreamSubscription? _productListSubscription;
  int? totalProductPrice;
  int? totalSummaryProductPrice;
  int deliveryFeePrice = 0;
  List<int> subTotalPrice = [];
  List<AddressVO> addressList = [];
  bool isDisposed = false;
  bool isSelectedStandardDelivery = true;
  bool isSelectedSpecialDelivery = false;
  BuildContext? context;

  bool isSelectedUsePromotion = true;
  bool isSelectedNoPromotion = false;

  CheckOutBloc(List<ProductVO> productList,this.context) {
    if (productList.isNotEmpty) {
      calculateTotalProductPrice(productList);
    }

    ///load address
    _loadAddress();
  }

  /// Call the API to load the address
  void _loadAddress() {
    var accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    _smileShopModel
        .address(accessToken, kAcceptLanguageEn)
        .then((addressResponse) {
      addressList = addressResponse.data?.addressVO ?? [];
      notifyListeners();
    }).catchError((error){
      if (error.toString().toLowerCase() == 'unauthenticated') {
        showCommonDialog(
          context: context!,
          dialogWidget: SessionExpiredDialogView(),
        );
      }
    });
  }

  void refreshAddress() {
    debugPrint("RefreshAddress");
    _loadAddress();
  }

  void calculateTotalProductPrice(List<ProductVO> productList) {
    if (productList.isNotEmpty) {
      subTotalPrice = productList.map((e) => e.totalPrice!).toList();
      totalProductPrice =
          subTotalPrice.reduce((first, second) => first + second);
      totalSummaryProductPrice = (totalProductPrice! + deliveryFeePrice);
      _notifySafely();
    } else {
      totalProductPrice = 0;
      _notifySafely();
    }
  }

  void onTapAddStandardDelivery() {
    isSelectedStandardDelivery = !isSelectedStandardDelivery;
    isSelectedSpecialDelivery = !isSelectedSpecialDelivery;
    notifyListeners();
  }

  void onTapUsePromotion(){
    isSelectedNoPromotion = !isSelectedNoPromotion;
    isSelectedUsePromotion = !isSelectedUsePromotion;
    notifyListeners();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _productListSubscription?.cancel();
    isDisposed = true;
  }
}
