import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

class CampaignListItem extends StatelessWidget {
  const CampaignListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 170,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      margin: const EdgeInsets.symmetric(horizontal: kMargin25,vertical: kMarginMedium3 - 1),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(kMargin10)),
      child: Center(
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(kMargin10),
            child: CachedNetworkImageView(imageHeight: 100, imageWidth: 100,imageUrl: 'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDI0LTAyL2ZyZWVpbWFnZXNjb21wYW55X2FfcGhvdG9fb2ZfaGFuZ2luZ19nbG93aW5nX3JhbWFkYW5fY2VsZWJyYXRpb180YjQ4YWY1NC1jNzE5LTRlMjQtOGYwNy1jN2NjMTI1NWY5NjVfMS5qcGc.jpg'),),
          const SizedBox(width: 17,),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text('Product Name',style: TextStyle(fontSize: kTextRegular2x,fontWeight: FontWeight.w600),),
              const SizedBox(height: kMarginMedium3,),
              const Text('5000 Ks',style: TextStyle(fontSize: kTextRegular3x,fontWeight: FontWeight.w500,color: kPrimaryColor),),
              const SizedBox(height: kMarginMedium3,),
              Row(children: [
                Container(width: 80,height: 28,decoration: BoxDecoration(color: kPrimaryColor,borderRadius: BorderRadius.circular(kMargin6 - 2)),
                child: const Center(child: Text('Join Now',style: TextStyle(fontSize: kTextRegular,color: kBackgroundColor),),),
                ),
                const SizedBox(width: kMargin10,),

              ],)
          ],))
        ],),
      ),
    );
  }
}
