import 'package:flutter/material.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:video_player/video_player.dart';

class ProductDetailsBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ProductVO? productVO;
  bool isLoading = false;
  bool isDisposed = false;
  VideoPlayerController? videoPlayerController;

  ProductDetailsBloc(String productId) {
    ///get data from database
    var authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    var endUserId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ?? "";

    ///get brands and categories
    _smileShopModel.getProductDetails(endUserId, productId, kAcceptLanguageEn, authToken).then((productDetailsResponse) {
      productVO = productDetailsResponse;
      if (productVO?.video?.isNotEmpty ?? false) {
        videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(productVO?.video ?? ''))
          ..initialize()
          ..setLooping(true)
          ..play();
      }
      //selectedColorName = productVO?.variantVO?.first.colorName ?? "";
      notifyListeners();
    });
  }

  void onTapAddToCart(BuildContext context, String selectedColorName, String selectedSize, int qtyCount, int totalPrice) {
    if (productVO != null) {
      var oldProduct = _smileShopModel.getProductByIdFromDatabase(productVO?.id ?? 0);
      if (oldProduct == null) {
        _smileShopModel.saveProductToHive(productVO?.copyWith(totalPrice: totalPrice, qtyCount: qtyCount, colorName: selectedColorName, size: selectedSize) ?? ProductVO());

        showSuccessTopSnackBar(context, '${productVO?.name} added to cart successfully!');
      } else {
        int initialPrice = oldProduct.variantVO?.first.price ?? 0;
        var newProductVO = oldProduct.copyWith(qtyCount: oldProduct.qtyCount! + qtyCount);
        var updatedTotalPrice = newProductVO.qtyCount! * (initialPrice);
        _smileShopModel.saveProductToHive(newProductVO.copyWith(totalPrice: updatedTotalPrice, colorName: selectedColorName, size: selectedSize));
        showSuccessTopSnackBar(context, '${productVO?.name} added to cart successfully!');
      }
    } else {
      showSnackBar(context, 'Failed to add product to cart.', Colors.red);
    }
  }

  // void onTapColor(String colorName) {
  //   selectedColorName = colorName;
  //   _notifySafely();
  // }
  //
  // void onTapSize(String size) {
  //   selectedSizeName = size;
  //   _notifySafely();
  // }

  void showSuccessTopSnackBar(BuildContext context, String description) {
    showTopSnackBar(
      displayDuration: const Duration(milliseconds: 300),
      Overlay.of(context),
      CustomSnackBar.success(
        message: description,
      ),
    );
  }

  void onTapFavourite(ProductVO? product, BuildContext context) {
    _smileShopModel.saveFavouriteProductToHive(product?.copyWith(
          isFavourite: true,
          image: product.images?.first,
        ) ??
        ProductVO());

    showSnackBar(context, '${product?.name} added to favourite successfully!', Colors.green);
  }

  void showSnackBar(BuildContext context, String description, Color snackBarColor) {
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

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }
}
