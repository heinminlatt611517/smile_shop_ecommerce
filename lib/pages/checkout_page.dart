import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/checkout_bloc.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/data/vos/coupon_vo.dart';
import 'package:smile_shop/list_items/checkout_item.dart';
import 'package:smile_shop/pages/my_address_page.dart';
import 'package:smile_shop/pages/pick_up_location_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../data/vos/product_vo.dart';
import '../widgets/loading_view.dart';
import 'payment_method_page.dart';
import 'package:smile_shop/localization/app_localizations.dart';

class CheckoutPage extends StatelessWidget {
  final List<ProductVO>? productList;
  final bool? isFromCartPage;

  const CheckoutPage(
      {super.key, this.productList, required this.isFromCartPage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckOutBloc(productList ?? [], context),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: CustomAppBarView(
            title: AppLocalizations.of(context)?.checkOut ?? ''),
        body: Selector<CheckOutBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              ///content view
              Selector<CheckOutBloc, List<AddressVO>>(
                selector: (context, bloc) => bloc.addressList,
                builder: (context, addressList, child) => SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 13,
                      ),

                      ///product
                      ListView.separated(
                          padding: const EdgeInsets.only(
                              left: kMarginMedium2,
                              right: kMarginMedium2,
                              bottom: kMarginMedium2),
                          itemCount: productList?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: kMarginMedium,
                              ),
                          itemBuilder: (context, index) {
                            return CheckOutItem(
                                productVO: productList?[index] ?? ProductVO());
                          }),

                      ///address view
                      _BuildAddressView(
                        addressList: addressList,
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      ///delivery option view
                      const _BuildDeliveryOptionView(),
                      const SizedBox(
                        height: 12,
                      ),

                      _BuildFindMyPickUpView(),

                      ///promotion point view
                      Consumer<CheckOutBloc>(
                        builder: (context, bloc, child) =>
                            _BuildPromotionPointView(
                          productVO: productList?.first,
                          bloc: bloc,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const CouponSection(),
                      const SizedBox(
                        height: 12,
                      ),

                      ///order summary view
                      const _BuildOrderSummaryView(),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
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

        ///pay now
        bottomNavigationBar: Consumer<CheckOutBloc>(
          builder: (context, bloc, child) => Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: GestureDetector(
              onTap: () {
                if (bloc.selectedDeliveryOption == null) {
                  showTopSnackBar(
                    displayDuration: const Duration(milliseconds: 300),
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Please select delivery option",
                    ),
                  );
                  return;
                }

                if (bloc.defaultAddressVO == null) {
                  showTopSnackBar(
                    displayDuration: const Duration(milliseconds: 300),
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: "Please select address",
                    ),
                  );
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => PaymentMethodPage(
                            productSubTotalPrice: bloc.totalSummaryProductPrice,
                            isFromCartPage: isFromCartPage,
                            productList: productList,
                            promotionPoint: bloc.usedPromotionPoints,
                            isFromMyOrderPage: false,
                            deliveryType: bloc.selectedDeliveryOption ==
                                    DeliveryOptions.pickup
                                ? "pickup"
                                : "delivery",
                            couponId: bloc.selectedCoupon?.id,
                            addressId: bloc.defaultAddressVO?.id ?? 0,
                          )));
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)?.payNow ?? '',
                    style: const TextStyle(color: kBackgroundColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CouponSection extends StatelessWidget {
  const CouponSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckOutBloc>(
        builder: (context, bloc, child) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kFillingFastColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<CouponVO?>(
                  hint: (bloc.couponList.isNotEmpty)
                      ? const Text('Select a coupon')
                      : const Text('No coupons available'),
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                  ),
                  value: bloc.selectedCoupon,
                  isExpanded: true,
                  onChanged: (CouponVO? newValue) {
                    bloc.selectCoupon(newValue);
                  },
                  items: (bloc.couponList.isNotEmpty)
                      ? [
                          const DropdownMenuItem<CouponVO?>(
                            value: null,
                            child: Text(
                              'No Coupon Selected',
                              style: TextStyle(fontSize: kTextRegular),
                            ),
                          ),
                          ...bloc.couponList
                              .map((coupon) => DropdownMenuItem<CouponVO?>(
                                    value: coupon,
                                    child: Text(
                                      "${coupon.name ?? ""} : ${coupon.discountValue ?? ""} ${coupon.discountType == 'percentage' ? '%' : 'Ks'}",
                                      style: const TextStyle(
                                          fontSize: kTextRegular),
                                    ),
                                  )),
                        ]
                      : [],
                ),
              ),
            ));
  }
}

class _BuildFindMyPickUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckOutBloc>(
      builder: (context, bloc, child) => bloc.selectedDeliveryOption ==
              DeliveryOptions.pickup
          ? InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PickUpLocationPage()));
              },
              child: Container(
                margin: const EdgeInsets.only(
                    bottom: 20, left: kMarginMedium2, right: kMarginMedium2),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: kFillingFastColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    const SizedBox(
                      width: kMarginMedium2,
                    ),
                    Expanded(
                        child: Text(
                            AppLocalizations.of(context)?.findMyPickUp ?? '')),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(Icons.chevron_right)
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}

