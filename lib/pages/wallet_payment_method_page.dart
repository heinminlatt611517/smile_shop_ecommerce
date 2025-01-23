import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';
import 'package:smile_shop/list_items/payment_method_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

import '../blocs/wallet_payment_bloc.dart';
import '../widgets/common_dialog.dart';
import '../widgets/error_dialog_view.dart';
import '../widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WalletPaymentMethodPage extends StatelessWidget {
  const WalletPaymentMethodPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WalletPaymentBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar:  CustomAppBarView(title: AppLocalizations.of(context)?.paymentMethod ?? ''),
        body: Selector<WalletPaymentBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (BuildContext context, isLoading, Widget? child) => Stack(
            children: [
              ///body view
              Consumer<WalletPaymentBloc>(
                builder: (context, bloc, child) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SingleChildScrollView(
                    child: Form(
                      key: bloc.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            AppLocalizations.of(context)?.chooseTypeOfPayment ?? '',
                            style: const TextStyle(fontSize: kTextRegular2x),
                          ),
                          const SizedBox(
                            height: kMarginMedium2,
                          ),
                          TextFormField(
                            controller: bloc.amountTextController,
                            cursorColor: Colors.black,
                            decoration:  InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 21),
                                hintText: AppLocalizations.of(context)?.pleaseEnterAmount ?? '',
                                hintStyle: const TextStyle(color: Colors.grey)),
                            onChanged: (v) {
                              bloc.onChangedAmount(v);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)?.pleaseEnterAmount ?? '';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: kMargin30,
                          ),
                          Selector<WalletPaymentBloc, List<PaymentVO>>(
                            selector: (context, bloc) => bloc.payments,
                            builder: (context, paymentMethods, child) =>
                            paymentMethods.isEmpty ? ///loading view
                            Container(
                              color: Colors.transparent,
                              child: const Center(
                                child: LoadingView(
                                  bgColor: Colors.transparent,
                                  indicatorColor: kPrimaryColor,
                                  indicator: Indicator.ballSpinFadeLoader,
                                ),
                              ),
                            ) :
                                MediaQuery.removePadding(
                                    context: context,
                                    removeBottom: true,
                                    removeTop: true,
                                    child: Consumer<WalletPaymentBloc>(
                                      builder: (context, bloc, child) =>
                                          ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: paymentMethods.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                bool isLastIndex = index ==
                                                    paymentMethods.length - 1;
                                                return PaymentMethodListItemView(
                                                  currentIndex: index,
                                                  isLastIndex: isLastIndex,
                                                  paymentVO:
                                                      paymentMethods[index],
                                                  isSelected:
                                                      bloc.isSelected(index),
                                                  onTapPayment: (currentIndex) {
                                                    bloc.onSelectPayment(
                                                        currentIndex,
                                                        paymentMethods[index]
                                                                .code ??
                                                            "");
                                                  },
                                                  onTapSubPayment:
                                                      (currentIndex) {
                                                    bloc.onSelectSubPayment(
                                                        index, currentIndex);
                                                  },
                                                  isSelectedSubPayment:
                                                      (subPaymentIndex) {
                                                    return bloc
                                                        .isSelectedSubPayment(
                                                            index,
                                                            subPaymentIndex);
                                                  },
                                                );
                                              }),
                                    )),
                          ),
                          const SizedBox(
                            height: kMargin80,
                          ),
                          Consumer<WalletPaymentBloc>(
                            builder: (context, bloc, child) => CommonButtonView(
                                label: AppLocalizations.of(context)?.confirm ?? '',
                                labelColor: Colors.white,
                                bgColor: kPrimaryColor,
                                onTapButton: () {
                                  if (bloc.formKey.currentState!.validate()) {
                                    if (bloc.paymentData.isEmpty) {
                                      showCommonDialog(
                                          context: context,
                                          dialogWidget: const ErrorDialogView(
                                              errorMessage:
                                                  'Please select payment'));
                                    } else {
                                      bloc.onTapConfirm(context);
                                    }
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              ///loading view
              if (isLoading)
                Container(
                  color: Colors.black12,
                  child: const Center(
                    child: LoadingView(
                      indicatorColor: kPrimaryColor,
                      indicator: Indicator.ballSpinFadeLoader,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
