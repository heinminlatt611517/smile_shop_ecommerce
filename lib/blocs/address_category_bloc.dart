import 'package:flutter/foundation.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/category_vo.dart';

class AddressCategoryBloc extends ChangeNotifier {
  /// State
  var accessToken = "";
  int? selectedIndex;
  bool isDisposed = false;
  List<CategoryVO> addressCategories = [];

  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  AddressCategoryBloc(int index) {
    debugPrint("Index:::$index");
    setInitialSelectedIndex(index);
    accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    ///get address categories list
    _smileShopModel.addressCategories(accessToken).then((addressCategoryResponse) {
      addressCategories = addressCategoryResponse;
      _notifySafely();
    });
  }

  void setInitialSelectedIndex(int index){
    selectedIndex = index-1;
    _notifySafely();
  }


  void toggleSelectionAddressCategory(int index) {
    selectedIndex = isSelected(index) ? -1 : index;
    notifyListeners();
  }

  bool isSelected(int index){
    return index == selectedIndex;
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