///address view
class _BuildAddressView extends StatelessWidget {
  final List<AddressVO>? addressList;

  const _BuildAddressView({required this.addressList});

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckOutBloc>(
      builder: (context, bloc, child) => InkWell(
        onTap: () async {
          // final String? addressName = await Navigator.of(context).push(
          //     MaterialPageRoute(builder: (builder) => const MyAddressPage()));
          // if (addressName != null) {
          //   bloc.onChangedAddressForShow(addressName);
          // }
          // final bool? isUpdated = await Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (builder) => const MyAddressPage(
          //       needReturnValue: false,
          //     ),
          //   ),
          // );
          // if (isUpdated == true) {
          //   context.read<CheckOutBloc>().refreshAddress();
          // }

          await Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) =>
                      const MyAddressPage(needReturnValue: true)))
              .then(
            (value) {
              if (value is AddressVO) {
                context.read<CheckOutBloc>().changeAddress(value);
              }
            },
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: kFillingFastColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Text(AppLocalizations.of(context)?.address ?? ''),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                        child: Text(
                      bloc.defaultAddressVO != null
                          ? '${bloc.defaultAddressVO?.townshipVO?.name},${bloc.defaultAddressVO?.stateVO?.name}'
                          : '',
                      overflow: TextOverflow.ellipsis,
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(Icons.chevron_right)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

///delivery option view
class _BuildDeliveryOptionView extends StatelessWidget {
  const _BuildDeliveryOptionView();

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckOutBloc>(
      builder: (context, bloc, child) => GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (builder) => deliveryOptionModalSheet(
                    context,
                    bloc: bloc,
                  ));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: kFillingFastColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Text(AppLocalizations.of(context)?.deliveryOptions ?? ''),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                        child: Text(
                      bloc.getTextAccordingToDeliveryOption(context),
                      overflow: TextOverflow.ellipsis,
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(Icons.chevron_right)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

///order summary view
class _BuildOrderSummaryView extends StatelessWidget {
  const _BuildOrderSummaryView();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kFillingFastColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: Consumer<CheckOutBloc>(
        builder: (context, bloc, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)?.orderSummary ?? ''),
            const SizedBox(
              height: 20,
            ),
            const DottedLine(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)?.order ?? ''),
                Text('Ks ${bloc.totalProductPrice}')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)?.delivery ?? ''),
                Text('Ks ${bloc.deliveryFeePrice ?? 0}')
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)?.coupon ?? ''),
                  Text('-Ks ${bloc.selectedCoupon?.getDiscountValue() ?? '0'}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)?.promotionPoint ?? ''),
                  Text('-Ks ${bloc.usedPromotionPoints}'),
                ],
              ),
            ),
            const DottedLine(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)?.total ?? ''),
                Text('Ks ${bloc.totalSummaryProductPrice}')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///promotion point view
class _BuildPromotionPointView extends StatelessWidget {
  final ProductVO? productVO;
  final CheckOutBloc bloc;

