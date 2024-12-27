import 'package:flutter/material.dart';
import 'package:smile_shop/list_items/campaign_history_list_item.dart';
import 'package:smile_shop/pages/campaign_description_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

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
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const CampaignDescriptionPage())),
            child: const CampaignHistoryListItem());
      }),
    );
  }
}
