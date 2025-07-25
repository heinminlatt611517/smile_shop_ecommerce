import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/cart_item_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:video_player/video_player.dart';
import 'package:smile_shop/localization/app_localizations.dart';

import '../network/requests/favourite_product_request.dart';

class ProductDetailsBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ProductVO? productVO;
  bool isLoading = false;
  bool isDisposed = false;
  VideoPlayerController? videoPlayerController;
  var currentLanguage = kAcceptLanguageEn;
  var endUserId = "";
  var accessToken = "";
  var productId = "";
  bool isVideoMute = false;

  ProductDetailsBloc(this.productId) {
    loadData();

    ///get data from database
    accessToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    endUserId =
        _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ??
            "0";
  }

  void onTapAddToCart(BuildContext context, CartItemVo? cartItem) {
    if (cartItem != null) {
      _smileShopModel.saveCartItemToHive(cartItem);
    } else {
      showSnackBar(context, 'Failed to add product to cart.', Colors.red);
    }
  }

  Future<void> loadData() async {
    await _loadLanguage();
    _getItemDetail();
  }

  Future<void> _loadLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode == null) {
      currentLanguage = kAcceptLanguageEn;
    } else if (languageCode == "my" || languageCode == "my-MM") {
      currentLanguage = kAcceptLanguageMM;
    } else if (languageCode == "zh") {
      currentLanguage = kAcceptLanguageCh;
    } else {
      currentLanguage = kAcceptLanguageEn;
    }
    _notifySafely();
  }

  Future<void> _getItemDetail() async {
    print("CURRENT LANGUAGE ===============> $currentLanguage");

    ///get product details
    _smileShopModel
        .getProductDetails(endUserId, productId, currentLanguage, accessToken)
        .then((productDetailsResponse) {
      productVO = productDetailsResponse;
      if (productVO?.video?.isNotEmpty ?? false) {
        videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(productVO?.video ?? ''))
              ..initialize()
              ..setLooping(true)
              ..play();
      }
      //selectedColorName = productVO?.variantVO?.first.colorName ?? "";
      _notifySafely();
    });
  }

  void onTapMute() {
    videoPlayerController?.setVolume(isVideoMute ? 50 : 0);
    isVideoMute = !isVideoMute;
    _notifySafely();
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
    if (product == null) return;
    if (endUserId.isEmpty || endUserId == "0") {
      showSnackBar(
          context, AppLocalizations.of(context)!.need_login, Colors.deepOrange);
      return;
    }
    var favoriteProductRequest = FavouriteProductRequest(
      productId: product.id,
      status: product.isFavouriteProduct == true ? 'unfavourite' : 'favourite',
    );

    _smileShopModel
        .addFavouriteProduct(
      accessToken,
      kAcceptLanguageEn,
      favoriteProductRequest,
    )
        .then((response) {
      if (response.status == 200) {
        _showLoading();
        _smileShopModel
            .getProductDetails(
                endUserId, productId, currentLanguage, accessToken)
            .then((productDetailsResponse) {
          productVO = productDetailsResponse;
          if (productVO?.video?.isNotEmpty ?? false) {
            videoPlayerController = VideoPlayerController.networkUrl(
                Uri.parse(productVO?.video ?? ''))
              ..initialize()
              ..setLooping(true)
              ..play();
          }
          showSnackBar(
            context,
            '${productVO?.name} ${productVO?.isFavouriteProduct ?? true ? 'added to' : 'removed from'} favourites!',
            productVO?.isFavouriteProduct ?? true ? Colors.green : Colors.red,
          );
          _notifySafely();
        }).whenComplete(() => _hideLoading());
      }
    }).catchError((error) {
      showSnackBar(context, 'Error updating favourite status', Colors.red);
    });
    // _smileShopModel.saveFavouriteProductToHive(product?.copyWith(
    //       isFavourite: true,
    //       image: product.images?.first,
    //     ) ??
    //     ProductVO());
    //
    // showSnackBar(context, '${product?.name} added to favourite successfully!', Colors.green);
  }

  void showSnackBar(
      BuildContext context, String description, Color snackBarColor) {
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
    _notifySafely();
    super.dispose();
  }
}
