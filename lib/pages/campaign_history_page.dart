import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/campaign_history_bloc.dart';
import 'package:smile_shop/list_items/campaign_history_list_item.dart';
import 'package:smile_shop/network/responses/campaign_history_response.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

import '../widgets/loading_view.dart';
import 'campaign_details_page.dart';

class CampaignHistoryPage extends StatelessWidget {
  const CampaignHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CampaignHistoryBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: const CustomAppBarView(
          title: 'History',
        ),
        body: Selector<CampaignHistoryBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (BuildContext context, isLoading, Widget? child) => Stack(
            children: [
              ///list view
              Selector<CampaignHistoryBloc, List<CampaignDataVO>>(
                selector: (context, bloc) => bloc.campaignHistories,
                builder:
                    (BuildContext context, campaignHistories, Widget? child) =>
                        ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: kMarginMedium2),
                            itemCount: campaignHistories.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const CampaignDetailsPage())),
                                  child: CampaignHistoryListItem(
                                    campaignDataVO: campaignHistories[index],
                                  ));
                            }),
              ),

              ///loading view
              if (isLoading)
                Container(
                  color: Colors.black12,
                  child: const Center(
                    child: LoadingView(
                      indicatorColor: kPrimaryColor,
                      indicator: Indicator.ballSpinFadeLoader,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
