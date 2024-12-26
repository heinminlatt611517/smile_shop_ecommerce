import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/search_product_bloc.dart';
import 'package:smile_shop/data/dummy_data/price_dummy_data.dart';
import 'package:smile_shop/data/dummy_data/rating_dummy_data.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/search_product_vo.dart';
import 'package:smile_shop/list_items/search_product_history_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/svg_image_view.dart';
import '../list_items/trending_product_list_item_view.dart';
import '../utils/images.dart';
import '../utils/strings.dart';
import '../widgets/loading_view.dart';

class SearchProductPage extends StatelessWidget {
  const SearchProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProductBloc(),
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Selector<SearchProductBloc, bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, child) => Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    ///spacer
                    const SliverToBoxAdapter(
                        child: SizedBox(
                      height: kMarginXXLarge,
                    )),

                    SliverToBoxAdapter(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(kMarginMedium2),
                                bottomLeft: Radius.circular(kMarginMedium2))),
                        child: Column(
                          children: [
                            ///search bar with back arrow view
                            const SearchBarWithBackArrowView(),

                            ///spacer
                            const SizedBox(
                              height: kMarginMedium2,
                            ),

                            ///search history view
                            Selector<SearchProductBloc, List<ProductVO>>(
                              selector: (context, bloc) => bloc.products,
                              builder: (context, products, child) => Selector<
                                  SearchProductBloc, List<SearchProductVO>>(
                                selector: (context, bloc) =>
                                    bloc.searchProducts,
                                builder: (context, snapshot, child) {
                                  if (snapshot.isNotEmpty) {
                                    return products.isEmpty
                                        ? Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Search History',
                                                      style: TextStyle(
                                                          fontSize: kTextRegular),
                                                    ),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: () {
                                                        var bloc = context.read<
                                                            SearchProductBloc>();
                                                        bloc.onTapClearAll();
                                                      },
                                                      child: const Row(
                                                        children: [
                                                          Text(
                                                            'Clear All',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    kTextRegular,
                                                                color:
                                                                    Colors.grey),
                                                          ),
                                                          SizedBox(
                                                            width: kMarginSmall,
                                                          ),
                                                          Icon(
                                                            Icons.delete,
                                                            color: Colors.grey,
                                                            size: 18,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical:
                                                            kMarginMedium2,
                                                        horizontal:
                                                            kMarginLarge),
                                                itemCount: snapshot.length,
                                                itemBuilder: (context, index) {
                                                  var bloc = context.read<
                                                      SearchProductBloc>();
                                                  return SearchProductHistoryListItemView(
                                                      searchProductVO:
                                                          snapshot[index],
                                                      bloc: bloc);
                                                },
                                              ),

                                              ///spacer
                                              const SizedBox(
                                                height: kMarginLarge,
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink();
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// products list
                    SliverToBoxAdapter(
                      child: Selector<SearchProductBloc, List<ProductVO>>(
                        selector: (context, bloc) => bloc.products,
                        builder: (context, products, child) {
                          if (products.isNotEmpty) {
                            ///search result
                            return Column(
                              children: [
                                const RatingsView(),
                                const SizedBox(
                                  height: kMarginMedium,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(kMarginMedium2),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return TrendingProductListItemView(
                                        productVO: products[index],
                                      );
                                    },
                                    itemCount: products.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 14.0,
                                            crossAxisSpacing: 10.0,
                                            childAspectRatio: 2 / 2.7),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Selector<SearchProductBloc, bool>(
                                selector: (context, bloc) =>
                                    bloc.isScreenLaunch,
                                builder: (context, isFirstTimeScreenLaunch,
                                        child) =>
                                    isFirstTimeScreenLaunch == true
                                        ? const SizedBox.shrink()
                                        : Center(
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
                                                  'There were no result\nTry a new search.',
                                                  style: TextStyle(
                                                      fontSize: kTextSmall),
                                                ),
                                              ],
                                            ),
                                          ));
                          }
                        },
                      ),
                    )
                  ],
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

///search bar with back arrow view
class SearchBarWithBackArrowView extends StatelessWidget {
  const SearchBarWithBackArrowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kMarginMedium2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const SvgImageView(
              imageName: kBackSvgIcon,
              imageHeight: 20,
              imageWidth: 20,
            ),
          ),
          const SizedBox(
            height: kMarginMedium2,
          ),
          Container(
            width: double.infinity, // Adjust the width as needed
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: kSearchBackgroundColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search),
                const SizedBox(width: 8.0),
                // Space between the icon and text field
                Expanded(
                  child: TextField(
                    enabled: true,
                    onChanged: (value) {
                      var bloc = Provider.of<SearchProductBloc>(context,
                          listen: false);
                      bloc.queryStreamController.sink.add(value);
                    },
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: kSearchHereHintLabel,
                        hintStyle: TextStyle(
                            fontSize: kTextRegular,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///ratings view
class RatingsView extends StatelessWidget {
  const RatingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      child: Column(
        children: [
          ///rating and price view
          Row(
            children: [
              ///filter
              Visibility(
                visible: false,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: kMarginSmall),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMarginSmall),
                      color: Colors.grey.withOpacity(0.5)),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        size: 20,
                      ),
                      Text('Filter'),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
              //const SizedBox(width: kMarginMedium2,),
              ///rating
              Consumer<SearchProductBloc>(
                builder: (context, bloc, child) => InkWell(
                  onTap: () {
                    showRatingBottomSheet(context, onTapItem: (value) {
                      bloc.onTapRating(double.parse(value));
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kMarginSmall),
                        color: Colors.black.withOpacity(0.1)),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text('Rating'),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: kMarginMedium2,
              ),

              ///Price
              Consumer<SearchProductBloc>(
                builder: (context, bloc, child) => InkWell(
                  onTap: () {
                    showPriceBottomSheet(context, onTapItem: (value){
                      //bloc.onTapPrice();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kMarginSmall),
                        color: Colors.black.withOpacity(0.1)),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text('Price'),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: kMarginMedium2,
          ),
        ],
      ),
    );
  }
}

///rating bottom sheet
void showRatingBottomSheet(BuildContext context,
    {required Function(String value) onTapItem}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      ///rating grid
      return Container(
        height: 200,
        decoration: const BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kMarginMedium2),
                topRight: Radius.circular(kMarginMedium2))),
        padding: const EdgeInsets.all(kMarginMedium2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Rating',
            ),
            const SizedBox(
              height: kMarginMedium2,
            ),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onTapItem(ratingDummyData[index]);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kMarginMedium),
                        color: Colors.black.withOpacity(0.1)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 15,
                        ),
                        const SizedBox(
                          width: kMarginSmall,
                        ),
                        Text(ratingDummyData[index])
                      ],
                    ),
                  ),
                );
              },
              itemCount: ratingDummyData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 3 / 1.4),
            ),
          ],
        ),
      );
    },
  );
}

///price bottom sheet
void showPriceBottomSheet(BuildContext context,
    {required Function(String value) onTapItem}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      ///price grid
      return Container(
        height: 160,
        decoration: const BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kMarginMedium2),
                topRight: Radius.circular(kMarginMedium2))),
        padding: const EdgeInsets.all(kMarginMedium2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Price',
            ),
            const SizedBox(
              height: kMarginMedium2,
            ),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onTapItem(priceDummyData[index]);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kMarginMedium),
                        color: Colors.black.withOpacity(0.1)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Text(
                              priceDummyData[index],
                              style: const TextStyle(fontSize: kTextSmall),
                            ))
                      ],
                    ),
                  ),
                );
              },
              itemCount: priceDummyData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 3 / 0.8),
            ),
          ],
        ),
      );
    },
  );
}
