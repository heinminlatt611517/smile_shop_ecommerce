import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/my_favourite_bloc.dart';
import 'package:smile_shop/list_items/favourite_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';

import '../data/vos/product_vo.dart';
import '../utils/dimens.dart';
import '../utils/images.dart';

class MyFavouritePage extends StatelessWidget {
  const MyFavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyFavouriteBloc(),
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              toolbarHeight: 60,
              title: const Text('My Favourite')),
          body: Selector<MyFavouriteBloc, List<ProductVO>>(
            selector: (context, bloc) => bloc.favouriteProductList,
            builder: (context, products, Widget? child) =>
            products.isEmpty
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
                  const Text(
                    textAlign: TextAlign.center,
                    'There were no result\nTry to add a new product.',
                    style: TextStyle(fontSize: kTextSmall),
                  ),
                ],
              ),
            )
                : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return FavouriteListItemView(
                          productVO: products[index],
                          onTapFavourite: (product){
                            var bloc = Provider.of<MyFavouriteBloc>(context,
                                listen: false);
                            bloc.onTapFavourite(product);
                          },
                        );
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
