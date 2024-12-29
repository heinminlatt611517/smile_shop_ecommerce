import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

class CampaignHistoryListItem extends StatelessWidget {
  const CampaignHistoryListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2,vertical: kMarginMedium2),
      margin: const EdgeInsets.symmetric(horizontal: kMargin12 + 3,vertical: kMarginMedium14 + 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kMargin10)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(kMargin10),
              child:const CachedNetworkImageView(imageHeight: 80, imageWidth: 80,imageUrl: 'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDI0LTAyL2ZyZWVpbWFnZXNjb21wYW55X2FfcGhvdG9fb2ZfaGFuZ2luZ19nbG93aW5nX3JhbWFkYW5fY2VsZWJyYXRpb180YjQ4YWY1NC1jNzE5LTRlMjQtOGYwNy1jN2NjMTI1NWY5NjVfMS5qcGc.jpg'),),
            const SizedBox(width: 17,),
            const Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('MIELLE Rosemary Mint',style: TextStyle(fontSize: kTextRegular2x,fontWeight: FontWeight.w600),),
                 SizedBox(height: kMarginMedium3,),
                 Text('You won the price at...',style: TextStyle(fontSize: kTextRegular,)),

              ],))
          ],),
          const SizedBox(height: 27,),
          const Divider(),
          const SizedBox(height: kMarginMedium3 - 1,),
          const Row(children: [
            Icon(CupertinoIcons.location_solid,color: kPrimaryColor,),
            SizedBox(width: kMarginMedium3 + 3,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Customer name',style: TextStyle(fontSize: kTextRegular),),
                  Text('098888888888',style: TextStyle(fontSize: kTextRegular,color: Colors.grey),)
              ],),
                SizedBox(height: kMargin12 - 1,),
                Text('No 34, Baho Road, Hlaing Township, Yangon',style: TextStyle(fontSize: kTextRegular),),
            ],))
          ],)
        ],
      ),
    );
  }
}
