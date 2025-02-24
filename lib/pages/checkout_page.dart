import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/checkout_bloc.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/list_items/cart_list_item_view.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/my_address_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/strings.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../data/vos/product_vo.dart';
import '../widgets/cached_network_image_view.dart';
import '../widgets/loading_view.dart';
import 'payment_method_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutPage extends StatelessWidget {
  final List<ProductVO>? productList;
  final bool? isFromCartPage;

  const CheckoutPage({super.key, this.productList, required this.isFromCartPage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckOutBloc(productList ?? [], context),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: CustomAppBarView(title: AppLocalizations.of(context)?.checkOut ?? ''),
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
                      ListView.builder(
                          itemCount: productList?.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CartListItemView(
                              isCheckout: true,
                              productVO: productList?[index],
                            );
                          }),

                      ///address view
                      _BuildAddressView(
                        addressList: addressList,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///delivery option view
                      const _BuildDeliveryOptionView(),
                      const SizedBox(
                        height: 20,
                      ),

                      ///promotion point view
                      Consumer<CheckOutBloc>(
                        builder: (context, bloc, child) => _BuildPromotionPointView(
                          productVO: productList?.first,
                          bloc: bloc,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///order summary view
                      const _BuildOrderSummaryView(),
                      const SizedBox(
                        height: 20,
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
          builder: (context, bloc, child) => GestureDetector(
            onTap: () {
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
                          promotionPoint: bloc.isSelectedUsePromotion == true ? GetStorage().read(kBoxKeyPromotionPoint) : 0,
                          isFromMyOrderPage: false,
                        )));
              }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(4)),
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

          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyAddressPage(needReturnValue: true))).then(
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
          decoration: BoxDecoration(color: kFillingFastColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
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
                      bloc.defaultAddressVO != null ? '${bloc.defaultAddressVO?.townshipVO?.name},${bloc.defaultAddressVO?.stateVO?.name}' : '',
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
          showModalBottomSheet(context: context, builder: (builder) => deliveryOptionModalSheet(context, bloc));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(color: kFillingFastColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
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
                      bloc.isSelectedStandardDelivery ? AppLocalizations.of(context)?.standardDelivery ?? '' : AppLocalizations.of(context)?.specialDelivery ?? '',
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
      decoration: BoxDecoration(color: kFillingFastColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Column(
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
          Consumer<CheckOutBloc>(
            builder: (context, bloc, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)?.order ?? ''),
                Text('Ks ${bloc.totalProductPrice}')
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)?.delivery ?? ''),
              const Text('Ks 0')
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const DottedLine(),
          const SizedBox(
            height: 20,
          ),
          Consumer<CheckOutBloc>(
            builder: (context, bloc, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)?.total ?? ''),
                Text('Ks ${bloc.totalSummaryProductPrice}')
              ],
            ),
          ),
        ],
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
        showModalBottomSheet(
            context: context,
            builder: (builder) => promotionPointModalSheet(
                  context,
                  productVO,
                  bloc,
                ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: kFillingFastColor), borderRadius: BorderRadius.circular(10)),
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
                    GetStorage().read(kBoxKeyPromotionPoint).toString(),
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
    );
  }
}

///delivery option bottom sheet
Widget deliveryOptionModalSheet(BuildContext context, CheckOutBloc bloc) {
  return Container(
    height: 200,
    decoration: const BoxDecoration(
      color: kBackgroundColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    width: double.infinity,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            const SizedBox(),
            Text(
              AppLocalizations.of(context)?.deliveryOptions ?? '',
              style: const TextStyle(fontSize: kTextRegular2x),
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
            bloc.onTapAddStandardDelivery();
            Navigator.pop(context);
          },
          child: Container(
            height: 40,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(border: Border.all(color: bloc.isSelectedStandardDelivery ? kPrimaryColor : Colors.transparent, width: 1), color: kFillingFastColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMarginMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)?.standardDelivery ?? ''),
                  Text('Free')
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
            bloc.onTapAddStandardDelivery();
            Navigator.pop(context);
          },
          child: Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: bloc.isSelectedSpecialDelivery ? kPrimaryColor : Colors.transparent, width: 1), color: kFillingFastColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMarginMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)?.specialDelivery ?? ''),
                  Text('Ks 3500')
                ],
              ),
            ),
          ),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)?.promotionPoint ?? '',
          style: const TextStyle(fontSize: kTextRegular2x),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              /// User Promotion View
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(kMarginMedium),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)?.usePromotion ?? ''),
                        Row(
                          children: [
                            Text(
                              'Use ${GetStorage().read(kBoxKeyPromotionPoint) ?? "0"} Points',
                              style: const TextStyle(color: kSecondaryColor),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                bloc.onTapUsePromotion();
                                Navigator.pop(context);
                              },
                              child: bloc.isSelectedUsePromotion
                                  ? const Icon(
                                      Icons.circle,
                                      color: kSecondaryColor,
                                    )
                                  : const Icon(
                                      Icons.circle_outlined,
                                      color: kSecondaryColor,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImageView(
                            imageHeight: 80,
                            imageWidth: 80,
                            imageUrl: productVO?.images?.first ?? errorImageUrl,
                          ),
                        ),
                        const SizedBox(width: kMargin25),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productVO?.name ?? "",
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: kTextRegular2x,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: kMargin12),
                              Row(
                                children: [
                                  Text(
                                    'Ks ${productVO?.price}',
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'Ks ${productVO?.price}',
                                    style: const TextStyle(
                                      color: kSecondaryColor,
                                      fontSize: kTextSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kMargin45),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)?.noUse ?? ''),
                  InkWell(
                    onTap: () {
                      bloc.onTapUsePromotion();
                      Navigator.pop(context);
                    },
                    child: bloc.isSelectedNoPromotion
                        ? const Icon(
                            Icons.circle,
                            color: kSecondaryColor,
                          )
                        : const Icon(
                            Icons.circle_outlined,
                            color: kSecondaryColor,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        // Padding(
        //   padding: const EdgeInsets.all(kMarginMedium2),
        //   child: CommonButtonView(
        //     label: 'Okay',
        //     labelColor: Colors.white,
        //     bgColor: kPrimaryColor,
        //     onTapButton: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
      ],
    ),
  );
}
