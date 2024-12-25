import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/payment_bloc.dart';
import 'package:smile_shop/data/vos/payment_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/list_items/payment_method_list_item_view.dart';
import 'package:smile_shop/pages/order_successful_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

import '../widgets/common_dialog.dart';
import '../widgets/error_dialog_view.dart';
import '../widgets/loading_view.dart';

class PaymentMethodPage extends StatelessWidget {
  final int? productSubTotalPrice;
  final bool? isFromCartPage;
  final List<ProductVO>? productList;

  const PaymentMethodPage(
      {super.key,
      required this.productSubTotalPrice,
      required this.isFromCartPage,
      required this.productList});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentBloc(productList ?? []),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar:const CustomAppBarView(title: 'Payment Method'),
        body: Selector<PaymentBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (BuildContext context, isLoading, Widget? child) => Stack(
            children: [
              ///body view
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose type of payment.',
                      style: TextStyle(fontSize: kTextRegular2x),
                    ),
                    const SizedBox(
                      height: kMargin30,
                    ),
                    Selector<PaymentBloc, List<PaymentVO>>(
                      selector: (context, bloc) => bloc.payments,
                      builder: (context, paymentMethods, child) =>
                          MediaQuery.removePadding(
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
                                            paymentVO: paymentMethods[index],
                                            isSelected: bloc.isSelected(index),
                                            onTapPayment: (currentIndex) {
                                              bloc.onSelectPayment(
                                                  currentIndex,
                                                  paymentMethods[index].code ??
                                                      "");
                                            },
                                          );
                                        }),
                              )),
                    ),
                    const SizedBox(
                      height: kMargin80,
                    ),
                    Consumer<PaymentBloc>(
                      builder: (context, bloc, child) => CommonButtonView(
                          label: 'Check Out',
                          labelColor: Colors.white,
                          bgColor: kPrimaryColor,
                          onTapButton: () {
                            var variantList = [
                              {
                                "variant_product_id": 1,
                                "product_id": 1,
                                "variant_attribute_value_id": 1,
                                "qty": 2
                              }
                            ];
                            bloc
                                .onTapCheckout(
                                    18, productSubTotalPrice ?? 0, variantList)
                                .then((value) {
                              if (isFromCartPage == true) {
                                bloc.clearAddToCartProductByProductIdFromDatabase();
                              }
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) =>
                                      const OrderSuccessfulPage()));
                            }).catchError((error) {
                              showCommonDialog(
                                  context: context,
                                  dialogWidget: ErrorDialogView(
                                      errorMessage: error.toString()));
                            });
                          }),
                    ),
                  ],
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
