import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/home_bloc.dart';
import 'package:smile_shop/data/vos/banner_vo.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/list_items/trending_product_list_item_view.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/daily_checkin_page.dart';
import 'package:smile_shop/pages/search_product_page.dart';
import 'package:smile_shop/pages/sub_category_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/strings.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/dimens.dart';
import '../widgets/category_vertical_icon_with_label_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child:const Scaffold(
        backgroundColor: kBackgroundColor,
        body: HomeContentView()
      ),
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
        var bloc = Provider.of<HomeBloc>(context,
            listen: false);
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
        const SliverToBoxAdapter(
          child: CampaignDailyCheckInUserLevelView(),
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
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kPrimaryColor, width: 1),
          ),
          child: const Center(
            child: Icon(Icons.account_circle_sharp),
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
      child: InkWell(
        onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const DailyCheckInPage())),
        child: Row(
          children: [
            ///daily check in and user level view
            SizedBox(
              height: 155,
              child: Column(
                children: [
                  ///Daily check in view
                  Container(
                    padding: const EdgeInsets.all(kMarginMedium2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kMarginMedium),
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
                            child: const Icon(
                              Icons.shop,
                              color: kPrimaryColor,
                            ))
                      ],
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
                            child: const Icon(
                              Icons.shop,
                              color: kPrimaryColor,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
        
            ///Campaign view
            Expanded(
              child: Container(
                height: 150,
                padding: const EdgeInsets.only(left: kMarginMedium2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kMarginMedium),
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
                            borderRadius: BorderRadius.circular(kMarginMedium)),
                        child: const Icon(
                          Icons.shop,
                          color: kPrimaryColor,
                          size: 40,
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
                    builder: (context) =>  SubCategoryPage(categoryVO: categories[index],),
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
              _bannerPageController.animateToPage(index,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 500));
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
                              onTapFavourite: (product){
                                var bloc = Provider.of<HomeBloc>(context,
                                    listen: false);
                                bloc.onTapFavourite(product, context);
                              },
                            );
                          },
                          itemCount: products.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 2 / 2.7,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Visibility(
                            visible : isLoading,
                            child: const Center(child: CircularProgressIndicator(color: kPrimaryColor,),)),
                        const SizedBox(height: 40,)
                      ],
                    );
                  },
                )
                ;
              }),
        ],
      ),
    );
  }
}
