import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/campaign_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/user_vo.dart';

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
  bool isSelectedStandardDelivery = true;
  bool isSelectedSpecialDelivery = false;
  BuildContext? context;
  var addressForShow = "";
  bool isSelectedUsePromotion = true;
  bool isSelectedNoPromotion = false;
  final SmileShopModel _model = SmileShopModelImpl();
  CheckOutBloc(List<ProductVO> productList, this.context) {
    if (productList.isNotEmpty) {
      calculateTotalProductPrice(productList);
    }

    ///load address
    _loadAddress();
    getUser();
  }

  void getUser() async {
    String? token = _smileShopModel.getLoginResponseFromDatabase()?.accessToken;
    userVo = await _model.userProfile(token ?? '', kAcceptLanguageEn);
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

  void onChangedAddressForShow(String newAddress) {
    addressForShow = newAddress;
    _notifySafely();
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
    _notifySafely();
  }

  void onTapAddStandardDelivery() {
    isSelectedStandardDelivery = !isSelectedStandardDelivery;
    isSelectedSpecialDelivery = !isSelectedSpecialDelivery;
    notifyListeners();
  }

  void onTapUsePromotion() {
    isSelectedNoPromotion = !isSelectedNoPromotion;
    isSelectedUsePromotion = !isSelectedUsePromotion;
    notifyListeners();
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
