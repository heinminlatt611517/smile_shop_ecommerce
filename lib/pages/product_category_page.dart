import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/product_category_bloc.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import '../data/vos/product_response_data_vo.dart';
import '../list_items/trending_product_list_item_view.dart';
import '../utils/images.dart';
import '../utils/strings.dart';

class ProductCategoryPage extends StatelessWidget {
  final String? categoryName;
  final int? subCategoryId;
  const ProductCategoryPage({super.key,required this.categoryName,required this.subCategoryId});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context)=>ProductCategoryBloc(subCategoryId ?? 0),
      child:   Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: CustomAppBarView(title: categoryName),
        body: const Padding(
          padding:EdgeInsets.all(kMarginMedium2),
          child: CustomScrollView(
            slivers: [

             ///search bar with back arrow view
              //SliverToBoxAdapter(child: SearchBarWithBackArrowView(),),
      
              ///spacer
              //SliverToBoxAdapter(child: SizedBox(height: kMarginLarge,)),
      
              ///product view
              SliverToBoxAdapter(child: ProductsView(),),
      
      
            ],
          ),
        )
      ),
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
   return Selector<ProductCategoryBloc, List<ProductVO>>(
        selector: (context, bloc) => bloc.products,
        builder: (context, products, child) {
          return products.isEmpty
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return TrendingProductListItemView(
                productVO: products[index],
              );
            },
            itemCount: products.length,
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





