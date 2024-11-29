import 'package:flutter/material.dart';
import 'package:smile_shop/data/dummy_data/accessories_dummy_data.dart';
import 'package:smile_shop/data/dummy_data/trending_products_dummy_data.dart';
import 'package:smile_shop/list_items/trending_product_list_item_view.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/strings.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../data/dummy_data/banner_section_dummy_data.dart';
import '../utils/dimens.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        slivers: [
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

          ///Accessories View
          const SliverToBoxAdapter(
            child: AccessoriesView(),
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
      padding: const EdgeInsets.only(top: kMarginMedium2,
      left: kMarginMedium2,right: kMarginMedium2),
      child: Row(
        children: [
          ///daily check in and user level view
          SizedBox(
            height: 155,
            child: Column(
              children: [
                ///Daily check in view
                Container(
                  padding:const EdgeInsets.all(kMarginMedium2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMarginMedium),
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFFDCC03),
                            Color(0xFFF5F5F5),
                          ])),
                  child:  Row(children: [
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
                    ],),
                    const SizedBox(width: kMarginMedium,),
                    Container(
                        padding:const EdgeInsets.all(kMarginMedium),
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(kMarginMedium
                        )),
                        child:const Icon(Icons.shop,color: kPrimaryColor,))
                  ],),
                ),
                const SizedBox(height: 10,),
                ///User Level view
                Container(
                  padding:const EdgeInsets.all(kMarginMedium2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMarginMedium),
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            kPrimaryColor,
                            Color(0xFFF5F5F5),
                          ])),
                  child:  Row(children: [
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
                      ],),
                    const SizedBox(width: kMarginMedium,),
                    Container(
                        padding:const EdgeInsets.all(kMarginMedium),
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(kMarginMedium
                        )),
                        child:const Icon(Icons.shop,color: kPrimaryColor,))
                  ],),
                )
              ],
            ),
          ),

          ///Campaign view
          Expanded(
            child: Container(
              height: 150,
              padding:const EdgeInsets.only(left: kMarginMedium2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kMarginMedium),
                  gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFFDCC03),
                        Color(0xFFF5F5F5),
                      ])),
              child:   Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerRight,
                      padding:const EdgeInsets.all(kMarginMedium),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(kMarginMedium
                      )),
                      child:const Icon(Icons.shop,color: kPrimaryColor,size: 40,)),
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
                ],),
            ),
          ),
        ],
      ),
    );
  }
}

///Accessories View
class AccessoriesView extends StatelessWidget {
  const AccessoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kMarginLarge),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            const Icon(Icons.shopping_bag_rounded,color: kPrimaryColor,size: 30,),
            const SizedBox(height: 4,),
            Text(
              textAlign: TextAlign.center,
              accessoriesDummyData[index]['name'] ?? "",style:const TextStyle(color: Colors.black,fontSize:12
            ),)
          ],);
        },
        itemCount: accessoriesDummyData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 2/1.5
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
    return Column(
      children: [
        ///Page Banner View
        SizedBox(
            height: kBannerHeight,
            child: PageView.builder(
              controller: _bannerPageController,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: kMarginMedium),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kMarginMedium),
                    child: CachedNetworkImageView(
                        imageHeight: 80,
                        imageWidth: double.infinity,
                        imageUrl: bannerSectionDummyData[index]),
                  ),
                );
              },
              itemCount: bannerSectionDummyData.length,
            )),

        ///Spacer
        const SizedBox(
          height: kMarginMedium2,
        ),

        ///Dots indicator
        SmoothPageIndicator(
          controller: _bannerPageController,
          count: bannerSectionDummyData.length,
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return TrendingProductListItemView(
                  imageUrl: trendingProductDummyData[index]['image'] ??
                      errorImageUrl);
            },
            itemCount: trendingProductDummyData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2 / 2.7),
          ),
        ],
      ),
    );
  }
}
