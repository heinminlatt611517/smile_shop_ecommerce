import 'package:flutter/material.dart';
import 'package:smile_shop/list_items/campaign_history_list_item.dart';
import 'package:smile_shop/list_items/my_team_list_item.dart';
import 'package:smile_shop/pages/campaign_description_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

class MyTeamPage extends StatelessWidget {
  const MyTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const CustomAppBarView(
        title: 'My Team',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2,vertical: kMarginMedium2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2,),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(kMargin10)),
                child: Row(children: [
                  Container(height: 60,width: 60,decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.black,width: 2))
                    ,child: ClipRRect(
                      borderRadius: BorderRadius.circular(kMarginXLarge),
                        child: const CachedNetworkImageView(imageHeight: 60, imageWidth: 60, imageUrl: 'https://static-cse.canva.com/blob/1833390/1600w-B-cRyoh7b98.jpg')),),
                  const SizedBox(width: kMargin30,),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Jonny (000000)'),
                      SizedBox(height: kMargin10,),
                      Text('09888888888'),
                  ],)
                ],),
              ),
              const SizedBox(height: 40,),
              const Text('Your members'),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: kMarginMedium2),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const CampaignDescriptionPage())),
                        child: const MyTeamListItem());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
