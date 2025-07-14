import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/cart_item_vo.dart';
import 'package:smile_shop/data/vos/login_data_vo.dart';

class CartBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///Products to show
  List<CartItemVo> productList = [];
  int? totalProductPrice;
  List<int> subTotalPrice = [];
  bool isDisposed = false;
  bool isAllSelectedProduct = false;

  //To check User is logged in user
  LoginDataVO? loginDataVO;
  late StreamSubscription<List<CartItemVo>> _cartSubscription;

  CartBloc() {
    getLogInUserData();

    ///first time get products from database
    getItemList();
    _cartSubscription = _smileShopModel.getCartItemsStreamFromDatabase().listen(
      (event) {
        getItemList();
        calculateTotalProductPrice();
        checkAllProductIsSelected();
        _notifySafely();
      },
    );

    if (productList.isNotEmpty) {
      calculateTotalProductPrice();
      checkAllProductIsSelected();
    }
  }

  void getLogInUserData() async {
    loginDataVO = _smileShopModel.getLoginResponseFromDatabase();
    _notifySafely();
  }

  void onTapSelectAll() {
    print("IS ALL SELECTED ======> $isAllSelectedProduct");
    _smileShopModel.setAllCartItemSelected(!isAllSelectedProduct);
    _notifySafely();
  }

  void getItemList() {
    productList = _smileShopModel.getAllCartItemsFromDatabase();
    notifyListeners();
  }

  void onTapChecked(CartItemVo productVO) {
    _smileShopModel.toggelCartItemSelected(productVO.variantId ?? '');
    calculateTotalProductPrice();
    checkAllProductIsSelected();
  }

  void checkAllProductIsSelected() {
    for (var product in productList) {
      if (product.isSelected == false) {
        isAllSelectedProduct = false;
        break;
      } else {
        isAllSelectedProduct = true;
      }
    }
    _notifySafely();
  }

  void onTapIncreaseQty(CartItemVo productVO) {
    int newQuantity = (productVO.quantity ?? 0) + 1;
    print("NEW QUANTITY ==============> $newQuantity");
    _smileShopModel.updateCartItemQuantity(
        productVO.variantId ?? '', newQuantity);
    calculateTotalProductPrice();
    _notifySafely();
  }

  void onTapDecreaseQty(CartItemVo productVO) {
    int newQuantity = (productVO.quantity ?? 0) - 1;
    print("NEW QUANTITY ==============> $newQuantity");
    _smileShopModel.updateCartItemQuantity(
        productVO.variantId ?? '', newQuantity);
    calculateTotalProductPrice();
    _notifySafely();
  }

  void calculateTotalProductPrice() {
    totalProductPrice = _smileShopModel.getTotalPriceOfSelectedItems();
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cartSubscription.cancel();
    isDisposed = true;
  }
}
