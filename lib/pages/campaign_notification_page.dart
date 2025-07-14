import 'package:flutter/material.dart';
import 'package:smile_shop/list_items/campaign_notification_list_item.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import 'package:smile_shop/localization/app_localizations.dart';

class CampaignNotificationPage extends StatelessWidget {
  const CampaignNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CustomAppBarView(
        title: AppLocalizations.of(context)!.campaignNotification,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(
              horizontal: kMarginMedium2, vertical: kMarginMedium),
          itemCount: 3,
          itemBuilder: (context, index) {
            return const CampaignNotificationListItem();
          }),
    );
  }
}
