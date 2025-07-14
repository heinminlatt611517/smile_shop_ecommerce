import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/home_bloc.dart';
import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/list_items/trending_product_list_item_view.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/campaign_page.dart';
import 'package:smile_shop/pages/category_page.dart';
import 'package:smile_shop/pages/daily_checkin_page.dart';
import 'package:smile_shop/pages/below_3000_items_page.dart';
import 'package:smile_shop/pages/language_page.dart';
import 'package:smile_shop/pages/promotion_point_product_page.dart';
import 'package:smile_shop/pages/search_product_page.dart';
import 'package:smile_shop/pages/smile_point_page.dart';
import 'package:smile_shop/pages/sub_category_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/utils/responsive.dart';
import 'package:smile_shop/utils/strings.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smile_shop/localization/app_localizations.dart';
import 'package:video_player/video_player.dart';

import '../utils/dimens.dart';
import '../widgets/category_vertical_icon_with_label_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(context),
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) => WillPopScope(
          onWillPop: () => bloc.onWillPop(),
          child: const Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(double.infinity, 55),
                child: SafeArea(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kMarginMedium2, vertical: kMarginSmall),
                  child: SearchView(),
                )),
              ),
              backgroundColor: kBackgroundColor,
              body: HomeContentView()),
        ),
      ),
    );
  }
}

///home content view
class HomeContentView extends StatelessWidget {
  const HomeContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeBloc>(
      builder: (context, bloc, child) => CustomScrollView(
        controller: bloc.scrollController,
        slivers: [
          ///spacer
          const SliverToBoxAdapter(
              child: SizedBox(
            height: kMarginMedium2,
          )),

          // ///search view
          // const SliverToBoxAdapter(
          //   child: Padding(
          //     padding: EdgeInsets.all(kMarginLarge),
          //     child: SearchView(),
          //   ),
          // ),

          ///Banner view
          SliverToBoxAdapter(
            child: BannerSectionView(),
          ),

          ///Campaign ,Daily check in and User Level view
          SliverToBoxAdapter(
            child: Visibility(
              visible: GetStorage().read(kBoxKeyLoginUserType) == kTypeEndUser,
              child: const CampaignDailyCheckInUserWalletView(),
            ),
          ),

          ///Categories View
          const SliverToBoxAdapter(
            child: CategoriesView(),
          ),

          ///trending products view
          const SliverToBoxAdapter(
            child: TrendingProductsView(),
          )
        ],
      ),
    );
  }
}

///Search View
class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const SearchProductPage()));
            },
            child: Container(
              height: 40,
              width: double.infinity, // Adjust the width as needed
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: kSearchBackgroundColor,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(width: 1, color: Colors.grey.shade300)
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.2),
                  //     spreadRadius: 1,
                  //     blurRadius: 5,
                  //     offset: const Offset(0, 3), // changes position of shadow
                  //   ),
                  // ],
                  ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.search),
                  const SizedBox(),
                  const SizedBox(
                      width: 8.0), // Space between the icon and text field
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.searchHere,
                      style: const TextStyle(
                          fontSize: kTextRegular, color: Colors.grey),
                    ),
                    // child: TextField(
                    //   enabled: false,
                    //   decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       hintText: AppLocalizations.of(context)!.searchHere,
                    //       hintStyle: const TextStyle(
                    //         fontSize: kTextRegular,
                    //       )),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: kMarginMedium2,
        ),
        Consumer<HomeBloc>(
          builder: (context, bloc, child) => InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => const LanguagePage()))
                  .then(
                (value) {
                  bloc.init();
                },
              );
            },
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(25),
            //   child: CachedNetworkImage(height: 50, width: 50, fit: BoxFit.cover, imageUrl: bloc.userProfile?.profileImage == '' ? errorImageUrl : bloc.userProfile?.profileImage ?? errorImageUrl),
            // ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    bloc.currentFlagImage,
                    width: 30,
                    height: 30,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  bloc.getCurrentLanguageFormatted(),
                  style: const TextStyle(fontSize: kTextSmall),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

