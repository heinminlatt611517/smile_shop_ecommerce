import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:smile_shop/pages/daily_checkin_page.dart';
import 'package:smile_shop/pages/search_product_page.dart';
import 'package:smile_shop/pages/sub_category_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/utils/strings.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/dimens.dart';
import '../widgets/category_vertical_icon_with_label_view.dart';
import 'main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(context),
      child: const Scaffold(
          backgroundColor: kBackgroundColor, body: HomeContentView()),
    );
  }
}

///home content view
class HomeContentView extends StatefulWidget {
  const HomeContentView({super.key});

  @override
  State<HomeContentView> createState() => _HomeContentViewState();
}

class _HomeContentViewState extends State<HomeContentView> {
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        var bloc = Provider.of<HomeBloc>(context, listen: false);
        bloc.getProducts();
        debugPrint("OnListEndReach");
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        ///spacer
        const SliverToBoxAdapter(
            child: SizedBox(
          height: kMarginXXLarge,
        )),

        ///search view
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(kMarginLarge),
            child: SearchView(),
          ),
        ),

        ///Banner view
        SliverToBoxAdapter(
          child: BannerSectionView(),
        ),

        ///Campaign ,Daily check in and User Level view
        SliverToBoxAdapter(
          child: Visibility(
              visible: GetStorage().read(kBoxKeyLoginUserType) == kTypeEndUser,
              child: const CampaignDailyCheckInUserLevelView()),
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
              child: const Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 8.0), // Space between the icon and text field
                  Expanded(
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
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
          ),
        ),
        const SizedBox(
          width: kMarginMedium2,
        ),
        Consumer<HomeBloc>(
          builder: (context, bloc, child) => InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const MainPage(initialIndex: 3),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  imageUrl: bloc.userProfile?.profileImage == ''
                      ? errorImageUrl
                      : bloc.userProfile?.profileImage ?? errorImageUrl),
            ),
          ),
        )
      ],
    );
  }
}

///Campaign ,Daily check in and User Level view
class CampaignDailyCheckInUserLevelView extends StatelessWidget {
  const CampaignDailyCheckInUserLevelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: kMarginMedium2, left: kMarginMedium2, right: kMarginMedium2),
      child: Row(
        children: [
          ///daily check in and user level view
          SizedBox(
            height: 155,
            child: Column(
              children: [
                ///Daily check in view
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const DailyCheckInPage())),
                  child: Container(
                    padding: const EdgeInsets.all(kMarginMedium2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kMarginMedium),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset:const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFFDCC03),
                              Color(0xFFF5F5F5),
                            ])),
                    child: Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              kDailyCheckInLabel,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: kTextRegular2x,
                                  color: Colors.black),
                            ),
                            Text(
                              kToClaimPointDailyLabel,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: kTextSmall,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: kMarginMedium,
                        ),
                        Container(
                            padding: const EdgeInsets.all(kMarginMedium),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(kMarginMedium)),
                            child: Image.asset(
                              height: 20,
                              width: 20,
                              kDailyCheckInIcon,
                              fit: BoxFit.cover,
                            ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                ///User Level view
                Container(
                  padding: const EdgeInsets.all(kMarginMedium2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMarginMedium),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset:const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            kPrimaryColor,
                            Color(0xFFF5F5F5),
                          ])),
                  child: Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kUserLevelLabel,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: kTextRegular2x,
                                color: Colors.black),
                          ),
                          Text(
                            kToClaimPointDailyLabel,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: kTextSmall,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: kMarginMedium,
                      ),
                      Container(
                          padding: const EdgeInsets.all(kMarginMedium),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(kMarginMedium)),
                          child: Image.asset(
                            kUserLevelIcon,
                            height: 20,
                            width: 20,
                            fit: BoxFit.cover,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),

          const SizedBox(width: kMarginMedium
            ,),

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
                height: 154,
                padding: const EdgeInsets.only(left: kMarginMedium2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kMarginMedium),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset:const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFFDCC03),
                          Color(0xFFF5F5F5),
                        ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(kMarginMedium),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(kMarginMedium)),
                        child: Image.asset(
                          kCampaignIcon,
                          height: 60,
                          width: 63,
                          fit: BoxFit.cover,
                        )),
                    const Text(
                      kCampaignLabel,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: kTextRegular2x,
                          color: Colors.black),
                    ),
                    const Text(
                      kLetPracticeAndEnjoyLabel,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: kTextSmall,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
      child: Selector<HomeBloc, List<CategoryVO>>(
        selector: (context, bloc) => bloc.categories,
        builder: (context, categories, child) => GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubCategoryPage(
                      categoryVO: categories[index],
                    ),
                  ),
                );
              },
              child: CategoryVerticalIconWithLabelView(
                isIconWithBg: true,
                bgColor: kSecondaryColor,
                categoryVO: categories[index],
              ),
            );
          },
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 2 / 1.5),
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
          SizedBox(
              height: kBannerHeight,
              child: PageView.builder(
                controller: _bannerPageController,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: kMarginMedium),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kMarginMedium),
                      child: CachedNetworkImageView(
                          imageHeight: 80,
                          imageWidth: double.infinity,
                          imageUrl: banners[index].image ?? errorImageUrl),
                    ),
                  );
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

///Trending Products View
class TrendingProductsView extends StatelessWidget {
  const TrendingProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kMarginMedium2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            kTrendingProductsLabel,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: kTextRegular3x),
          ),
          const SizedBox(
            height: 10,
          ),
          Selector<HomeBloc, List<ProductVO>>(
              selector: (context, bloc) => bloc.productList,
              builder: (context, products, child) {
                return products.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
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
                                      var bloc = Provider.of<HomeBloc>(context,
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
    );
  }
}
