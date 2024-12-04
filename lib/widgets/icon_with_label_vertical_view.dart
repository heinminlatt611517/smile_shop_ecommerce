import 'package:flutter/material.dart';
import 'package:smile_shop/utils/dimens.dart';

import '../data/dummy_data/accessories_dummy_data.dart';
import '../utils/colors.dart';

class IconWithLabelVerticalView extends StatelessWidget {
  final int? index;
  final Color bgColor;
  final bool? isIconWithBg;
  const IconWithLabelVerticalView({super.key,this.index,required this.bgColor,this.isIconWithBg = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: isIconWithBg == true ? null : bgColor,borderRadius: BorderRadius.circular(kMarginMedium)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(
              visible: isIconWithBg == true ? true : false,
              child: Container(
                  decoration: BoxDecoration(color: kSecondaryColor,borderRadius: BorderRadius.circular(kMarginMedium)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.shopping_bag_rounded,color: Colors.black,size: 30,),
                  ))),
          Visibility(
              visible: isIconWithBg == true ? false : true,
              child: const Icon(Icons.shopping_bag_rounded,color: kPrimaryColor,size: 30,)),
          const SizedBox(height: 4,),
          Text(
            textAlign: TextAlign.center,
            accessoriesDummyData[index ?? 0]['name'] ?? "",style:const TextStyle(color: Colors.black,fontSize:12
          ),)
        ],),
    );
  }
}
