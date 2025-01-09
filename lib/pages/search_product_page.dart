import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/search_product_bloc.dart';
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
      child: Consumer<SearchProductBloc>(
        builder: (context,bloc,child)=>
         Scaffold(
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
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal:
                                                              kMarginMedium2),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'Search History',
                                                        style: TextStyle(
                                                            fontSize:
                                                                kTextRegular),
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
                                                                  color: Colors
                                                                      .grey),
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
                                  ///rating and price view
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: kMarginMedium2),
                                    child: Row(
                                      children: [
                                        ///rating
                                        InkWell(
                                          onTap: () {
                                            showRatingAndPriceGeneralDialog(
                                                context,bloc);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kMarginSmall),
                                                color: Colors.black
                                                    .withOpacity(0.1)),
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
                                        const SizedBox(
                                          width: kMarginMedium2,
                                        ),

                                        ///Price
                                        InkWell(
                                          onTap: () {
                                            showRatingAndPriceGeneralDialog(
                                                context,bloc);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kMarginSmall),
                                                color: Colors.black
                                                    .withOpacity(0.1)),
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
                                      ],
                                    ),
                                  ),

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
                                          onTapFavourite: (product) {
                                            var bloc =
                                                Provider.of<SearchProductBloc>(
                                                    context,
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
      ),
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

///rating and price view
class RatingAndPriceView extends StatelessWidget {
  final SearchProductBloc bloc;
  const RatingAndPriceView({super.key,required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kBackgroundColor,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(kMarginMedium),
        bottomRight: Radius.circular(kMarginMedium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kMarginMedium2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 50,
            ),
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
                    bloc.onChangedRating(double.parse(ratingDummyData[index]));
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
            Container(
              margin: const EdgeInsets.symmetric(vertical: kMarginLarge),
              height: 1,
              color: Colors.black,
              width: double.infinity,
            ),
            const Text(
              'Price Range',
            ),
            _PriceRangeSlider(onPriceRangeChanged: (minRange, maxRange) {
              Navigator.pop(context);
             bloc.onChangedMinMaxRange(
                 minRange, maxRange);
                          })
          ],
        ),
      ),
    );
  }
}

void showRatingAndPriceGeneralDialog(BuildContext context,SearchProductBloc bloc) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 500),
    barrierLabel: MaterialLocalizations.of(context).dialogLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (context, _, __) {
      return Align(
        alignment: Alignment.topCenter, // Align at the top of the screen
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RatingAndPriceView(bloc: bloc,),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ).drive(Tween<Offset>(
          begin: const Offset(0, -1.0),
          end: Offset.zero,
        )),
        child: child,
      );
    },
  );
}

///price range slider view
class _PriceRangeSlider extends StatefulWidget {
  final Function(double minValue, double maxValue) onPriceRangeChanged;

  const _PriceRangeSlider({super.key, required this.onPriceRangeChanged});

  @override
  State<_PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<_PriceRangeSlider> {
  RangeValues _currentRangeValues = const RangeValues(5000.0, 10000.0);
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(kMarginMedium2),
              ),
              child: Text(
                '${_currentRangeValues.start.round()} Ks',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 100),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(kMarginMedium2),
              ),
              child: Text(
                '${_currentRangeValues.end.round()} Ks',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 2.0,
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 7),
          ),
          child: RangeSlider(
            values: _currentRangeValues,
            max: 20000,
            divisions: 100,
            activeColor: kPrimaryColor,
            inactiveColor: Colors.grey,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });

              if (_debounce?.isActive ?? false) {
                _debounce!.cancel();
              }

              /// Start a new debounce timer
              _debounce = Timer(const Duration(milliseconds: 500), () {
                widget.onPriceRangeChanged(
                  _currentRangeValues.start.roundToDouble(),
                  _currentRangeValues.end.roundToDouble(),
                );
              });
            },
          ),
        ),
      ],
    );
  }
}

