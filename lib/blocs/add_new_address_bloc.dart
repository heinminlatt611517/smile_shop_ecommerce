import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/state_vo.dart';
import 'package:smile_shop/data/vos/township_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/requests/address_request.dart';

class AddNewAddressBloc extends ChangeNotifier {
  /// State
  bool isTownshipLoading = false;
  bool isLoading = false;
  bool isDisposed = false;
  bool isChecked = false;
  bool isSelectedHome = true;
  bool isSelectedOffice = false;
  var accessToken = "";
  var phone = "";
  var name = "";
  int? stateId;
  int? regionId;
  int? isDefault;
  int? townshipId;
  List<StateVO> states = [];
  List<TownshipVO> townships = [];

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  AddNewAddressBloc() {
    accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    ///get state list
    _smileShopModel.states().then((stateResponse) {
      states = stateResponse;
      fetchTownshipsByStateId(states.first.id ?? 0);
      _notifySafely();
    });
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
  Future onTapSave() {
    if (_validateAddressFields()) {
      var addressRequest = AddressRequest(
          phone: phone,
          address: name,
          stateId: stateId,
          regionId: regionId,
          isDefault: isChecked == true ? 1 : 0,
          categoryId: isSelectedHome == true ? 1 : 2);

      _showLoading();
      return _smileShopModel
          .addNewAddress(accessToken, kAcceptLanguageEn, addressRequest)
          .whenComplete(() => _hideLoading());
    } else {
      return Future.error("");
    }
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
    if (regionId == null) {
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
    this.townshipId = townshipId;
    _notifySafely();
  }

  void onTapHomeAddress() {
    isSelectedHome = true;
    isSelectedOffice = false;
    _notifySafely();
  }

  void onTapOffice() {
    isSelectedHome = false;
    isSelectedOffice = true;
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
