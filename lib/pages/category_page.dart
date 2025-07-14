// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/category_bloc.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/pages/below_3000_items_page.dart';
import 'package:smile_shop/pages/sub_category_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/responsive.dart';
import 'package:smile_shop/widgets/category_vertical_icon_with_label_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import 'package:smile_shop/localization/app_localizations.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: CustomAppBarView(
            title: AppLocalizations.of(context)?.category ?? ''),
        body: Consumer<CategoryBloc>(
          builder: (context, bloc, child) => bloc.categoryList == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (bloc.categoryList?[index].type == CategoryType.below3000) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Below3000ItemsPage(
                                    title: bloc.categoryList?[index].name ?? "",
                                  )));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubCategoryPage(
                                categoryVO: bloc.categoryList?[index],
                              ),
                            ),
                          );
                        }
                      },
                      child: CategoryVerticalIconWithLabelView(
                        isIconWithBg: true,
                        bgColor: kSecondaryColor,
                        categoryVO: bloc.categoryList?[index],
                      ),
                    );
                  },
                  itemCount: bloc.categoryList?.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 14.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio:
                        Responsive(context).isTablet ? 2 : 2 / 1.5,
                  ),
                ),
        ),
      ),
    );
  }
}
