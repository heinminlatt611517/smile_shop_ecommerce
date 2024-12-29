import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';

class ProductDetailsBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ProductVO? productVO;
  bool isLoading = false;
  bool isDisposed = false;
  var selectedColorName = "";

  ProductDetailsBloc(String productId) {
    ///get data from database
    var authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "";

    ///get brands and categories
    _smileShopModel
        .getProductDetails(endUserId, productId, kAcceptLanguageEn, authToken)
        .then((productDetailsResponse) {
      productVO = productDetailsResponse;
      selectedColorName = productVO?.variantVO?.first.colorName ?? "";
      notifyListeners();
    });
  }

  void onTapAddToCart(BuildContext context) {
    if (productVO != null) {
      var oldProduct =
          _smileShopModel.getProductByIdFromDatabase(productVO?.id ?? 0);
      if (oldProduct == null) {
        _smileShopModel.saveProductToHive(
            productVO?.copyWith(totalPrice: productVO?.price, qtyCount: 1,colorName: selectedColorName) ??
                ProductVO());

        showSnackBar(context, '${productVO?.name} added to cart successfully!',Colors.green);
      } else {
        int initialPrice = oldProduct.price!;
        var newProductVO = oldProduct.copyWith(qtyCount: oldProduct.qtyCount!+1);
        var updatedTotalPrice = newProductVO.qtyCount! * (initialPrice);
        _smileShopModel.saveProductToHive(newProductVO.copyWith(totalPrice: updatedTotalPrice,colorName: selectedColorName));
        showSnackBar(context, '${productVO?.name} added to cart successfully!',Colors.green);
      }
    } else {
      showSnackBar(context, 'Failed to add product to cart.',Colors.red);
    }
  }

  void onTapColor(String colorName){
    selectedColorName = colorName;
    _notifySafely();
  }

  void onTapFavourite(ProductVO? product,BuildContext context){
    _smileShopModel.saveFavouriteProductToHive(
        product?.copyWith(isFavourite: true,image: product.images?.first,) ??
            ProductVO());

    showSnackBar(context, '${product?.name} added to favourite successfully!',Colors.green);
  }

  void showSnackBar(BuildContext context, String description,Color snackBarColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(description),
        backgroundColor: snackBarColor,
        duration: const Duration(seconds: 2),
      ),
    );
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
}
