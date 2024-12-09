import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/product_details_bloc.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../data/dummy_data/banner_section_dummy_data.dart';
import '../utils/dimens.dart';
import '../widgets/cached_network_image_view.dart';
import '../widgets/loading_view.dart';

class ProductDetailsPage extends StatefulWidget {
  final String? productId;
  const ProductDetailsPage({super.key,required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductDetailsBloc(widget.productId ?? ""),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Selector<ProductDetailsBloc,bool>(
          selector: (context , bloc ) => bloc.isLoading,
          builder: (BuildContext context,isLoading, Widget? child) {
          return Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    /// Banner Section View
                    SliverToBoxAdapter(
                      child: BannerSectionView(),
                    ),

                    /// Spacer
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: kMarginMedium,
                      ),
                    ),

                    /// Category and Return Point View
                    const SliverToBoxAdapter(
                      child: CategoryAndReturnPointView(),
                    ),

                    /// Spacer
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: kMarginMedium,
                      ),
                    ),

                    /// Tab Bar
                    SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          unselectedLabelColor: Colors.black,
                          labelColor: kPrimaryColor,
                          indicatorWeight: 1,
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelPadding:const EdgeInsets.symmetric (horizontal: 10),
                          tabs: const [
                            Text('Product Details', textAlign: TextAlign.center),
                            Text('Product Specifications', textAlign: TextAlign.center),
                            Text('After Sale', textAlign: TextAlign.center),
                          ],
                          controller: tabController,
                          indicatorColor: kPrimaryColor,
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: tabController,
                  children: const [
                    ProductDetailsView(),
                    ProductDetailsView(),
                    ProductDetailsView(),
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
          );}
        ),
      ),
    );
  }
}

/// Custom SliverPersistentHeaderDelegate for TabBar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: kBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

/// Product Details View
class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kMarginLarge),
      child: ListView.builder(
        itemCount: bannerSectionDummyData.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: kMarginMedium,
              left: kMarginMedium,
              right: kMarginMedium,
            ),
            child: CachedNetworkImageView(
              imageHeight: 340,
              imageWidth: double.infinity,
              imageUrl: bannerSectionDummyData[index],
            ),
          );
        },
      ),
    );
  }
}

/// Banner Section View
class BannerSectionView extends StatelessWidget {
  BannerSectionView({super.key});

  final PageController _bannerPageController = PageController(viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Page Banner View
        Stack(
          children: [
            SizedBox(
              height: 260,
              width: double.infinity,
              child: PageView.builder(
                controller: _bannerPageController,
                itemBuilder: (context, index) {
                  return CachedNetworkImageView(
                    imageHeight: 120,
                    imageWidth: double.infinity,
                    imageUrl: bannerSectionDummyData[index],
                  );
                },
                itemCount: bannerSectionDummyData.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
              child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.keyboard_backspace)),
            ),
          ],
        ),

        /// Spacer
        const SizedBox(
          height: kMarginMedium2,
        ),

        /// Dots Indicator
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
        ),
      ],
    );
  }
}

/// Category and Return Point View
class CategoryAndReturnPointView extends StatelessWidget {
  const CategoryAndReturnPointView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
              vertical: kMarginMedium, horizontal: kMarginMedium),
          child: Row(
            children: [
              Text(
                'MIELLE Rosemary Mint',
                style: TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(
                Icons.star,
                color: Colors.black,
              ),
              Text(
                '4.5',
                style: TextStyle(
                    fontSize: kTextRegular, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
              vertical: kMarginMedium, horizontal: kMarginMedium),
          child: Row(
            children: [
              Text(
                'Beauty Category',
                style: TextStyle(
                    fontSize: kTextRegular, fontWeight: FontWeight.normal),
              ),
              Spacer(),
              Icon(
                Icons.currency_bitcoin,
                color: kSecondaryColor,
              ),
              Text(
                '100 pt',
                style: TextStyle(
                    fontSize: kTextRegular,
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
              vertical: kMarginMedium, horizontal: kMarginMedium),
          child: Row(
            children: [
              Text(
                'Ks 50,000',
                style: TextStyle(
                    fontSize: kTextRegular, decoration: TextDecoration.underline),
              ),
              SizedBox(width: kMarginSmall,),
              Text(
                'Ks 35,000',
                style: TextStyle(
                    fontSize: kTextRegular,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(kMarginMedium)),
          margin: const EdgeInsets.symmetric(
              vertical: kMarginMedium, horizontal: kMarginMedium),
          padding: const EdgeInsets.symmetric(
              vertical: kMarginMedium, horizontal: kMarginMedium),
          child: const Row(
            children: [
              Text(
                'Return Points',
                style: TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(
                Icons.currency_bitcoin,
                color: kSecondaryColor,
              ),
              Text(
                '50 pt',
                style: TextStyle(
                    fontSize: kTextRegular,
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor),
              )
            ],
          ),
        ),
      ],
    );
  }
}
