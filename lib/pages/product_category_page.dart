import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import '../data/dummy_data/trending_products_dummy_data.dart';
import '../list_items/trending_product_list_item_view.dart';
import '../network/api_constants.dart';
import '../utils/strings.dart';

class ProductCategoryPage extends StatelessWidget {
  const ProductCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(kMarginMedium2),
        child: CustomScrollView(
          slivers: [
            ///spacer
            SliverToBoxAdapter(child: SizedBox(height: kMarginXXLarge,)),

           ///search bar with back arrow view
            SliverToBoxAdapter(child: SearchBarWithBackArrowView(),),

            ///spacer
            SliverToBoxAdapter(child: SizedBox(height: kMarginLarge,)),

            ///product view
            SliverToBoxAdapter(child: ProductsView(),),


          ],
        ),
      )
    );
  }
}

///search bar with back arrow view
class SearchBarWithBackArrowView extends StatelessWidget {
  const SearchBarWithBackArrowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.keyboard_backspace)),
        const SizedBox(
          width: kMarginMedium2,
        ),
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
      ],
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





