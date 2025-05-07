// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/pages/sub_category_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/responsive.dart';
import 'package:smile_shop/widgets/category_vertical_icon_with_label_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryPage extends StatelessWidget {
  final List<CategoryVO> categoryList;

  const CategoryPage({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar:
          CustomAppBarView(title: AppLocalizations.of(context)?.category ?? ''),
      body: GridView.builder(
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
                    categoryVO: categoryList[index],
                  ),
                ),
              );
            },
            child: CategoryVerticalIconWithLabelView(
              isIconWithBg: true,
              bgColor: kSecondaryColor,
              categoryVO: categoryList[index],
            ),
          );
        },
        itemCount: categoryList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 14.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: Responsive(context).isTablet ? 2 : 2 / 1.5,
        ),
      ),
    );
  }
}
