import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/campaign_detail_bloc.dart';
import 'package:smile_shop/pages/campaign_participant_page.dart';
import 'package:smile_shop/pages/my_team_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';
import 'package:smile_shop/widgets/common_dialog.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';
import 'package:smile_shop/widgets/error_dialog_view.dart';
import 'package:smile_shop/widgets/loading_view.dart';
import 'package:smile_shop/localization/app_localizations.dart';

class CampaignDetailsPage extends StatelessWidget {
  const CampaignDetailsPage({super.key, this.campaignId});
  final int? campaignId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CampaignDetailBloc(campaignId),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: const CustomAppBarView(
          title: '',
        ),
        body: Selector<CampaignDetailBloc, bool?>(
          selector: (_, bloc) => bloc.isLoading,
          builder: (context, loading, child) => loading == true
              ? const LoadingView(
                  indicator: Indicator.ballSpinFadeLoader,
                  indicatorColor: kPrimaryColor)
              : Consumer<CampaignDetailBloc>(
                  builder: (context, bloc, child) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMarginMedium2, vertical: kMarginMedium2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImageView(
                              imageHeight: 200,
                              imageWidth: double.infinity,
                              imageUrl:
                                  bloc.campaignDetail?.product?.image ?? ''),
                          const SizedBox(
                            height: kMargin30,
                          ),
                          Text(
                            bloc.campaignDetail?.product?.name ?? '',
                            style: const TextStyle(
                                fontSize: kTextRegular2x,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: kMargin30,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kMargin25),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.participants,
                                  style:
                                      const TextStyle(fontSize: kTextRegular),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                CampaignParticipantPage(
                                                  campaignId:
                                                      bloc.campaignDetail?.id ??
                                                          0,
                                                )));
                                  },
                                  child: ImageStack(
                                    imageList: bloc.images.length > 3
                                        ? bloc.images.take(3).toList()
                                        : bloc.images,
                                    imageRadius: 30,
                                    imageCount: 3,
                                    imageBorderWidth: 3,
                                    totalCount: bloc.campaignDetail?.joinedUsers
                                            ?.length ??
                                        0,
                                    backgroundColor: Colors.transparent,
                                    imageBorderColor: Colors.orangeAccent,
                                    extraCountBorderColor: Colors.transparent,
                                  ),
                                ),
                                const SizedBox(
                                  width: kMarginSmall,
                                ),
                                Visibility(
                                    visible: (bloc.campaignDetail?.joinedUsers
                                                ?.length ??
                                            0) >
                                        3,
                                    child: Text(
                                      '+${bloc.campaignDetail?.joinedUsers?.length ?? 0 - 3} others',
                                      style: const TextStyle(
                                          fontSize: kTextRegular,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: kMargin30,
                          ),
                          Text(
                            AppLocalizations.of(context)!.description,
                            style: const TextStyle(
                                fontSize: kTextRegular2x,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: kMarginMedium2,
                          ),
                          Text(bloc.campaignDetail?.description ?? '')
                        ],
                      ),
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: Consumer<CampaignDetailBloc>(
          builder: (context, bloc, child) => Container(
            padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  offset: Offset(5, 0), blurRadius: 10, color: Colors.grey)
            ]),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${bloc.campaignDetail?.price} points',
                    style: const TextStyle(
                        fontSize: kTextRegular2x,
                        fontWeight: FontWeight.w500,
                        color: kPrimaryColor),
                  ),
                  InkWell(
                    onTap: () => bloc.joinCampaign(context).then((_) {
                      bloc.getCampaignDetail();
                    }).catchError((error) {
                      showCommonDialog(
                          context: context,
                          dialogWidget:
                              ErrorDialogView(errorMessage: error.toString()));
                    }),
                    child: Container(
                      width: 120,
                      height: 32,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(kMargin6 - 2)),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.joinNow,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModalSheet(BuildContext context) {
    return Container(
      height: 256,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kMarginMedium3),
            topRight: Radius.circular(kMarginMedium3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: kMarginMedium2,
                    ),
                    child: Icon(Icons.close),
                  ))
            ],
          ),
          const Text(
            'Payment',
            style: TextStyle(
                fontSize: kTextRegular2x, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: kMarginMedium3,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kMarginXLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your current smile points',
                  style: TextStyle(fontSize: kTextSmall),
                ),
                Text(
                  '1500000 Points',
                  style: TextStyle(fontSize: kTextSmall, color: kPrimaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: kMarginMedium2,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kMarginXLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Points used for this campaign',
                  style: TextStyle(fontSize: kTextSmall),
                ),
                Text(
                  '1500000 Points',
                  style: TextStyle(fontSize: kTextSmall, color: kPrimaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: kMargin12,
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kMarginXLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Remaining Points',
                  style: TextStyle(fontSize: kTextSmall),
                ),
                Text(
                  '1500000 Points',
                  style: TextStyle(fontSize: kTextSmall, color: kPrimaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: kMargin12,
          ),
          InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const MyTeamPage())),
            child: Container(
              height: 39,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kMargin6 - 2),
                  color: kPrimaryColor),
              child: const Center(
                child: Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
