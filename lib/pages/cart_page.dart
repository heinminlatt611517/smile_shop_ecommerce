import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/cart_bloc.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/list_items/cart_list_item_view.dart';
import 'package:smile_shop/pages/checkout_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';

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
          title: const Text('Cart',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          bottom:  PreferredSize(
              preferredSize:const Size(double.infinity, 40),
              child: Selector<CartBloc,List<ProductVO>>(
                selector: (context , bloc )=> bloc.productList,
                builder: (context,products, Widget? child) =>
                 Visibility(
                   visible: products.isNotEmpty,
                   child: Container(
                    color: kBackgroundColor,
                    child:const Padding(
                      padding: EdgeInsets.only(left: kMarginMedium,right: kMarginMedium,top: kMarginMedium),
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
              )),
        ),
        body: Selector<CartBloc,List<ProductVO>>(
          selector: (context , bloc )=> bloc.productList,
          builder: (context,products, Widget? child) =>
          products.isEmpty ? Center(
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
                const Text(
                  textAlign: TextAlign.center,
                  'There were no result\nTry to add a new product.',
                  style: TextStyle(
                      fontSize: kTextSmall),
                ),
              ],
            ),
          ) : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return CartListItemView(
                  productVO: products[index],
                  isCheckout: false,
                );
              }),
        ),
        bottomNavigationBar: Selector<CartBloc,List<ProductVO>>(
          selector: (context , bloc )=> bloc.productList,
          builder: (context,products, Widget? child) =>
           Visibility(
             visible: products.isNotEmpty,
             child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: kCartColor)),
                        child: const Icon(
                          Icons.check,
                          color: kPrimaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Select All'),
                    ],
                  ),
                  const Row(
                    children: [
                      Text('Total: '),
                      Text(
                        'Ks 30000',
                        style: TextStyle(color: kFillingFastColor),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => const CheckoutPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: kFillingFastColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text(
                        'Check Out (1)',
                        style: TextStyle(color: kBackgroundColor),
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
