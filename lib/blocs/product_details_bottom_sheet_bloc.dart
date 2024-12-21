import 'package:flutter/material.dart';

class ProductDetailsBottomSheetBloc extends ChangeNotifier {

  int? selectedIndex;
  int? quantityCount = 1;
  final List<String> colors = [
    "Black",
    "White",
    "Orange"
  ];

  void toggleSelectionColor(int index) {
    selectedIndex = isSelected(index) ? -1 : index;
    notifyListeners();
  }

  bool isSelected(int index){
    return index == selectedIndex;
  }

  void onTapAdd(){
    quantityCount = (quantityCount!+1);
    notifyListeners();
  }

  void onTapMinus(){
    if(quantityCount! > 0){
      quantityCount = (quantityCount!-1);
      notifyListeners();
    }
  }

}
