import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/checkout_bloc.dart';
import 'package:smile_shop/data/vos/address_vo.dart';
import 'package:smile_shop/list_items/cart_list_item_view.dart';
import 'package:smile_shop/pages/my_address_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/strings.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

import '../data/vos/product_vo.dart';
import '../widgets/cached_network_image_view.dart';
import 'payment_method_page.dart';

class CheckoutPage extends StatelessWidget {
  final List<ProductVO>? productList;
  final bool? isFromCartPage;

  const CheckoutPage(
      {super.key, this.productList, required this.isFromCartPage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckOutBloc(productList ?? []),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar:const  CustomAppBarView(title: 'Check Out'),
        body: Selector<CheckOutBloc, List<AddressVO>>(
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
                const _BuildPromotionPointView(),
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

        ///pay now
        bottomNavigationBar: Consumer<CheckOutBloc>(
          builder: (context, bloc, child) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => PaymentMethodPage(
                        productSubTotalPrice: bloc.totalSummaryProductPrice,
                        isFromCartPage: isFromCartPage,
                        productList: productList,
                      )));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kPrimaryColor, borderRadius: BorderRadius.circular(4)),
              child: const Center(
                child: Text(
                  'Pay Now',
                  style: TextStyle(color: kBackgroundColor),
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
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (builder) => const MyAddressPage()));
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
            const Text('Address'),
            const SizedBox(
              width: 50,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: Text(
                    addressList?.isNotEmpty ?? true
                        ? '${addressList?.first.townshipVO?.name ?? ""},${addressList?.first.stateVO?.name ?? ""}'
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
              builder: (builder) => deliveryOptionModalSheet(context, bloc));
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
              const Text('Delivery Options'),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                        child: Text(
                      bloc.isSelectedStandardDelivery
                          ? kStandardDelivery
                          : kSpecialDelivery,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary'),
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
                const Text('Order'),
                Text('Ks ${bloc.totalProductPrice}')
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Delivery'), Text('Ks 3500')],
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
                const Text('Total'),
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
  const _BuildPromotionPointView();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) => promotionPointModalSheet(context));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: kFillingFastColor),
            borderRadius: BorderRadius.circular(10)),
        child: const Row(
          children: [
            Text('Promotion Points'),
            SizedBox(
              width: 50,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: Text(
                    '-700',
                    style: TextStyle(color: kFillingFastColor),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.chevron_right)
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
            const Text(
              'Delivery Options',
              style: TextStyle(fontSize: kTextRegular2x),
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
            decoration: BoxDecoration(
                border: Border.all(
                    color: bloc.isSelectedStandardDelivery
                        ? kPrimaryColor
                        : Colors.transparent,
                    width: 1),
                color: kFillingFastColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: kMarginMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(kStandardDelivery), Text('Free')],
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
            decoration: BoxDecoration(
                border: Border.all(
                    color: bloc.isSelectedSpecialDelivery
                        ? kPrimaryColor
                        : Colors.transparent,
                    width: 1),
                color: kFillingFastColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: kMarginMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(kSpecialDelivery), Text('Ks 3500')],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

///promotion point bottom sheet
Widget promotionPointModalSheet(BuildContext context) {
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
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Promotion Point',
          style: TextStyle(fontSize: kTextRegular2x),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ///user promotion view
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(kMarginMedium)),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Use Promotion'),
                        Row(
                          children: [
                            Text(
                              'use 7000 Points',
                              style: TextStyle(color: kSecondaryColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.circle_outlined,
                              color: kSecondaryColor,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const CachedNetworkImageView(
                              imageHeight: 80,
                              imageWidth: 80,
                              imageUrl:
                                  'https://media.istockphoto.com/id/1311107708/photo/focused-cute-stylish-african-american-female-student-with-afro-dreadlocks-studying-remotely.jpg?s=612x612&w=0&k=20&c=OwxBza5YzLWkE_2abTKqLLW4hwhmM2PW9BotzOMMS5w='),
                        ),
                        const SizedBox(
                          width: kMargin25,
                        ),
                        const Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Name',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: kTextRegular2x,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: kMargin12,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Ks 350000',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Ks 28000',
                                    style: TextStyle(
                                        color: kSecondaryColor,
                                        fontSize: kTextSmall))
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kMargin45,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('No Use'),
                  Icon(
                    Icons.circle_outlined,
                    color: kSecondaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(kMarginMedium2),
          child: CommonButtonView(
              label: 'Okay',
              labelColor: Colors.white,
              bgColor: kPrimaryColor,
              onTapButton: () {}),
        )
      ],
    ),
  );
}
