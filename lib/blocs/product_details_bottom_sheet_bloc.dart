import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/variant_vo.dart';

class ProductDetailsBottomSheetBloc extends ChangeNotifier {
  int? selectedIndex;
  int? selectedSizeIndex;
  int? quantityCount = 1;
  var selectedColor = "";
  var selectedSize = "";
  int? updateTotalPrice;
  ProductVO? productVO;
  Map<String, List<VariantVO>> allVariantListGroupByColor = {};
  List<VariantVO>? selectedVariantListByColor;
  VariantVO? selectedVariant;

  ProductDetailsBottomSheetBloc(
    this.selectedColor,
    this.updateTotalPrice,
    this.productVO,
  ) {
    allVariantListGroupByColor = productVO?.getColorMapList() ?? {};
    selectedColor = allVariantListGroupByColor.values.isNotEmpty ? allVariantListGroupByColor.values.first.first.colorName ?? '' : '';
    selectedVariantListByColor = allVariantListGroupByColor[selectedColor];
    selectedVariant = selectedVariantListByColor?.first;
    calculateTotalPrice();
    notifyListeners();
  }

  void calculateTotalPrice() {
    updateTotalPrice = (quantityCount ?? 1) * (selectedVariant?.price ?? 1);
    notifyListeners();
  }

  // void toggleSelectionColor(int index, String colorName) {
  //   selectedIndex = isSelected(index) ? -1 : index;
  //   if (isSelected(index) == true) {
  //     selectedColor = colorName;
  //   } else {
  //     selectedColor = "";
  //   }
  //   notifyListeners();
  // }

  // void calculateTotalPrice() {
  //   updateTotalPrice = quantityCount! * updateTotalPrice!;
  //   notifyListeners();
  // }

  bool isSelectedColor(String color) {
    return selectedColor == color;
  }

  bool isSelected(int index) {
    return index == selectedIndex;
  }

  void selectColor(String color) {
    selectedColor = color;
    selectedVariantListByColor = allVariantListGroupByColor[selectedColor];
    selectedVariant = selectedVariantListByColor?.first;
    calculateTotalPrice();
    notifyListeners();
  }

  void selectSize(int id) {
    selectedVariant = selectedVariantListByColor?.firstWhere(
      (element) => element.id == id,
    );
    selectedSize = selectedVariant?.sizeVO?.value ?? '';
    calculateTotalPrice();
    notifyListeners();
  }

  // void toggleSelectionSize(int index, String size) {
  //   selectedSizeIndex = isSelectedSize(index) ? -1 : index;
  //   if (isSelectedSize(index) == true) {
  //     selectedSize = size;
  //   } else {
  //     selectedSize = "";
  //   }
  //   notifyListeners();
  // }

  // bool isSelectedSize(int index) {
  //   return index == selectedSizeIndex;
  // }

  void onTapAdd() {
    quantityCount = (quantityCount! + 1);
    calculateTotalPrice();
    notifyListeners();
  }

  void showTopSnackBar(BuildContext context, String message, Color snackBarColor) {
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

  void onTapMinus() {
    if (quantityCount! > 1) {
      quantityCount = (quantityCount! - 1);
      calculateTotalPrice();
      notifyListeners();
    }
  }
  
}
