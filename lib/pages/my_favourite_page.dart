import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/my_favourite_bloc.dart';
import 'package:smile_shop/list_items/favourite_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';

import '../data/vos/product_vo.dart';
import '../list_items/trending_product_list_item_view.dart';
import '../utils/dimens.dart';
import '../utils/images.dart';
import '../widgets/loading_view.dart';
import '../widgets/svg_image_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
            automaticallyImplyLeading: false,
            title:  Row(children: [InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child:const SvgImageView(
                imageName: kBackSvgIcon,
                imageHeight: 26,
                imageWidth: 26,
              ),
            ),
              const Spacer(),
              Text(AppLocalizations.of(context)?.myFavourite ?? ''),
              const Spacer(),
              const Text(''),
            ],),),
          body: Selector<MyFavouriteBloc, bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, Widget? child) =>
             Stack(
               children: [
                 Selector<MyFavouriteBloc, List<ProductVO>>(
                  selector: (context, bloc) => bloc.favouriteProductList,
                  builder: (context, products, Widget? child) =>
                  products.isEmpty && isLoading == false
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
                      Expanded(
                        child: GridView.builder(
                          padding:const EdgeInsets.symmetric(horizontal: kMarginMedium2,vertical: kMarginMedium2),
                          itemBuilder: (context, index) {
                            return TrendingProductListItemView(
                              productVO: products[index],
                              onTapFavourite: (product) {
                                var bloc = Provider.of<MyFavouriteBloc>(context,
                                    listen: false);
                                bloc.onTapFavourite(product, context);
                              },
                            );
                          },
                          itemCount: products.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 2 / 2.7,
                          ),
                        ),
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
          )),
    );
  }
}
