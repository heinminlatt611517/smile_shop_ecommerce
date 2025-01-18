import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/category_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/extensions.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

import '../data/dummy_data/accessories_dummy_data.dart';
import '../utils/colors.dart';

class CategoryVerticalIconWithLabelView extends StatelessWidget {
  final Color bgColor;
  final bool? isIconWithBg;
  final CategoryVO? categoryVO;
  const CategoryVerticalIconWithLabelView({super.key,required this.bgColor,this.isIconWithBg = false,this.categoryVO});

  @override
  Widget build(BuildContext context) {
    List<String> words = categoryVO?.name?.split(' ') ?? [];
    bool isSingleWord = words.length == 1;
    return Container(
      decoration: BoxDecoration(color: isIconWithBg == true ? null : bgColor,borderRadius: BorderRadius.circular(kMarginMedium)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(
              visible: isIconWithBg == true ? true : false,
              child: Container(
                  decoration: BoxDecoration(color: kSecondaryColor,borderRadius: BorderRadius.circular(kMarginMedium)),
                  child:  Padding(
                    padding:const EdgeInsets.all(10.0),
                    child: CachedNetworkImageView(imageHeight: 40, imageWidth: 40, imageUrl: categoryVO?.image ?? errorImageUrl)
                  ))),
          const SizedBox(height: 4,),
         isSingleWord ?
         Text(
           textAlign: TextAlign.center,
           categoryVO?.name ?? "",style:const TextStyle(color: Colors.black,fontSize:12
         ),) : Text(
            textAlign: TextAlign.center,
            "${categoryVO?.name?.getFirstWord()}\n${categoryVO?.name?.getLastWords()}",style:const TextStyle(color: Colors.black,fontSize:12
          ),)
        ],),
    );
  }
}
