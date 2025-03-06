import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/cart_bloc.dart';
import 'package:smile_shop/data/vos/login_data_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/list_items/cart_list_item_view.dart';
import 'package:smile_shop/pages/checkout_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smile_shop/widgets/require_log_in_view.dart';


import '../utils/images.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)?.cart ?? '',
            style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Selector<CartBloc, LoginDataVO?>(
          selector: (context, bloc) => bloc.loginDataVO,
          builder: (context, logInData, child) => logInData == null ? const Center(
            child: RequireLogInView(),
          )  :  Selector<CartBloc, List<ProductVO>>(
            selector: (context, bloc) => bloc.productList,
            builder: (context, products, Widget? child) => products.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Image.asset(
                          kNoResultImage,
                          fit: BoxFit.contain,
                          height: kSplashAppLogoHeight,
                          width: kSplashAppLogoWidth,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          AppLocalizations.of(context)?.thereWereNoResultTryToAddNewProduct ?? '',
                          style: const TextStyle(fontSize: kTextSmall),
                        ),
                      ],
                    ),
                  )
                : Column(
                  children: [
                    Visibility(
                      visible: false,
                      child: Container(
                        color: kBackgroundColor,
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: kMarginMedium,
                              right: kMarginMedium,
                              top: kMarginMedium),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('My Cart'),
                              Text(
                                'Manage',
                                style: TextStyle(color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          itemCount: products.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CartListItemView(
                              productVO: products[index],
                              isCheckout: false,
                            );
                          }),
                    ),
                  ],
                ),
          ),
        ),
        bottomNavigationBar: Selector<CartBloc, List<ProductVO>>(
          selector: (context, bloc) => bloc.productList,
          builder: (context, products, Widget? child) => Visibility(
            visible: products.isNotEmpty,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16,left: 16,right: 16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Consumer<CartBloc>(
                        builder: (context, bloc, child) => Container(
                          height: 24.0,
                          width: 24.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Checkbox(
                              checkColor: kPrimaryColor,
                              value: bloc.isAllSelectedProduct,
                              onChanged: (value) {
                                bloc.onTapSelectAll();
                              }),
                        ),
                      ),
                      // const SizedBox(
                      //   width: 4,
                      // ),
                      // Text(AppLocalizations.of(context)?.selectAll ?? ''),
                    ],
                  ),
                  const SizedBox(width: 20,),
                  Row(
                    children: [
                      Text("${AppLocalizations.of(context)?.total ?? ''}: "),
                      Selector<CartBloc, int?>(
                        selector: (context, bloc) => bloc.totalProductPrice,
                        builder: (context, totalPrice, child) => Text(
                          'Ks $totalPrice',
                          style: const TextStyle(color: kFillingFastColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 20,),
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        if (products
                            .where((product) => product.isChecked == true)
                            .isNotEmpty) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => CheckoutPage(
                                    isFromCartPage: true,
                                    productList: products
                                        .where((product) =>
                                            product.isChecked == true)
                                        .toList(),
                                  )));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: kFillingFastColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          '${AppLocalizations.of(context)?.checkOut ?? ''} (${products.where((product) => product.isChecked == true).toList().length})',
                          style: const TextStyle(color: kBackgroundColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