  const _BuildPromotionPointView({required this.productVO, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (bloc.availalePromotionPoints <= 0) {
          showTopSnackBar(
            displayDuration: const Duration(milliseconds: 300),
            Overlay.of(context),
            const CustomSnackBar.info(
              message: "There is no promotion point available for this product",
            ),
          );
          return;
        }

        // if (bloc.userCurrentPromotionPoints <= 0) {
        //   showTopSnackBar(
        //     displayDuration: const Duration(milliseconds: 300),
        //     Overlay.of(context),
        //     const CustomSnackBar.info(
        //       message: "You have no promotion points available to use",
        //     ),
        //   );
        //   return;
        // }
        showModalBottomSheet(
            context: context,
            builder: (builder) => promotionPointModalSheet(
                  context,
                  productVO,
                  bloc,
                ));
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                  color: kPrimaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)?.promotionPoint ?? ''),
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                          child: Text(
                        bloc.usedPromotionPoints > 0
                            ? bloc.usedPromotionPoints.toString()
                            : "",
                        style: const TextStyle(color: kFillingFastColor),
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text("User Promotion Points:"),
          //       Text(" ${bloc.userCurrentPromotionPoints} points")
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

///delivery option bottom sheet
Widget deliveryOptionModalSheet(BuildContext context,
    {required CheckOutBloc bloc}) {
  return Container(
    height: 300,
    decoration: const BoxDecoration(
      color: kBackgroundColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Text(
                AppLocalizations.of(context)?.deliveryOptions ?? '',
                style: const TextStyle(fontSize: kTextRegular2x),
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 18,
                ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            bloc.changeSelectedDeliveryOption(DeliveryOptions.standard);
            Navigator.pop(context);
          },
          child: Container(
            height: 40,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                // border: Border.all(
                //     color: bloc.isSelectedStandardDelivery
                //         ? kPrimaryColor
                //         : Colors.transparent,
                //     width: 1),
                color: kFillingFastColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMarginMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)?.standardDelivery ?? ''),
                  Text("Ks ${bloc.deliveryFeePrice.toString()}")
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            if (((bloc.totalProductPrice ?? 0) >= 20000)) {
              bloc.changeSelectedDeliveryOption(DeliveryOptions.special);
              Navigator.pop(context);
            } else {
              return;
            }
          },
          child: Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                // border: Border.all(
                //     color: bloc.isSelectedSpecialDelivery
                //         ? kPrimaryColor
                //         : Colors.transparent,
                //     width: 1),
                color: ((bloc.totalProductPrice ?? 0) >= 20000)
                    ? kFillingFastColor.withOpacity(0.1)
                    : Colors.grey,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMarginMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)?.specialDelivery ?? ''),
                  const Text('Free')
                ],
              ),
            ),
          ),
        ),
        Visibility(
            visible: ((bloc.totalProductPrice ?? 0) < 20000),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: kMarginMedium2),
              child: Text(
                "Enjoy free delivery on all orders above 20000 Ks",
                style: TextStyle(color: Colors.red, fontSize: kTextSmall),
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            bloc.changeSelectedDeliveryOption(DeliveryOptions.pickup);
            Navigator.pop(context);
          },
          child: Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                // border: Border.all(
                //     color: bloc.isSelectedSpecialDelivery
                //         ? kPrimaryColor
                //         : Colors.transparent,
                //     width: 1),
                color: kFillingFastColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMarginMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)?.pickUp ?? ''),
                  const Text('Free')
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    ),
  );
}

///promotion point bottom sheet
Widget promotionPointModalSheet(
  BuildContext context,
  ProductVO? productVO,
  CheckOutBloc bloc,
) {
  return Container(
    decoration: const BoxDecoration(
      color: kBackgroundColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Center(
          child: Text(
            AppLocalizations.of(context)?.promotionPoint ?? '',
            style: const TextStyle(fontSize: kTextRegular2x),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
            child: RichText(
                text: TextSpan(children: [
              const TextSpan(
                text: "You have ",
                style: TextStyle(fontSize: kTextRegular2x, color: Colors.black),
              ),
              TextSpan(
                text: "${bloc.userCurrentPromotionPoints}  points",
                style: const TextStyle(
                    fontSize: kTextRegular2x, color: kPrimaryColor),
              ),
              const TextSpan(
                text: " available",
                style: TextStyle(fontSize: kTextRegular2x, color: Colors.black),
              ),
            ]))),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            bloc.changePromotionPointStatus(true);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: kMarginMedium2, vertical: kMarginMedium2),
            margin: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.usePromotion),
                Expanded(
                    child: Text(
                  "${bloc.availalePromotionPoints.toString()} Points",
                  textAlign: TextAlign.end,
                ))
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            bloc.changePromotionPointStatus(false);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: kMarginMedium2, vertical: kMarginMedium2),
            margin: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.noUse),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}
