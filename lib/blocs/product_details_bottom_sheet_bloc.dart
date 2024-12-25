import 'package:flutter/material.dart';

class ProductDetailsBottomSheetBloc extends ChangeNotifier {

  int? selectedIndex;
  int? quantityCount = 1;
  var selectedColor = "";
  int? updateTotalPrice;


  ProductDetailsBottomSheetBloc(this.selectedColor,this.updateTotalPrice){
  }

  void toggleSelectionColor(int index,String colorName) {
    selectedColor = colorName;
    selectedIndex = isSelected(index) ? -1 : index;
    notifyListeners();
  }

  void calculateTotalPrice(){
    updateTotalPrice = quantityCount! * updateTotalPrice!;
    notifyListeners();
  }

  bool isSelected(int index){
    return index == selectedIndex;
  }

  void onTapAdd(){
    quantityCount = (quantityCount!+1);
    calculateTotalPrice();
    notifyListeners();
  }

  void onTapMinus(){
    if(quantityCount! > 0){
      quantityCount = (quantityCount!-1);
      calculateTotalPrice();
      notifyListeners();
    }
  }

}
