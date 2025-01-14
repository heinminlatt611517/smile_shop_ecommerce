import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/network/responses/campaign_history_response.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

class CampaignHistoryListItem extends StatelessWidget {
  final CampaignDataVO? campaignDataVO;
  const CampaignHistoryListItem({super.key,required this.campaignDataVO});

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
              child: CachedNetworkImageView(imageHeight: 80, imageWidth: 80,imageUrl:campaignDataVO?.campaignProduct?.product?.image ?? errorImageUrl),),
            const SizedBox(width: 17,),
             Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(campaignDataVO?.campaignProduct?.product?.name ?? "",style:const TextStyle(fontSize: kTextRegular2x,fontWeight: FontWeight.w600),),
                 const SizedBox(height: kMarginMedium3,),
                 Text('You won the price at.. ${campaignDataVO?.campaignProduct?.product?.createdAt}',style:const TextStyle(fontSize: kTextRegular,)),

              ],))
          ],),
          const SizedBox(height: 27,),
          const Divider(),
          const SizedBox(height: kMarginMedium3 - 1,),
           Row(children: [
            const Icon(CupertinoIcons.location_solid,color: kPrimaryColor,),
            const SizedBox(width: kMarginMedium3 + 3,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(campaignDataVO?.address?.name ?? "",style:const TextStyle(fontSize: kTextRegular),),
                  Text(campaignDataVO?.address?.phone?? "",style:const TextStyle(fontSize: kTextRegular,color: Colors.grey),)
              ],),
                const SizedBox(height: kMargin12 - 1,),
                Text(campaignDataVO?.address?.address ?? "",style:const TextStyle(fontSize: kTextRegular),),
            ],))
          ],)
        ],
      ),
    );
  }
}