///Campaign ,Daily check in and User Level view
class CampaignDailyCheckInUserWalletView extends StatelessWidget {
  const CampaignDailyCheckInUserWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: kMarginMedium2, left: kMarginMedium2, right: kMarginMedium2),
      child: SizedBox(
        height: 160,
        child: Row(
          children: [
            ///daily check in and user level view
            Expanded(
              child: Column(
                children: [
                  ///Daily check in view
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const DailyCheckInPage())),
                      child: Container(
                        // padding: const EdgeInsets.all(kMarginMedium2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: kMarginMedium),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF9C4),
                          borderRadius: BorderRadius.circular(kMarginMedium),
                          border: Border.all(color: const Color(0xFFFDCC03)),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.3),
                          //     spreadRadius: 0,
                          //     blurRadius: 1,
                          //     offset: const Offset(0, 3), // changes position of shadow
                          //   ),
                          // ],
                          // gradient: const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                          //   Color(0xFFFDCC03),
                          //   Color(0xFFF5F5F5),
                          // ]),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.dailyCheckIn,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: kTextRegular,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: kMarginSmall,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .toClaimPointDaily,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: kTextXSmall,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: kMarginMedium,
                            ),
                            Image.asset(
                              height: 30,
                              width: 30,
                              kDailyCheckInIcon,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///User Level view
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SmilePointPage()));
                      },
                      child: Container(
                        // padding: const EdgeInsets.all(kMarginMedium2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: kMarginMedium),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD180),
                          borderRadius: BorderRadius.circular(kMarginMedium),
                          border: Border.all(color: const Color(0xFFFF8800)),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.3),
                          //     spreadRadius: 0,
                          //     blurRadius: 1,
                          //     offset: const Offset(0, 3), // changes position of shadow
                          //   ),
                          // ],
                          // gradient: const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                          //   kPrimaryColor,
                          //   Color(0xFFF5F5F5),
                          // ]),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.smileWallet,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: kTextRegular,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: kMarginSmall,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .toViewMyWallet,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: kTextXSmall,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: kMarginMedium,
                            ),
                            Image.asset(
                              kWallet,
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              width: kMarginMedium,
            ),

            ///Campaign view
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CampaignPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFF9C4),
                      borderRadius: BorderRadius.circular(kMarginMedium),
                      border: Border.all(color: const Color(0xFFFDCC03))
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.3),
                      //     spreadRadius: 0,
                      //     blurRadius: 1,
                      //     offset: const Offset(0, 3), // changes position of shadow
                      //   ),
                      // ],
                      // gradient: const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                      //   Color(0xFFFDCC03),
                      //   Color(0xFFF5F5F5),
                      // ]),
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        kCampaignIcon,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: kMargin10,
                      ),
                      Text(
                        AppLocalizations.of(context)!.campaign.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kTextRegular2x,
                            color: Colors.black),
                      ),
                      // Text(
                      //   AppLocalizations.of(context)!.letPracticeAndEnjoyIt,
                      //   style: const TextStyle(fontWeight: FontWeight.normal, fontSize: kTextSmall, color: Colors.grey),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///Categories View
class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kMarginXLarge),
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) => bloc
                .getCategoryListForHomePage()
                .isEmpty
            ? const SizedBox.shrink()
            : Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kMarginMedium2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.category ?? '',
                          style: const TextStyle(
                            fontSize: kTextRegular18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CategoryPage()));
                          },
                          child: const Text(
                            "See more",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: kTextSmall,
                                decoration: TextDecoration.underline,
                                decorationColor: kPrimaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: kMarginMedium,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (bloc.getCategoryListForHomePage()[index].type ==
                              CategoryType.below3000) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Below3000ItemsPage(
                                      title: bloc
                                              .getCategoryListForHomePage()[
                                                  index]
                                              .name ??
                                          "",
                                    )));
                          } else if (bloc
                                  .getCategoryListForHomePage()[index]
                                  .type ==
                              CategoryType.promotionPoint) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const PromotionPointProductPage()));
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubCategoryPage(
                                  categoryVO:
                                      bloc.getCategoryListForHomePage()[index],
                                ),
                              ),
                            );
                          }
                        },
                        child: CategoryVerticalIconWithLabelView(
                          isIconWithBg: true,
                          bgColor: kSecondaryColor,
                          categoryVO: bloc.getCategoryListForHomePage()[index],
                        ),
                      );
                    },
                    itemCount: bloc.getCategoryListForHomePage().length > 6
                        ? 6
                        : bloc.getCategoryListForHomePage().length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 14.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio:
                          Responsive(context).isTablet ? 2 : 2 / 1.5,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

