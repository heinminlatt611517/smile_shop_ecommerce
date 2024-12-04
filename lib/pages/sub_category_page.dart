import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import '../data/dummy_data/accessories_dummy_data.dart';
import '../data/dummy_data/trending_products_dummy_data.dart';
import '../list_items/trending_product_list_item_view.dart';
import '../network/api_constants.dart';
import '../widgets/icon_with_label_vertical_view.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          title: const Text('Sub category',style: TextStyle(fontSize: kTextRegular2x,fontWeight: FontWeight.bold),),
        ),
      body: const Padding(
        padding: EdgeInsets.all(kMarginMedium2),
        child: CustomScrollView(
          slivers: [
            ///sub category view
            SliverToBoxAdapter(child: SubCategoryView(),),

            ///spacer
            SliverToBoxAdapter(child: SizedBox(height: kMarginMedium2,)),

            ///product view
            SliverToBoxAdapter(child: ProductsView(),),

          ],
        ),
      )
    );
  }
}

///sub category view
class SubCategoryView extends StatelessWidget {
  const SubCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return  IconWithLabelVerticalView(
          isIconWithBg: false,
          bgColor: Colors.white,index: index,);
      },
      itemCount: accessoriesDummyData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 2/1.8
      ),
    );
  }
}

///products view
class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
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
    );
  }
}



