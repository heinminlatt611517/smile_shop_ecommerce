import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_shop/data/vos/refund_reason_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class ProductRefundBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();
  File? imgFile;
  bool isLoading = false;
  bool isDisposed = false;
  var authToken = "";
  int? orderId;
  int? reasonId;
  final nameController = TextEditingController();
  List<RefundReasonVO> refundReason = [];

  ProductRefundBloc(this.orderId) {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    getRefundReasons();
  }

  void getRefundReasons() {
    _showLoading();
    _smileShopModel
        .getRefundReasons(kAcceptLanguageEn, authToken)
        .then((response) {
      refundReason = response;
      _notifySafely();
    }).whenComplete(() => _hideLoading());
  }

  uploadImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      var pickFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (pickFile != null) {
        imgFile = File(pickFile.path ?? '');
        _notifySafely();
      }
    } catch (e) {
      ///
    }
  }

  Future onTapDone() {
    _showLoading();
    return _smileShopModel
        .postRefund(
            authToken, kAcceptLanguageEn, orderId ?? 0, reasonId ?? 0, imgFile)
        .whenComplete(() {
      _hideLoading();
    });
  }

  void onChangedReasonId(int id) {
    reasonId = id;
    _notifySafely();
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
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
    isDisposed = true;
  }
}
