import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smile_shop/network/requests/order_status_request.dart';
import 'package:smile_shop/utils/strings.dart';
import 'package:smile_shop/widgets/qr_dialog_view.dart';
import 'package:smile_shop/widgets/set_wallet_password_dialog_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';
import '../data/vos/order_variant_vo.dart';
import '../data/vos/payment_vo.dart';
import '../data/vos/product_vo.dart';
import '../network/api_constants.dart';
import '../network/requests/check_wallet_amount_request.dart';
import '../network/requests/check_wallet_password_request.dart';
import '../pages/order_successful_page.dart';
import '../widgets/common_dialog.dart';
import '../widgets/error_dialog_view.dart';
import '../widgets/session_expired_dialog_view.dart';

class PaymentBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  /// State
  bool isLoading = false;
  bool isDisposed = false;
  var authToken = "";
  List<PaymentVO> payments = [];
  List<ProductVO> products = [];
  int? selectedIndex;
  int? selectedSubPaymentIndex;
  int currentSubPaymentIndex = 0;
  var selectedPaymentType = "";
  bool showEnterAmountTextFiled = false;
  Map<int, int> selectedSubPaymentIndices = {};

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, String> paymentData = {};

  PaymentBloc(this.products, BuildContext context) {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    debugPrint(authToken);

    ///get payment method list
    _smileShopModel
        .payments(authToken, kAcceptLanguageEn, kParamOrder)
        .then((paymentListResponse) {
      payments = paymentListResponse;
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

  ///check out
  Future<void> onTapCheckout(
      int promotionPoint,
      int subTotal,
      List<OrderVariantVO> variantVOList,
      BuildContext context,
      bool? isFromCartPage) async {
    _showLoading();

    List<Map<String, dynamic>> itemList =
        variantVOList.map((item) => item.toJson()).toList();
    String itemListJson = jsonEncode(itemList);

    try {
      if (selectedIndex == 0) {
        var checkWalletAmountRequest = CheckWalletAmountRequest(subTotal);
        var checkWalletPasswordRequest = CheckWalletPasswordRequest(
            GetStorage().read(kBoxKeyWalletPassword));

        await _smileShopModel.checkWalletAmount(
            authToken, kAcceptLanguageEn, checkWalletAmountRequest);

        await _smileShopModel.checkWalletPassword(
            authToken, kAcceptLanguageEn, checkWalletPasswordRequest);
      }

      await _smileShopModel
          .postOrder(
        authToken,
        kAcceptLanguageEn,
        subTotal,
        selectedPaymentType,
        itemListJson,
        'app',
        jsonEncode(paymentData),
        promotionPoint,
      )
          .then((response) {
        if (isFromCartPage == true) {
          clearAddToCartProductByProductIdFromDatabase();
        }
        if (response.data?.responseType == 'url') {
          launchUrl(Uri.parse(response.data?.response)).then((val){
            ///start polling order status
            startPollingOrderStatus(response.data?.orderNo, context);
          });
        } else if (response.data?.responseType == 'qr') {
          showCommonDialog(
              context: context,
              dialogWidget:
                  QrDialogView(qrCodeString: response.data?.response));
          ///start polling order status
          startPollingOrderStatus(response.data?.orderNo, context);
        } else if (response.data?.responseType == 'pin') {
          ///start polling order status
          startPollingOrderStatus(response.data?.orderNo, context);
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) => const OrderSuccessfulPage()));
        }
      });
    } catch (error) {
      if(error == 'The password field is required.'){
        showCommonDialog(
            context: context,
            dialogWidget:const SetWalletPasswordDialogView(message: 'Please set wallet password first.'));
      }
      else{
        showCommonDialog(
            context: context,
            dialogWidget: ErrorDialogView(errorMessage: error.toString()));
      }
    } finally {
     // _hideLoading();
    }
  }


  ///start polling order status
  Future<void> startPollingOrderStatus(String? orderId, BuildContext context) async {
    _showLoading();
    int retryCount = 0;
    int maxRetries = 30;

    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (retryCount >= maxRetries) {
        timer.cancel();
        _hideLoading();
        debugPrint("Polling stopped after $maxRetries retries.");
        return;
      }

      retryCount++;

      checkOrderStatus(orderId).then((status) {
        if (status == 'success') {
          timer.cancel();
          _hideLoading();
          showSuccessSnackBarAndNavigate(context);
        } else {
          debugPrint("Order status: $status. Continuing to poll...");
        }
      }).catchError((error) {
        // timer.cancel();
        // _hideLoading();
        debugPrint("Error checking order status: $error");
      });
    });
  }

  ///check order status
  Future<String> checkOrderStatus(String? orderId) async {
    var orderStatusRequest = OrderStatusRequest(orderId);
    var response = await _smileShopModel.checkOrderStatus(
        kAcceptLanguageEn, authToken, orderStatusRequest);
    return response.status == 200 ? 'success' : 'failed';
  }

  ///show snack bar and navigate to success page
  void showSuccessSnackBarAndNavigate(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Success!'),
        backgroundColor: Colors.green,
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const OrderSuccessfulPage()),
      );
    });
  }

  ///for order product
  void makePayment(
      String orderNumber, String subTotal, BuildContext context) async {
    _showLoading();

    try {
      if (selectedIndex == 0) {
        var checkWalletAmountRequest =
            CheckWalletAmountRequest(int.parse(subTotal));
        var checkWalletPasswordRequest = CheckWalletPasswordRequest(
            GetStorage().read(kBoxKeyWalletPassword));

        await _smileShopModel.checkWalletAmount(
            authToken, kAcceptLanguageEn, checkWalletAmountRequest);

        await _smileShopModel.checkWalletPassword(
            authToken, kAcceptLanguageEn, checkWalletPasswordRequest);
      }

      await _smileShopModel
          .makePayment(authToken, kAcceptLanguageEn, selectedPaymentType,
              jsonEncode(paymentData), orderNumber, 'app')
          .then((response) {
        if (response.data?.responseType == 'url') {
          launchUrl(Uri.parse(response.data?.response)).then((val) {
            ///start polling order status
            startPollingOrderStatus(response.data?.orderId, context);
          });
        } else if (response.data?.responseType == 'qr') {
          showCommonDialog(
                  context: context,
                  dialogWidget:
                      QrDialogView(qrCodeString: response.data?.response));
          ///start polling order status
          startPollingOrderStatus(response.data?.orderId, context);
        } else if (response.data?.responseType == 'pin') {
          ///start polling order status
          startPollingOrderStatus(response.data?.orderId, context);
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) => const OrderSuccessfulPage()));
        }

      });
    } catch (error) {
      showCommonDialog(
          context: context,
          dialogWidget: ErrorDialogView(errorMessage: error.toString()));
    } finally {
      _hideLoading();
    }
  }


  void onSelectPayment(int index, String paymentType) {
    if (selectedIndex != index) {
      if (selectedIndex != -1) {
        selectedSubPaymentIndices[selectedIndex ?? 0] = -1;
      }

      selectedIndex = isSelected(index) ? -1 : index;

      if (payments[index].name == 'Dinger') {
        onSelectSubPayment(index, 0);
      } else {
        selectedSubPaymentIndices[index] = -1;

        paymentData = {
          "code": payments[index].code ?? "",
          "method": payments[index].method ?? "",
        };
        _notifySafely();
      }
    } else {
      selectedIndex = -1;
      selectedSubPaymentIndices[index] = -1;
      paymentData = {};
      _notifySafely();
    }

    selectedPaymentType = paymentType;

    notifyListeners();
  }

  bool isSelected(int index) {
    return index == selectedIndex;
  }

  bool isSelectedSubPayment(int paymentIndex, int subPaymentIndex) {
    return selectedSubPaymentIndices[paymentIndex] == subPaymentIndex;
  }

  void onSelectSubPayment(int paymentIndex, int subPaymentIndex) {
    selectedPaymentType = payments[paymentIndex].code ?? "";
    paymentData = {
      "code": "${payments[paymentIndex].subPaymentVO?[subPaymentIndex].code}",
      "method":
          "${payments[paymentIndex].subPaymentVO?[subPaymentIndex].method}"
    };
    if (selectedSubPaymentIndices[paymentIndex] == subPaymentIndex) {
      selectedSubPaymentIndices[paymentIndex] = -1;
    } else {
      selectedSubPaymentIndices[paymentIndex] = subPaymentIndex;
    }

    if (selectedSubPaymentIndices[paymentIndex] != -1) {
      selectedIndex = paymentIndex;
    }

    notifyListeners();
  }

  void clearAddToCartProductByProductIdFromDatabase() {
    for (var product in products) {
      _smileShopModel.clearSaveAddToCartProductByProductId(product.id ?? 0);
    }
  }

  void launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
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