///Banner Section View
class BannerSectionView extends StatelessWidget {
  BannerSectionView({super.key});

  final PageController _bannerPageController =
      PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Selector<HomeBloc, List<BannerVO>>(
      selector: (context, bloc) => bloc.banners,
      builder: (context, banners, child) => Column(
        children: [
          ///Page Banner View
          if (banners.isNotEmpty)
            SizedBox(
                height: kBannerHeight,
                child: PageView.builder(
                  controller: _bannerPageController,
                  itemBuilder: (context, index) {
                    BannerVO bannerVO = banners[index];
                    if (bannerVO.isImage()) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: kMarginMedium),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kMarginMedium),
                          child: CachedNetworkImageView(
                            imageHeight: 80,
                            imageWidth: double.infinity,
                            imageUrl: bannerVO.sourceUrl ?? errorImageUrl,
                          ),
                        ),
                      );
                    } else {
                      return BannerVideoView(bannerVO: bannerVO);
                    }
                  },
                  itemCount: banners.length,
                )),

          ///Spacer
          const SizedBox(
            height: kMarginMedium2,
          ),

          ///Dots indicator
          if (banners.isNotEmpty)
            SmoothPageIndicator(
              controller: _bannerPageController,
              count: banners.length,
              axisDirection: Axis.horizontal,
              effect: const SlideEffect(
                dotHeight: kMarginMedium,
                dotWidth: kMarginMedium,
                dotColor: kInactiveColor,
                activeDotColor: kPrimaryColor,
              ),
              onDotClicked: (index) {
                _bannerPageController.animateToPage(
                  index,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 500),
                );
              },
            )
        ],
      ),
    );
  }
}

class BannerVideoView extends StatefulWidget {
  const BannerVideoView({
    super.key,
    required this.bannerVO,
  });

  final BannerVO bannerVO;

  @override
  State<BannerVideoView> createState() => _BannerVideoViewState();
}

class _BannerVideoViewState extends State<BannerVideoView> {
  VideoPlayerController? controller;
  bool isMute = true;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.bannerVO.sourceUrl ?? ''),
    )
      ..initialize()
      ..setLooping(true)
      ..setVolume(0)
      ..play();
    setState(() {});
  }

  void changeVolume() {
    if (isMute) {
      controller?.setVolume(50);
    } else {
      controller?.setVolume(0);
    }

    isMute = !isMute;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: kMarginMedium),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kMarginMedium),
            child: controller == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : VideoPlayer(controller!),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kMarginMedium2, vertical: kMargin10),
            child: InkWell(
              onTap: () {
                changeVolume();
              },
              child: Container(
                padding: const EdgeInsets.all(kMarginSmall),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey),
                child: Icon(
                  isMute ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

///Trending Products View
class TrendingProductsView extends StatelessWidget {
  const TrendingProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeBloc>(
      builder: (context, bloc, child) => Padding(
        padding: const EdgeInsets.all(kMarginMedium2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.trendingProducts,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: kTextRegular18),
            ),
            const SizedBox(
              height: 10,
            ),
            Selector<HomeBloc, List<ProductVO>>(
                selector: (context, bloc) => bloc.productList,
                builder: (context, products, child) {
                  return products.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        )
                      : Selector<HomeBloc, bool>(
                          selector: (context, bloc) => bloc.isLoading,
                          builder: (context, isLoading, child) {
                            return Column(
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return TrendingProductListItemView(
                                      productVO: products[index],
                                      onTapFavourite: (product) {
                                        var bloc = Provider.of<HomeBloc>(
                                            context,
                                            listen: false);
                                        bloc.onTapFavourite(product, context);
                                      },
                                    );
                                  },
                                  itemCount: products.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 14.0,
                                    crossAxisSpacing: 10.0,
                                    childAspectRatio:
                                        Responsive(context).isTablet
                                            ? 1
                                            : 2 / 2.7,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Visibility(
                                    visible: isLoading,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      ),
                                    )),
                                const SizedBox(
                                  height: 40,
                                )
                              ],
                            );
                          },
                        );
                }),
          ],
        ),
      ),
    );
  }
}
