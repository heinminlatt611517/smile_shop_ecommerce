import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/sub_category_bloc.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/pages/product_category_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import 'package:smile_shop/widgets/loading_view.dart';
import 'package:smile_shop/widgets/subcategory_vertical_icon_with_label_view.dart';
import '../data/dummy_data/trending_products_dummy_data.dart';
import '../data/vos/product_response_data_vo.dart';
import '../list_items/trending_product_list_item_view.dart';
import '../network/api_constants.dart';
import '../utils/images.dart';

class SubCategoryPage extends StatelessWidget {
  final CategoryVO? categoryVO;

  const SubCategoryPage({super.key, required this.categoryVO});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SubCategoryBloc(categoryVO?.id ?? 0),
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: CustomAppBarView(title: categoryVO?.name ?? "",),
          body: Selector<SubCategoryBloc, List<SubcategoryVO>>(
              selector: (context, bloc) => bloc.subCategories,
              builder: (context, subCategories, child) {
                return subCategories.isEmpty
                    ? const LoadingView(
                        indicator: Indicator.ballSpinFadeLoader,
                        indicatorColor: kPrimaryColor)
                    : Padding(
                        padding: const EdgeInsets.all(kMarginMedium2),
                        child: CustomScrollView(
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
                      );
              })),
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
                builder: (context) => ProductCategoryPage(categoryName: subCategories[index].name,),
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
          crossAxisSpacing: 10.0,),
    );
  }
}

///products view
class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<SubCategoryBloc, ProductResponseDataVO?>(
        selector: (context, bloc) => bloc.productResponseDataVO,
        builder: (context, productResponse, child) {
          return productResponse == null
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return TrendingProductListItemView(
                productVO: productResponse.products?[index],
              );
            },
            itemCount: productResponse.products?.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2 / 2.7),
          );
        });
  }
}
