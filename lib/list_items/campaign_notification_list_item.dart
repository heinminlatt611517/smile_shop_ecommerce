
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';

class CampaignNotificationListItem extends StatelessWidget {
  const CampaignNotificationListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kMarginMedium),
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      height: 70,width: double.infinity,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(kMargin6 - 2)),
    child:const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Icon(CupertinoIcons.gift,color: kPrimaryColor,),
      SizedBox(width: kMargin30 - 2,),
      Expanded(child: Text('The campaign you participate is complete and get your reward.'))
    ],),
    );
  }
}
