import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/product_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/product_details_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

import '../utils/dimens.dart';

class TrendingProductListItemView extends StatelessWidget {
  final ProductVO? productVO;
  final String? imageUrl;

  const TrendingProductListItemView({super.key,this.productVO,this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  ProductDetailsPage(productId: productVO?.id.toString() ?? "",),
          ),
        );
      },
      child: Container(
        padding:const EdgeInsets.symmetric(vertical: kMarginMedium,horizontal: kMarginMedium),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImageView(
                  imageHeight: 120, imageWidth: double.infinity, imageUrl: productVO?.image ?? errorImageUrl),
            ),
            const SizedBox(height: 10,),
            const Text(
              'Hair Accessories',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: kTextRegular2x),
            ),
            const SizedBox(height: 10,),
            const Text(
              'Beauty Category',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: kTextRegular,
                  color: Colors.grey),
            ),
            const SizedBox(height: 10,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ks 3000',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kTextRegular2x,
                      color: kPrimaryColor),
                ),
                Text(
                  '100 pt',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: kTextRegular,
                      color: kSecondaryColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
