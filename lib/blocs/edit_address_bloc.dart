import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/data/vos/state_vo.dart';
import 'package:smile_shop/data/vos/township_vo.dart';
import 'package:smile_shop/network/requests/address_request.dart';

class EditAddressBloc extends ChangeNotifier {
  /// State
  bool isTownshipLoading = false;
  bool isLoading = false;
  bool isDisposed = false;
  bool isChecked = false;
  var accessToken = "";
  var phone = "";
  var name = "";
  int? stateId;
  int? isDefault;
  int? townshipId;
  List<StateVO> states = [];
  List<TownshipVO> townships = [];
  int? addressCategoryId;

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  EditAddressBloc(AddressVO? addressVO) {
    ///init address data
    initAddressData(addressVO);

    accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    ///get state list
    _smileShopModel.states().then((stateResponse) {
      states = stateResponse;
      fetchTownshipsByStateId(addressVO?.stateVO?.id ?? 0);
      _notifySafely();
    });
  }

  void initAddressData(AddressVO? addressVO){
     phone = addressVO?.phone ?? "";
     name = addressVO?.address ?? "";
     stateId = addressVO?.stateId;
     isDefault = addressVO?.isDefault;
     townshipId = addressVO?.townshipId;
     addressCategoryId = addressVO?.categoryId;
     isChecked = addressVO?.isDefault == 1 ? true : false;
     notifyListeners();
  }

  ///fetch townships by state id
  void fetchTownshipsByStateId(int stateId) {
    _showTownshipLoading();
    _smileShopModel.townships(stateId).then((townshipResponse) {
      townships = [];
      townships = townshipResponse.townships ?? [];
      townshipId = townships.first.id;
      _hideTownshipLoading();
      _notifySafely();
    });
  }

  ///save
  Future onTapSave(int addressId) {
      var addressRequest = AddressRequest(
          phone: phone,
          address: name,
          name: name,
          stateId: stateId,
          regionId: stateId,
          townshipId: townshipId,
          isDefault: isChecked == true ? 1 : 0,
          categoryId: addressCategoryId);

      _showLoading();
      return _smileShopModel
          .editAddress(accessToken, addressId, addressRequest)
          .whenComplete(() => _hideLoading());
  }

  Future onTapDeleteAddress(int addressId){
    _showLoading();
    return _smileShopModel
        .deleteAddress(accessToken,addressId)
        .whenComplete(() => _hideLoading());
  }

  bool _validateAddressFields() {
    if (phone == "" || phone.isEmpty) {
      return false;
    }
    if (name == "" || name.isEmpty) {
      return false;
    }
    if (stateId == null) {
      return false;
    }
    if (townshipId == null) {
      return false;
    }

    return true;
  }

  void onPhoneNumberChanged(String phone) {
    this.phone = phone;
    _notifySafely();
  }

  void onNameChanged(String name) {
    this.name = name;
    _notifySafely();
  }

  void onStateIdChanged(int stateId) {
    this.stateId = stateId;
    fetchTownshipsByStateId(stateId);
    _notifySafely();
  }

  void onTownshipIdChanged(int townshipId) {
    debugPrint("Id:::$townshipId");
    this.townshipId = townshipId;
    _notifySafely();
  }

  void onTapAddressCategory(int id) {
    debugPrint("Id:::$id");
    addressCategoryId = id;
    _notifySafely();
  }

  void _showTownshipLoading() {
    isTownshipLoading = true;
    _notifySafely();
  }

  void onCheckChange() {
    isChecked = !isChecked;
    notifyListeners();
  }

  void _hideTownshipLoading() {
    isTownshipLoading = false;
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
