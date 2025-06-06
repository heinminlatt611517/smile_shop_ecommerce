import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/payment_bloc.dart';
import 'package:smile_shop/data/vos/order_variant_vo.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/list_items/payment_method_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

import '../widgets/common_dialog.dart';
import '../widgets/error_dialog_view.dart';
import '../widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PaymentMethodPage extends StatelessWidget {
  final int? productSubTotalPrice;
  final bool? isFromCartPage;
  final List<ProductVO>? productList;
  final int? promotionPoint;
  final bool? isFromMyOrderPage;
  final String? orderNumber;
  final String? orderSubTotal;

  const PaymentMethodPage(
      {super.key,
      this.productSubTotalPrice,
      this.isFromCartPage,
      this.productList,
      this.promotionPoint,
      this.isFromMyOrderPage,
      this.orderNumber,
      this.orderSubTotal});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentBloc(productList ?? [], context),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar:  CustomAppBarView(title: AppLocalizations.of(context)?.paymentMethod ?? ''),
        body: Selector<PaymentBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (BuildContext context, isLoading, Widget? child) => Stack(
            children: [
              ///body view
              Consumer<PaymentBloc>(
                builder: (context, bloc, child) => Form(
                  key: bloc.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            AppLocalizations.of(context)?.chooseTypeOfPayment ?? '',
                            style: const TextStyle(fontSize: kTextRegular2x),
                          ),
                          const SizedBox(
                            height: kMargin30,
                          ),
                          Selector<PaymentBloc, List<PaymentVO>>(
                            selector: (context, bloc) => bloc.payments,
                            builder: (context, paymentMethods, child) =>
                                paymentMethods.isEmpty
                                    ?

                                    ///loading view
                                     Container(
                                      color: Colors.transparent,
                                      child: const Center(
                                        child: LoadingView(
                                          bgColor: Colors.transparent,
                                          indicatorColor: kPrimaryColor,
                                          indicator: Indicator.ballSpinFadeLoader,
                                        ),
                                      ),
                                    )
                                    : MediaQuery.removePadding(
                                        context: context,
                                        removeBottom: true,
                                        removeTop: true,
                                        child: Consumer<PaymentBloc>(
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
                                                    (subPaymentIndex) {
                                                  bloc.onSelectSubPayment(
                                                      index, subPaymentIndex);
                                                },
                                                isSelectedSubPayment:
                                                    (subPaymentIndex) {
                                                  return bloc
                                                      .isSelectedSubPayment(
                                                          index,
                                                          subPaymentIndex);
                                                },
                                              );
                                            },
                                          ),
                                        )),
                          ),
                          const SizedBox(
                            height: 100,
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
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
          height: 40,
          child: Consumer<PaymentBloc>(
            builder: (context, bloc, child) => CommonButtonView(
                label: AppLocalizations.of(context)?.checkOut ?? '',
                labelColor: Colors.white,
                bgColor: kPrimaryColor,
                onTapButton: () {
                  ///for make payment api
                  if (isFromMyOrderPage == true) {
                    if (bloc.formKey.currentState!.validate()) {
                      if (bloc.paymentData.isEmpty) {
                        showCommonDialog(
                            context: context,
                            dialogWidget: const ErrorDialogView(
                                errorMessage:
                                'Please select payment'));
                      } else {
                        bloc.makePayment(orderNumber ?? "",
                            orderSubTotal ?? "", context);
                      }
                    }
                  }

                  ///for post order api
                  else {
                    if (bloc.formKey.currentState!.validate()) {
                      List<OrderVariantVO> orderVariants = [];
                      for (ProductVO product in productList ?? []) {

                        var subOrderVariantVo = OrderVariantVO(
                            qty: product.qtyCount ?? product.variantVO?.first.qtyCount ?? 0,
                            colorName: product.variantVO?.first.colorVO?.value,
                            variantAttributeValueId: 1,
                            variantProductId:
                            product.variantVO?.first.id,
                            productId: product.id);
                        orderVariants.add(subOrderVariantVo);
                      }
                      if (bloc.paymentData.isEmpty) {
                        showCommonDialog(
                            context: context,
                            dialogWidget: const ErrorDialogView(
                                errorMessage:
                                'Please select payment'));
                      } else {
                        bloc.onTapCheckout(
                            promotionPoint ?? 0,
                            productSubTotalPrice ?? 0,
                            orderVariants,
                            context,
                            isFromCartPage);
                      }
                    }
                  }
                }),
          ),
        ),
      ),
    );
  }
}
