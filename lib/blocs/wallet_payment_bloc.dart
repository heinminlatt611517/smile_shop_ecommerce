import 'dart:convert';

import 'package:smile_shop/data/model/smile_shop_model.dart';
import 'package:smile_shop/data/model/smile_shop_model_impl.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:smile_shop/pages/recharge_successful_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/common_dialog.dart';
import '../widgets/error_dialog_view.dart';
import '../widgets/qr_dialog_view.dart';

class WalletPaymentBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  /// State
  bool isLoading = false;
  bool isDisposed = false;
  var authToken = "";
  List<PaymentVO> payments = [];
  int? selectedIndex;
  var selectedPaymentType = "";
  var amount = "";
  Map<int, int> selectedSubPaymentIndices = {};
  Map<String, String> paymentData = {};
  var amountTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  WalletPaymentBloc() {
    authToken =
        _smileShopModel.getLoginResponseFromDatabase()?.accessToken ?? "";

    debugPrint(authToken);

    ///get payment menthod list
    _smileShopModel
        .payments(authToken, kAcceptLanguageEn, kParamWalletRecharge)
        .then((paymentListResponse) {
      payments = paymentListResponse;
      _notifySafely();
    });
  }

  void onChangedAmount(String value) {
    amount = value;
    _notifySafely();
  }

  ///on Tap confirm
  Future<void> onTapConfirm(BuildContext context) async {
    try {
      _showLoading();

      await _smileShopModel
          .rechargeWallet(
        authToken,
        kAcceptLanguageEn,
        int.parse(amount),
        payments[selectedIndex ?? 0].code.toString(),
        'app',
        jsonEncode(paymentData),
      )
          .then((response) {
        if (response.data?.responseType == 'url') {
          launchUrl(Uri.parse(response.data?.response)).then((val) {
            showLoadingAndNavigate(context);
          });
        } else if (response.data?.responseType == 'qr') {
          showCommonDialog(
                  context: context,
                  dialogWidget:
                      QrDialogView(qrCodeString: response.data?.response))
              .then((val) {
            showLoadingAndNavigate(context);
          });
        } else if (response.data?.responseType == 'pin') {
          showLoadingAndNavigate(context);
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) => const RechargeSuccessfulPage()));
        }
      });
    } catch (error) {
      _hideLoading();
      showCommonDialog(
        context: context,
        dialogWidget: ErrorDialogView(
          errorMessage: error.toString(),
        ),
      );
    } finally {
      _hideLoading();
    }
  }

  void showLoadingAndNavigate(BuildContext context) async {
    _showLoading();
    await Future.delayed(const Duration(minutes: 1));
    _hideLoading();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RechargeSuccessfulPage(),
      ),
    );
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

  void onSelectPayment(int index, String paymentType) {
    if (selectedIndex != index) {
      if (selectedIndex != -1) {
        selectedSubPaymentIndices[selectedIndex ?? 0] = -1;
      }
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

    notifyListeners();
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
