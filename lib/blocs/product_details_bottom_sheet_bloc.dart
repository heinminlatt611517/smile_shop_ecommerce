import 'package:flutter/material.dart';

class ProductDetailsBottomSheetBloc extends ChangeNotifier {

  int? selectedIndex;
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
}
