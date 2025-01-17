import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/product_details_bloc.dart';
import 'package:smile_shop/blocs/product_details_bottom_sheet_bloc.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/variant_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/cart_page.dart';
import 'package:smile_shop/pages/ticket_screen.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/widgets/promotion_point_view.dart';
import 'package:smile_shop/widgets/vertical_icon_with_label_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../utils/dimens.dart';
import '../utils/images.dart';
import '../widgets/cached_network_image_view.dart';
import '../widgets/hex_color.dart';
import '../widgets/loading_view.dart';
import '../widgets/svg_image_view.dart';
import 'checkout_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final String? productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with SingleTickerProviderStateMixin {
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
      child: Selector<ProductDetailsBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (BuildContext context, isLoading, Widget? child) => Scaffold(
          backgroundColor: kBackgroundColor,
          body: Selector<ProductDetailsBloc, ProductVO?>(
              selector: (context, bloc) => bloc.productVO,
              builder: (context, product, child) {
                return Stack(
                  children: [
                    Stack(
                      children: [
                        NestedScrollView(
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              /// Banner Section View
                              SliverToBoxAdapter(
                                child: BannerSectionView(
                                  images: product?.images ?? [],
                                ),
                              ),

                              /// Spacer
                              const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: kMarginMedium,
                                ),
                              ),

                              /// Category and Return Point View
                              SliverToBoxAdapter(
                                child: CategoryAndReturnPointView(
                                  productVO: product,
                                ),
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
                                    labelPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    tabs: const [
                                      Text('Product Details',
                                          textAlign: TextAlign.center),
                                      Text('Product Specifications',
                                          textAlign: TextAlign.center),
                                      Text('After Sale',
                                          textAlign: TextAlign.center),
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
                            children: [
                              ProductDetailsView(
                                images: product?.images ?? [],
                              ),
                              ProductDetailsView(
                                images: product?.images ?? [],
                              ),
                              ProductDetailsView(
                                images: product?.images ?? [],
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: kBackgroundColor,
                        height: 60,
                        width: double.infinity,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              VerticalIconWithLabelView(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TicketScreen()),
                                    );
                                  },
                                  icon: Icons.chat,
                                  label: "Live Chat"),
                              VerticalIconWithLabelView(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CartPage()),
                                    );
                                  },
                                  icon: Icons.shopping_cart_outlined,
                                  label: "Cart"),
                              VerticalIconWithLabelView(
                                  onTap: () {
                                    var bloc = Provider.of<ProductDetailsBloc>(
                                        context,
                                        listen: false);
                                    bloc.onTapFavourite(product, context);
                                  },
                                  icon: Icons.favorite_outline,
                                  label: "Favourite"),

                              ///add to cart and buy now
                              Selector<ProductDetailsBloc, ProductVO?>(
                                selector: (context, bloc) => bloc.productVO,
                                builder: (context, product, child) => Row(
                                  children: [
                                    ///add to cart
                                    Consumer<ProductDetailsBloc>(
                                      builder: (context, bloc, child) =>
                                          InkWell(
                                        onTap: () {
                                          showBuyNowOrAddToCartBottomSheet(
                                              context,
                                              product?.variantVO?.isNotEmpty ??
                                                      true
                                                  ? product?.variantVO
                                                  : [],
                                              product?.name ?? "",
                                              product,
                                              bloc,
                                              true);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(6),
                                                      bottomLeft:
                                                          Radius.circular(6)),
                                              color: kPrimaryColor,
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    kSecondaryColor,
                                                    kPrimaryColor
                                                        .withOpacity(0.7),
                                                  ])),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Add To Cart',
                                              style: TextStyle(
                                                  color: kBackgroundColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    ///buy now
                                    Consumer<ProductDetailsBloc>(
                                      builder: (context, bloc, chid) => InkWell(
                                        onTap: () {
                                          showBuyNowOrAddToCartBottomSheet(
                                              context,
                                              product?.variantVO?.isNotEmpty ??
                                                      true
                                                  ? product?.variantVO
                                                  : [],
                                              product?.name ?? "",
                                              product,
                                              bloc,
                                              false);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(6),
                                                bottomRight:
                                                    Radius.circular(6)),
                                            color: kPrimaryColor,
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Buy Now',
                                              style: TextStyle(
                                                  color: kBackgroundColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
  final List<String> images;

  const ProductDetailsView({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kMarginLarge),
      child: ListView.builder(
        itemCount: images.length,
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
              imageUrl: images[index],
            ),
          );
        },
      ),
    );
  }
}

/// Banner Section View
class BannerSectionView extends StatelessWidget {
  final List<String> images;

  BannerSectionView({super.key, required this.images});

  final PageController _bannerPageController =
      PageController(viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    debugPrint("ImageLength:::${images.length}");
    return Column(
      children: [
        /// Page Banner View
        Stack(
          children: [
            SizedBox(
              height: 260,
              width: double.infinity,
              child: images.isEmpty
                  ? const CachedNetworkImageView(
                      imageHeight: 120,
                      imageWidth: double.infinity,
                      imageUrl: errorImageUrl,
                    )
                  : PageView.builder(
                      controller: _bannerPageController,
                      itemBuilder: (context, index) {
                        return CachedNetworkImageView(
                          imageHeight: 120,
                          imageWidth: double.infinity,
                          imageUrl: images[index],
                        );
                      },
                      itemCount: images.length,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(kMarginMedium),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const SvgImageView(
                    imageName: kBackSvgIcon,
                    imageHeight: 20,
                    imageWidth: 20,
                  ),
                ),
              ),
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
          count: images.length,
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
  final ProductVO? productVO;

  const CategoryAndReturnPointView({super.key, required this.productVO});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kMarginMedium, horizontal: kMarginMedium),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  maxLines: 2,
                  productVO?.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: kTextRegular2x, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              const Icon(
                Icons.star,
                color: kPrimaryColor,
                size: 20,
              ),
              Text(
                productVO?.rating.toString() ?? "0",
                style: const TextStyle(
                    fontSize: kTextRegular,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kMarginMedium, horizontal: kMarginMedium),
          child: Row(
            children: [
              Text(
                productVO?.subcategory?.name ?? "",
                style: const TextStyle(
                    fontSize: kTextRegular, fontWeight: FontWeight.normal),
              ),
              const Spacer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kMarginMedium, horizontal: kMarginMedium),
          child: Row(
            children: [
              const Text(
                'Ks 50,000',
                style: TextStyle(
                    fontSize: kTextRegular,
                    decoration: TextDecoration.lineThrough),
              ),
              const SizedBox(
                width: kMarginSmall,
              ),
              Text(
                'Ks ${productVO?.price}',
                style: const TextStyle(
                    fontSize: kTextRegular,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kMarginMedium)),
          margin: const EdgeInsets.symmetric(
              vertical: kMarginMedium, horizontal: kMarginMedium),
          padding: const EdgeInsets.symmetric(
              vertical: kMarginMedium, horizontal: kMarginMedium),
          child: Row(
            children: [
              const Text(
                'Return Points',
                style: TextStyle(
                    fontSize: kTextRegular2x, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              PromotionPointView(
                point:productVO?.variantVO?.isNotEmpty ?? true ? productVO?.variantVO?.first.redeemPoint ?? 0 : 0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

///bottomsheet
void showBuyNowOrAddToCartBottomSheet(
    BuildContext context,
    List<VariantVO>? variantVO,
    String productName,
    ProductVO? productVO,
    ProductDetailsBloc productDetailBloc,
    bool isAddToCart) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider(
        create: (context) => ProductDetailsBottomSheetBloc(
           variantVO?.isNotEmpty ?? true ? variantVO?.first.colorName ?? "" : "", variantVO?.isNotEmpty ?? true ? variantVO?.first.price : 0),
        child: Container(
          decoration: const BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          width: double.infinity, // Ensures full width of the parent
          child: Padding(
            padding: const EdgeInsets.all(kMarginMedium2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///close button
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),

                ///image , name , price view
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: CachedNetworkImageView(
                        imageHeight: 100,
                        imageWidth: 100,
                        imageUrl: productVO?.images?.isNotEmpty ?? true
                            ? productVO?.images?.first ?? errorImageUrl
                            : errorImageUrl,
                      ),
                    ),
                    const SizedBox(
                      width: kMarginMedium3,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: kTextRegular2x,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: kMargin10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Consumer<ProductDetailsBottomSheetBloc>(
                                builder: (context, bloc, child) => Text(
                                  "Ks ${bloc.updateTotalPrice}",
                                  style:
                                      const TextStyle(fontSize: kTextRegular2x),
                                ),
                              ),
                              const SizedBox(
                                width: kMargin30,
                              ),
                              PromotionPointView(
                                point:variantVO?.isNotEmpty ?? true ? variantVO?.first.promotionPoint ?? 0 : 0,
                              )
                            ],
                          ),

                          const SizedBox(
                            height: kMargin10,
                          ),

                          ///quality increase and decrease view
                          Consumer<ProductDetailsBottomSheetBloc>(
                            builder: (context, bloc, child) => Row(
                              children: [
                                ///increase and decrease
                                TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    bloc.onTapMinus();
                                  },
                                  child: const Icon(
                                    Icons.remove_circle,
                                    color: kPrimaryColor,
                                    size: 27,
                                  ),
                                ),
                                const SizedBox(
                                  width: kMarginMedium,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kMarginMedium),
                                  child: Text(bloc.quantityCount.toString()),
                                ),
                                const SizedBox(
                                  width: kMarginMedium,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    bloc.onTapAdd();
                                  },
                                  child: const Icon(
                                    Icons.add_circle,
                                    color: kPrimaryColor,
                                    size: 27,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                ///spacer
                const SizedBox(
                  height: kMarginLarge,
                ),

                ///color view
                const Text(
                  'Available Color',
                  style:
                      TextStyle(color: Colors.black, fontSize: kTextRegular2x),
                ),

                ///spacer
                const SizedBox(
                  height: kMarginSmall,
                ),

                ///selectable colors
                Consumer<ProductDetailsBottomSheetBloc>(
                  builder: (context, bloc, child) {
                    return SizedBox(
                      height: 24,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: variantVO?.length,
                        itemBuilder: (context, index) {
                          bool isSelected = bloc.isSelected(index);

                          return InkWell(
                            onTap: () {
                              bloc.toggleSelectionColor(
                                  index, variantVO?[index].colorName ?? "");
                              // productDetailBloc.onTapColor(
                              //     variantVO?[index].colorName ?? "");
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kMarginMedium),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        bottomLeft: Radius.circular(6)),
                                    child: CachedNetworkImageView(
                                        imageHeight: 24,
                                        imageWidth: 24,
                                        imageUrl: variantVO?[index].image ??
                                            errorImageUrl),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(6),
                                            bottomRight: Radius.circular(6)),
                                        color: isSelected
                                            ? kPrimaryColor
                                            : Colors.white),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kMarginMedium),
                                        child: Text(
                                          variantVO?[index].colorName ?? "",
                                          style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : kPrimaryColor),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );

                          // return Padding(
                          //   padding:
                          //       const EdgeInsets.only(right: kMarginMedium),
                          //   child: InkWell(
                          //     onTap: () {
                          //       bloc.toggleSelectionColor(
                          //           index, variantVO?[index].colorName ?? "");
                          //       var productDetailBloc =
                          //           Provider.of<ProductDetailsBloc>(context,
                          //               listen: false);
                          //       productDetailBloc.onTapColor(
                          //           variantVO?[index].colorName ?? "");
                          //     },
                          //     child: Container(
                          //       width: 20,
                          //       height: 20,
                          //       decoration: BoxDecoration(
                          //         shape: BoxShape.circle, // Circle shape
                          //         color: hexToColor(
                          //             variantVO?[index].colorVO?.value ?? ""),
                          //         border: Border.all(
                          //           color: isSelected
                          //               ? kPrimaryColor
                          //               : Colors.grey,
                          //           width: 1,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                    );
                  },
                ),

                ///spacer
                const SizedBox(
                  height: kMarginLarge,
                ),

                ///color view
                const Text(
                  'Available Size',
                  style:
                      TextStyle(color: Colors.black, fontSize: kTextRegular2x),
                ),

                ///spacer
                const SizedBox(
                  height: kMarginSmall,
                ),

                ///selectable size
                Consumer<ProductDetailsBottomSheetBloc>(
                  builder: (context, bloc, child) {
                    return SizedBox(
                      height: 24,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: variantVO?.length,
                        itemBuilder: (context, index) {
                          bool isSelected = bloc.isSelectedSize(index);

                          return InkWell(
                            onTap: () {
                              bloc.toggleSelectionSize(
                                  index, variantVO?[index].sizeVO?.value ?? "");
                              // productDetailBloc.onTapSize(
                              //     variantVO?[index].sizeVO?.value ?? "");
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kMarginMedium),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: isSelected
                                        ? kPrimaryColor
                                        : Colors.white),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kMarginMedium),
                                    child: Text(
                                      variantVO?[index].sizeVO?.value ?? "",
                                      style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : kPrimaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                ///spacer
                const SizedBox(
                  height: kMarginLarge,
                ),

                ///buy now button
                Visibility(
                  visible: isAddToCart == true ? false : true,
                  child: Consumer<ProductDetailsBottomSheetBloc>(
                    builder: (context, bloc, child) => CommonButtonView(
                      label: 'Buy Now',
                      labelColor: Colors.white,
                      bgColor: kPrimaryColor,
                      onTapButton: () {
                        if (bloc.selectedColor != "" &&
                            bloc.selectedSize != "") {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => CheckoutPage(
                                    isFromCartPage: false,
                                    productList: [
                                      productVO?.copyWith(
                                              colorName: bloc.selectedColor,
                                              size: bloc.selectedSize,
                                              totalPrice: bloc.updateTotalPrice,
                                              qtyCount: bloc.quantityCount) ??
                                          ProductVO()
                                    ],
                                  )));
                        } else {
                          showTopSnackBar(
                            displayDuration: const Duration(milliseconds: 300),
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message: "Please select both color and size.",
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),

                ///add to cart button
                Visibility(
                  visible: isAddToCart == true ? true : false,
                  child: Consumer<ProductDetailsBottomSheetBloc>(
                    builder: (context, bloc, child) => CommonButtonView(
                      label: 'Add To Cart',
                      labelColor: Colors.white,
                      bgColor: kPrimaryColor,
                      onTapButton: () {
                        if (bloc.selectedColor != "" &&
                            bloc.selectedSize != "") {
                          productDetailBloc.onTapAddToCart(
                              context,
                              bloc.selectedColor,
                              bloc.selectedSize,
                              bloc.quantityCount ?? 0,
                              bloc.updateTotalPrice ?? 0);
                        } else {
                          showTopSnackBar(
                            displayDuration: const Duration(milliseconds: 300),
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message: "Please select both color and size.",
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),

                ///spacer
                const SizedBox(
                  height: kMarginLarge,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
