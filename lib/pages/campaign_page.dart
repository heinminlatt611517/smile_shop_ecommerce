import 'package:flutter/material.dart';
import 'package:smile_shop/list_items/campaign_list_item.dart';
import 'package:smile_shop/pages/campaign_notification_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';

class CampaignPage extends StatelessWidget {
  const CampaignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
        toolbarHeight: 180,
        flexibleSpace: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.passthrough,
          children: [
            Image.asset(
              kCampaignBackgroundImage,
              fit: BoxFit.cover,
            ),
            Positioned(
                top: kMargin34 + 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: kMargin25),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(kBackIcon),
                      const Row(
                        children: [
                          Icon(Icons.notifications),
                          SizedBox(
                            width: kMarginMedium2,
                          ),
                          Icon(Icons.timelapse)
                        ],
                      ),
                    ],
                  ),
                )),
           const Positioned(
              bottom: kMargin34 + 15,
              child:  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('CAMPAIGN',style: TextStyle(fontSize: kTextRegular32,fontWeight: FontWeight.w600),),
                  Text('Enjoy the moment',style: TextStyle(fontSize: kTextRegular),),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(child: Stack(children: [
        Image.asset(kCampaignBackgroundImage,fit: BoxFit.fill,),
        Container(decoration:const BoxDecoration(
          color: kBackgroundColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(kMarginMedium3),topLeft: Radius.circular(kMarginMedium3))),
          child: ListView.builder(itemCount: 5,itemBuilder: (context,index){
            return InkWell(
              onTap: ()=> Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const CampaignNotificationPage())),
                child: const CampaignListItem());
          }),
        )
      ],),),
    );
  }
}
