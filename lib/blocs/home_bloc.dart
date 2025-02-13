import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/brand_and_category_vo.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/requests/favourite_product_request.dart';
import 'package:smile_shop/network/requests/pop_up_request.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/session_expired_dialog_view.dart';
import 'package:smile_shop/widgets/welcome_dialog_view.dart';

import '../data/vos/user_vo.dart';
import '../widgets/common_dialog.dart';

class HomeBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  List<BannerVO> banners = [];
  List<CategoryVO> categories = [];
  List<ProductVO> productList = [];
  BrandAndCategoryVO? brandAndCategoryVO;
  int productPage = 1;
  var authToken = "";
  var endUserId = "";
  var accessToken = "";
  bool isLoading = false;
  bool isDisposed = false;
  bool isPopupLoading = false;
  UserVO? userProfile;
  var currentLanguage = kAcceptLanguageEn;
  String currentFlagImage = kEnglishImg;
  final Map<String, String> languageFlagMap = {
    'en': kEnglishImg,
    'my': kMyanmarImg,
    'zh': kChinaImg,
  };

  HomeBloc(BuildContext context) {
    ///get data from database
    authToken = _smileShopModel.getLoginResponseFromDatabase()?.refreshToken ?? "";
    accessToken = _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";
    endUserId = _smileShopModel.getLoginResponseFromDatabase()?.data?.id.toString() ?? "";
    init();

    ///get user profile data
    _smileShopModel.userProfile(accessToken, kAcceptLanguageEn).then((response) {
      userProfile = response;
      if (response.showPopUp == 0) {
        getHomePopupData(response.id ?? 0, context);
      }
      _notifySafely();
    }).catchError((error) {
      if (error.toString().toLowerCase() == 'unauthenticated') {
        showCommonDialog(
          context: context,
          dialogWidget: SessionExpiredDialogView(),
        );
      }
    });
  }
  void init() {
    loadLanguage();
    _loadData();
  }

  ///load language
  Future<void> loadLanguage() async {
    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode == null) {
      currentLanguage = kAcceptLanguageEn;
      currentFlagImage = kEnglishImg;
    } else if (languageCode == "my") {
      currentLanguage = kAcceptLanguageMM;
      currentFlagImage = kMyanmarImg;
    } else if (languageCode == "zh") {
      currentLanguage = kAcceptLanguageCh;
      currentFlagImage = kChinaImg;
    } else {
      currentLanguage = kAcceptLanguageEn;
      currentFlagImage = kEnglishImg;
    }
    _notifySafely();
    _loadData();
  }

  Future<void> _loadData() async {
    ///get banner list
    _smileShopModel.banners(kAcceptLanguageEn).then((bannerResponse) {
      banners = bannerResponse;
      _notifySafely();
    });

    ///get categories list
    _smileShopModel.categories("home", currentLanguage).then((categoryResponse) {
      categories = categoryResponse;
      _notifySafely();
    });

    ///get product list
    _smileShopModel.products(accessToken, currentLanguage, int.parse(endUserId), productPage).then((productResponse) {
      productList = productResponse.products ?? [];
      debugPrint("Length>>>>>>>${productList.length}");
      _notifySafely();
    });

    ///get brands and categories
    _smileShopModel.getBrandsAndCategories(authToken, kAcceptLanguageEn, endUserId).then((brandsAndCategoriesResponse) {
      brandAndCategoryVO = brandsAndCategoriesResponse;
      _notifySafely();
    });
  }

  ///get home popup data
  void getHomePopupData(int userId, BuildContext context) {
    var popUpRequest = PopupRequest(userId);
    _smileShopModel.getHomePopUpData(kAcceptLanguageEn, accessToken, popUpRequest).then((response) {
      ///welcome pop up
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCommonDialog(
            context: context,
            dialogWidget: WelcomeDialogView(
              showLoading: isPopupLoading,
              title: response.title ?? "",
              message: response.message ?? "",
              onPressOk: () {
                updateHomePopupData(userId, context);
              },
            ),
            isDismissible: false);
      });
    });
  }

  void updateHomePopupData(int userId, BuildContext context) {
    _showPopupLoading();
    var popUpRequest = PopupRequest(userId);
    _smileShopModel.updateHomePopUp(kAcceptLanguageEn, accessToken, popUpRequest).then((response) {
      if (response.status == 200) {
        Navigator.pop(context);
      }
    }).whenComplete(() => _hidePopupLoading());
  }

  void getProducts() {
    if (isLoading) return;
    _showLoading();

    productPage += 1;
    debugPrint("GetProducts for page $productPage");

    _smileShopModel.products(accessToken, currentLanguage, int.parse(endUserId), productPage).then((productResponse) {
      if (productResponse.products != null && productResponse.products!.isNotEmpty) {
        productList.addAll(productResponse.products!);
        _hideLoading();
      } else {
        _hideLoading();
      }
    });
  }

  void onTapFavourite(ProductVO? product, BuildContext context) {
    if (product == null) return;
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
        final updatedProduct = product.copyWith(
          isFavouriteProduct: !(product.isFavouriteProduct ?? false),
        );

        final productIndex = productList.indexWhere((p) => p.id == product.id);
        if (productIndex != -1) {
          productList[productIndex] = updatedProduct;
        }

        _notifySafely();

        showSnackBar(
          context,
          '${product.name} ${updatedProduct.isFavouriteProduct ?? true ? 'added to' : 'removed from'} favourites!',
          updatedProduct.isFavouriteProduct ?? true ? Colors.green : Colors.red,
        );
      }
    }).catchError((error) {
      showSnackBar(context, 'Error updating favourite status', Colors.red);
    });
  }

  void getProductsWhileOnTapFavourite() {
    productList.clear();
    productPage = 1;
    _smileShopModel.products(authToken, currentLanguage, int.parse(endUserId), 1).then((productResponse) {
      if (productResponse.products != null && productResponse.products!.isNotEmpty) {
        productList.addAll(productResponse.products!);
        _hideLoading();
      } else {
        _hideLoading();
      }
    });
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

  void _showPopupLoading() {
    isPopupLoading = true;
    _notifySafely();
  }

  void _hidePopupLoading() {
    isPopupLoading = false;
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
