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
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/widgets/svg_image_view.dart';
import '../list_items/trending_product_list_item_view.dart';
import '../utils/images.dart';
import '../utils/strings.dart';
import '../widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchProductPage extends StatelessWidget {
  const SearchProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProductBloc(),
      child: Consumer<SearchProductBloc>(
        builder: (context, bloc, child) => Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(55 + MediaQuery.of(context).padding.top),
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: const SearchBarWithBackArrowView(),
              ),
            ),
            body: Selector<SearchProductBloc, bool>(
              selector: (context, bloc) => bloc.isLoading,
              builder: (context, isLoading, child) => Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(kMarginMedium2), bottomLeft: Radius.circular(kMarginMedium2))),
                          child: Column(
                            children: [
                              ///spacer
                              const SizedBox(
                                height: kMarginMedium2,
                              ),

                              ///search history view
                              Selector<SearchProductBloc, List<ProductVO>>(
                                selector: (context, bloc) => bloc.products,
                                builder: (context, products, child) => Selector<SearchProductBloc, List<SearchProductVO>>(
                                  selector: (context, bloc) => bloc.searchProducts,
                                  builder: (context, snapshot, child) {
                                    if (snapshot.isNotEmpty) {
                                      return products.isEmpty
                                          ? Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.searchHistory,
                                                        style: const TextStyle(fontSize: kTextRegular),
                                                      ),
                                                      const Spacer(),
                                                      InkWell(
                                                        onTap: () {
                                                          var bloc = context.read<SearchProductBloc>();
                                                          bloc.onTapClearAll();
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(context)!.clearAll,
                                                              style: const TextStyle(fontSize: kTextRegular, color: Colors.grey),
                                                            ),
                                                            const SizedBox(
                                                              width: kMarginSmall,
                                                            ),
                                                            const Icon(
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
                                                  padding: const EdgeInsets.symmetric(vertical: kMarginMedium2, horizontal: kMarginLarge),
                                                  itemCount: snapshot.length,
                                                  itemBuilder: (context, index) {
                                                    var bloc = context.read<SearchProductBloc>();
                                                    return SearchProductHistoryListItemView(searchProductVO: snapshot[index], bloc: bloc);
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
                                  const SizedBox(
                                    height: kMarginMedium,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(kMarginMedium2),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return TrendingProductListItemView(
                                          productVO: products[index],
                                          onTapFavourite: (product) {
                                            var bloc = Provider.of<SearchProductBloc>(context, listen: false);
                                            bloc.onTapFavourite(product, context);
                                          },
                                        );
                                      },
                                      itemCount: products.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 14.0, crossAxisSpacing: 10.0, childAspectRatio: 2 / 2.7),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Selector<SearchProductBloc, bool>(
                                  selector: (context, bloc) => bloc.isScreenLaunch,
                                  builder: (context, isFirstTimeScreenLaunch, child) => isFirstTimeScreenLaunch == true
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
                                                style: TextStyle(fontSize: kTextSmall),
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

                  Selector<SearchProductBloc, List<ProductVO>>(
                    selector: (context, bloc) => bloc.products,
                    builder: (context, products, child) => Visibility(
                      visible: products.isNotEmpty,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: kMargin10),
                        child: RatingAndPriceSectionView(),
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
            )),
      ),
    );
  }
}

class RatingAndPriceSectionView extends StatelessWidget {
  const RatingAndPriceSectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<SearchProductBloc>();
    return Container(
      color: kBackgroundColor,
      padding: const EdgeInsets.only(top: kMargin12),
      child: Row(
        children: [
          ///rating
          InkWell(
            onTap: () {
              bloc.onChangedRating(null);
              showRatingAndPriceGeneralDialog(context, bloc);
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(kMarginSmall), color: Colors.black.withOpacity(0.1)),
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
              bloc.onChangedRating(null);
              showRatingAndPriceGeneralDialog(context, bloc);
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(kMarginSmall), color: Colors.black.withOpacity(0.1)),
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
    );
  }
}

///search bar with back arrow view
class SearchBarWithBackArrowView extends StatelessWidget {
  const SearchBarWithBackArrowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const SvgImageView(
              imageName: kBackSvgIcon,
              imageHeight: 26,
              imageWidth: 26,
            ),
          ),
          const SizedBox(
            width: kMarginMedium2,
          ),
          Expanded(
            child: Container(
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
                        var bloc = Provider.of<SearchProductBloc>(context, listen: false);
                        bloc.queryStreamController.sink.add(value);
                      },
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(border: InputBorder.none, hintText: AppLocalizations.of(context)!.searchHere, hintStyle: const TextStyle(fontSize: kTextRegular)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///rating and price view
class RatingAndPriceDialogView extends StatefulWidget {
  final SearchProductBloc bloc;
  const RatingAndPriceDialogView({super.key, required this.bloc});

  @override
  State<RatingAndPriceDialogView> createState() => _RatingAndPriceDialogViewState();
}

class _RatingAndPriceDialogViewState extends State<RatingAndPriceDialogView> {
  double? selectedRating;
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
                bool isSelected = selectedRating == double.parse(ratingDummyData[index]);
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedRating = double.parse(ratingDummyData[index]);
                    });
                    widget.bloc.onChangedRating(double.parse(ratingDummyData[index]));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMarginMedium),
                      color: isSelected ? kPrimaryColor : Colors.black.withOpacity(0.1),
                    ),
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0, childAspectRatio: 3 / 1.4),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: kMarginLarge),
              height: 1,
              color: Colors.grey,
              width: double.infinity,
            ),
            const Text(
              'Price Range',
            ),
            _PriceRangeSlider(onPriceRangeChanged: (minRange, maxRange) {
              widget.bloc.onChangedMinMaxRange(minRange, maxRange);
            }),
            const SizedBox(
              height: kMargin10,
            ),
            CommonButtonView(
              label: AppLocalizations.of(context)!.confirm,
              labelColor: Colors.white,
              bgColor: kPrimaryColor,
              onTapButton: () {
                Navigator.pop(context);
                widget.bloc.searchProductByDynamicParam();
              },
            )
          ],
        ),
      ),
    );
  }
}

void showRatingAndPriceGeneralDialog(BuildContext context, SearchProductBloc bloc) {
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
            child: RatingAndPriceDialogView(
              bloc: bloc,
            ),
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
