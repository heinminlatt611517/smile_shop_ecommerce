import 'package:flutter/material.dart';
import 'package:smile_shop/list_items/campaign_history_list_item.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

import 'campaign_details_page.dart';

class CampaignHistoryPage extends StatelessWidget {
  const CampaignHistoryPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const CustomAppBarView(title: 'History',),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: kMarginMedium2),
          itemCount: 3,itemBuilder: (context,index){
        return InkWell(
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const CampaignDetailsPage())),
            child: const CampaignHistoryListItem());
      }),
    );
  }
}
