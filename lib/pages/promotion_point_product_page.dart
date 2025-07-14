import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/promotion_point_product_bloc.dart';
import 'package:smile_shop/list_items/trending_product_list_item_view.dart';
import 'package:smile_shop/localization/app_localizations.dart';
import 'package:smile_shop/pages/sub_category_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/responsive.dart';
import 'package:smile_shop/widgets/category_vertical_icon_with_label_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

class PromotionPointProductPage extends StatelessWidget {
  const PromotionPointProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PromotionPointProductBloc(),
      child: Scaffold(
        appBar: CustomAppBarView(
            title: AppLocalizations.of(context)?.promotionPoints ?? ""),
        body: Consumer<PromotionPointProductBloc>(
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
                          // height: 250,
                          child: GridView.builder(
                              itemCount: (bloc.categoryList?.length ?? 0) > 6
                                  ? 6
                                  : bloc.categoryList?.length,
                              gridDelegate:
                                   SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 10.0,
                                      crossAxisSpacing: 10.0,
                                      childAspectRatio:  Responsive(context).isTablet ? 2/1.2 :  0.9),
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
