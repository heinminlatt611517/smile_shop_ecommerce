import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/below_3000_items_bloc.dart';
import 'package:smile_shop/list_items/trending_product_list_item_view.dart';
import 'package:smile_shop/pages/sub_category_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/responsive.dart';
import 'package:smile_shop/widgets/category_vertical_icon_with_label_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

class Below3000ItemsPage extends StatelessWidget {
  final String title;
  const Below3000ItemsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Below3000ItemsBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: CustomAppBarView(title: title),
        body: Consumer<Below3000ItemsBloc>(
          builder: (context, bloc, child) {
            return bloc.productList == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                : SingleChildScrollView(
                    controller: bloc.scrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          // height: 210,
                          child: GridView.builder(
                              itemCount: (bloc.categoryList?.length ?? 0) > 6
                                  ? 6
                                  : bloc.categoryList?.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 10.0,
                                      crossAxisSpacing: 10.0,
                                      childAspectRatio:
                                          Responsive(context).isTablet
                                              ? 2 / 1.2
                                              : 0.9),
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
                                          categoryVO: bloc.categoryList?[index],
                                          minPrice: 0,
                                          maxPrice: 3000,
                                        ),
                                      ),
                                    );
                                  },
                                  child: CategoryVerticalIconWithLabelView(
                                    isIconWithBg: true,
                                    bgColor: kSecondaryColor,
                                    categoryVO: bloc.categoryList?[index],
                                  ),
                                );
                              }),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMarginMedium2),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return TrendingProductListItemView(
                              productVO: bloc.productList?[index],
                              onTapFavourite: (product) {
                                bloc.onTapFavourite(product, context);
                              },
                            );
                          },
                          itemCount: bloc.productList?.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio:
                                Responsive(context).isTablet ? 1 : 2 / 2.7,
                          ),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
