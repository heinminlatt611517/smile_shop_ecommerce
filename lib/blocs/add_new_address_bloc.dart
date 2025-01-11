import 'package:flutter/cupertino.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
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
  var accessToken = "";
  var phone = "";
  var name = "";
  int? stateId;
  int? isDefault;
  int? townshipId;
  List<StateVO> states = [];
  List<TownshipVO> townships = [];
  List<CategoryVO> addressCategories = [];
  int? addressCategoryId = 1;
  TextEditingController mapAddressNameController = TextEditingController();
  String googleMapName = "";

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

    ///get address categories list
    _smileShopModel
        .addressCategories(accessToken)
        .then((addressCategoryResponse) {
      addressCategories = addressCategoryResponse;
      _notifySafely();
    });
  }

  void onChangedGoogleMapNamed(String name) {
    googleMapName = name;
    _notifySafely();
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
  Future<void> onTapSave(BuildContext context) async {
    var addressRequest = AddressRequest();

    try {
      if (googleMapName.isNotEmpty) {
        addressRequest = AddressRequest(
          phone: phone,
          address: googleMapName,
          name: name,
          isDefault: isChecked == true ? 1 : 0,
          categoryId: addressCategoryId,
        );
        if (name == "") {
          throw ('Please enter your name');
        } else if (phone == "") {
          throw ('Please enter your phone number');
        } else if (stateId == null) {
          throw ('Please select state');
        } else if (townshipId == null) {
          throw ('Please select township');
        }
      } else {
        addressRequest = AddressRequest(
          phone: phone,
          address: name,
          name: name,
          stateId: stateId,
          regionId: stateId,
          townshipId: townshipId,
          isDefault: isChecked == true ? 1 : 0,
          categoryId: addressCategoryId,
        );

        if (name == "") {
          throw ('Please enter your name');
        } else if (phone == "") {
          throw ('Please enter your phone number');
        } else if (stateId == null) {
          throw ('Please select state');
        } else if (townshipId == null) {
          throw ('Please select township');
        }
      }
      _showLoading();
      await _smileShopModel.addNewAddress(
          accessToken, kAcceptLanguageEn, addressRequest);
    } finally {
      _hideLoading();
    }
  }

  Future onTapDeleteAddress(int addressId) {
    _showLoading();
    return _smileShopModel
        .deleteAddress(accessToken, addressId)
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
