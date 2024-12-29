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
  var updateName = "";
  final nameController = TextEditingController();

  EditProfileBloc(this.profileVO) {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    nameController.text = profileVO?.name ?? '';
  }

  uploadImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      var pickFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if(pickFile != null){
        imgFile = File(pickFile.path ?? '');
        updateProfile(File(pickFile.path ?? ''));
      }
    } catch (e) {
      ///
    }
  }

  void getProfile(){
    _showLoading();
    _smileShopModel.userProfile(authToken, kAcceptLanguageEn).then((response){
      profileVO = response;
      nameController.text = profileVO?.name ?? '';
      _notifySafely();
    }).whenComplete(()=> _hideLoading());
  }

  Future updateProfile(File imageFilePath) {
    _showLoading();
    return _smileShopModel
        .updateProfile(authToken, kAcceptLanguageEn,profileVO?.name ?? "", imageFilePath)
        .whenComplete(() {
      _hideLoading();
    });
  }

  Future<ProfileResponse> onTapConfirm() {
    _showLoading();
    return _smileShopModel
        .updateProfileName(authToken, kAcceptLanguageEn, updateName)
        .whenComplete(() {
      getProfile();
    });
  }

  void onChangedName(String name){
    updateName = name;
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
