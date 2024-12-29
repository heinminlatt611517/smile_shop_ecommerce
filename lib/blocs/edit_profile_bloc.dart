import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_shop/data/vos/profile_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/responses/profile_response.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';

class EditProfileBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();
  File? imgFile;
  bool isLoading = false;
  bool isDisposed = false;
  var authToken = "";
  ProfileVO? profileVO;

  EditProfileBloc(this.profileVO) {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
  }

  uploadImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      var pickFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      imgFile = File(pickFile?.path ?? '');
      updateProfile(File(pickFile?.path ?? ''));
    } catch (e) {
      ///
    }
  }

  Future updateProfile(File imageFilePath) {
    debugPrint("call update file>>>>>$imageFilePath");
    _showLoading();
    return _smileShopModel
        .updateProfile(authToken, kAcceptLanguageEn,profileVO?.name ?? "", imageFilePath)
        .whenComplete(() {
      _hideLoading();
    });
  }

  Future<ProfileResponse> onTapConfirm({required String name}) {
    _showLoading();
    return _smileShopModel
        .updateProfile(authToken, kAcceptLanguageEn, name, File(profileVO?.profileImage ?? ""))
        .whenComplete(() {
      _hideLoading();
    });
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
