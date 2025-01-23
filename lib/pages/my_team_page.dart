import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/my_team_bloc.dart';
import 'package:smile_shop/list_items/my_team_list_item.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

import '../widgets/loading_view.dart';
import 'campaign_details_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MyTeamPage extends StatelessWidget {
  const MyTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyTeamBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar:  CustomAppBarView(
          title: AppLocalizations.of(context)?.myTeam ?? '',
        ),
        body: Selector<MyTeamBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, loading, child) => loading == true
              ? const LoadingView(
                  indicator: Indicator.ballSpinFadeLoader,
                  indicatorColor: kPrimaryColor)
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMarginMedium2, vertical: kMarginMedium2),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Consumer<MyTeamBloc>(
                    builder: (context, bloc, child) =>
                           Container(
                            height: 100,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: kMarginMedium2,
                            ),
                            decoration: BoxDecoration(
                                color: kSecondaryColor,
                                borderRadius: BorderRadius.circular(kMargin10)),
                            child: Row(
                              children: [
                                Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.black, width: 2)),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(kMarginXLarge),
                                        child: CachedNetworkImageView(
                                            imageHeight: 60,
                                            imageWidth: 60,
                                            imageUrl:
                                                bloc.userProfile?.profileImage ?? errorImageUrl)),

                                ),
                                const SizedBox(
                                  width: kMargin30,
                                ),
                                 Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${bloc.userProfile?.name}'),
                                    const SizedBox(
                                      height: kMargin10,
                                    ),
                                    Text(bloc.userProfile?.phone ??""),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(AppLocalizations.of(context)?.yourMembers ?? ''),
                        Consumer<MyTeamBloc>(
                          builder: (context, bloc, child) => ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  vertical: kMarginMedium2),
                              itemCount: bloc.myTeams.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const CampaignDetailsPage())),
                                    child: MyTeamListItem(
                                      myTeamVO: bloc.myTeams[index],
                                    ));
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
