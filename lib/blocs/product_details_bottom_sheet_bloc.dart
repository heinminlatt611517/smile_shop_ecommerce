import 'package:flutter/material.dart';

class ProductDetailsBottomSheetBloc extends ChangeNotifier {

  int? selectedIndex;
  int? selectedSizeIndex;
  int? quantityCount = 1;
  var selectedColor = "";
  var selectedSize = "";
  int? updateTotalPrice;

  ProductDetailsBottomSheetBloc(this.selectedColor,this.updateTotalPrice){
  }

  void toggleSelectionColor(int index,String colorName) {
    selectedIndex = isSelected(index) ? -1 : index;
    if(isSelected(index) == true){
      selectedColor = colorName;
    }
    else {
      selectedColor = "";
    }
    notifyListeners();
  }

  void calculateTotalPrice(){
    updateTotalPrice = quantityCount! * updateTotalPrice!;
    notifyListeners();
  }

  bool isSelected(int index){
    return index == selectedIndex;
  }

  void toggleSelectionSize(int index,String size) {
    selectedSizeIndex = isSelectedSize(index) ? -1 : index;
    if(isSelectedSize(index) == true){
      selectedSize = size;
    }
    else {
     selectedSize = "";
    }
    notifyListeners();
  }

  bool isSelectedSize(int index){
    return index == selectedSizeIndex;
  }

  void onTapAdd(){
    quantityCount = (quantityCount!+1);
    calculateTotalPrice();
    notifyListeners();
  }

  void showTopSnackBar(BuildContext context, String message,Color snackBarColor) {
    final scaffold = ScaffoldMessenger.of(context);

    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor:snackBarColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
    scaffold.showSnackBar(snackBar);
  }

  void onTapMinus(){
    if(quantityCount! > 1){
      quantityCount = (quantityCount!-1);
      calculateTotalPrice();
      notifyListeners();
    }
  }

}
