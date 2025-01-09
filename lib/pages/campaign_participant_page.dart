import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/campaign_participant_bloc.dart';
import 'package:smile_shop/list_items/participant_list_item.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import 'package:smile_shop/widgets/loading_view.dart';

class CampaignParticipantPage extends StatelessWidget {
  const CampaignParticipantPage({super.key, required this.campaignId});

  final int campaignId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CampaignParticipantBloc(campaignId),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: const CustomAppBarView(
          title: 'Participants',
        ),
        body: Selector<CampaignParticipantBloc, bool?>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (_, loading, child) => loading == true
              ? const LoadingView(
                  indicator: Indicator.ballSpinFadeLoader, indicatorColor: kPrimaryColor)
              : Consumer<CampaignParticipantBloc>(
                  builder: (context, bloc, child) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMarginMedium2, vertical: kMarginMedium2),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          const Text('Participants in this campaign'),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  vertical: kMarginMedium2),
                              itemCount: bloc.participantLists.length,
                              itemBuilder: (context, index) {
                                return ParticipantListItem(
                                    participantVo:
                                        bloc.participantLists[index]);
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
