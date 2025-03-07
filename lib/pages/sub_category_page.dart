import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/sub_category_bloc.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/pages/product_category_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/responsive.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import 'package:smile_shop/widgets/loading_view.dart';
import 'package:smile_shop/widgets/subcategory_vertical_icon_with_label_view.dart';
import '../list_items/trending_product_list_item_view.dart';

class SubCategoryPage extends StatelessWidget {
  final CategoryVO? categoryVO;

  const SubCategoryPage({super.key, required this.categoryVO});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SubCategoryBloc(categoryVO?.id ?? 0),
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: CustomAppBarView(
            title: categoryVO?.name ?? "",
          ),
          body: Selector<SubCategoryBloc, bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (BuildContext context, isLoading, Widget? child) => Stack(
              children: [
                ///body view
                Selector<SubCategoryBloc, List<SubcategoryVO>>(
                    selector: (context, bloc) => bloc.subCategories,
                    builder: (context, subCategories, child) {
                      SubCategoryBloc bloc = Provider.of<SubCategoryBloc>(context, listen: false);
                      return subCategories.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(kMarginMedium2),
                              child: CustomScrollView(
                                controller: bloc.scrollController,
                                slivers: [
                                  ///sub category view
                                  SliverToBoxAdapter(
                                    child: SubCategoryView(
                                      subCategories: subCategories,
                                    ),
                                  ),

                                  ///spacer
                                  const SliverToBoxAdapter(
                                      child: SizedBox(
                                    height: kMarginMedium2,
                                  )),

                                  ///product view
                                  const SliverToBoxAdapter(
                                    child: ProductsView(),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink();
                    }),

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

///sub category view
class SubCategoryView extends StatelessWidget {
  final List<SubcategoryVO> subCategories;

  const SubCategoryView({super.key, required this.subCategories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductCategoryPage(
                  categoryName: subCategories[index].name,
                  subCategoryId: subCategories[index].id,
                ),
              ),
            );
          },
          child: SubCategoryVerticalIconWithLabelView(
            subcategoryVO: subCategories[index],
          ),
        );
      },
      itemCount: subCategories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
    );
  }
}

///products view
class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SubCategoryBloc>(
      builder: (context, bloc, child) {
        List<ProductVO> products = bloc.products;
        return products.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return TrendingProductListItemView(
                    productVO: products[index],
                    onTapFavourite: (product) {
                      var bloc = Provider.of<SubCategoryBloc>(context, listen: false);
                      bloc.onTapFavourite(product, context);
                    },
                  );
                },
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: Responsive(context).isTablet ? 1 : 2 / 2.7,
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
