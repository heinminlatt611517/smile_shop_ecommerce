import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/campaign_bloc.dart';
import 'package:smile_shop/list_items/campaign_list_item.dart';
import 'package:smile_shop/pages/campaign_history_page.dart';
import 'package:smile_shop/pages/campaign_notification_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'campaign_details_page.dart';

class CampaignPage extends StatelessWidget {
  const CampaignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> CampaignBloc(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
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
                  top: kMargin34 + 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: kMargin25),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: ()=> Navigator.of(context).pop(),
                            child: SvgPicture.asset(kBackSvgIcon, width: 26, height: 26,)),
                         Row(
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CampaignNotificationPage(),),

                                );
                              },
                                child:const Icon(Icons.notifications,color: kPrimaryColor,)),
                            const SizedBox(
                              width: kMarginMedium2,
                            ),
                            InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CampaignHistoryPage()),
                                  );
                                },
                                child: const Icon(Icons.history,color: kPrimaryColor,))
                          ],
                        ),
                      ],
                    ),
                  )),
              Positioned(
                bottom: kMargin34 + 15,
                child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context)!.campaign.toUpperCase(),style:const TextStyle(fontSize: 36,fontWeight: FontWeight.w600),),
                    Text(AppLocalizations.of(context)!.enjoyTheMoment,style:const TextStyle(fontSize: kTextRegular),),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Selector<CampaignBloc,bool?>(
          selector: (context,bloc) => bloc.isLoading,
           builder: (_,loading,child) => loading == true ? const LoadingView(indicator: Indicator.ballSpinFadeLoader, indicatorColor: kPrimaryColor) :
           Consumer<CampaignBloc>(
            builder: (context,bloc,child) =>
             SizedBox(child: Stack(children: [
              Image.asset(kCampaignBackgroundImage,fit: BoxFit.fill,),
              Container(decoration:const BoxDecoration(
                color: kBackgroundColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(kMarginMedium3),topLeft: Radius.circular(kMarginMedium3))),
                child: ListView.builder(itemCount: bloc.campaignLists.length,itemBuilder: (context,index){
                  return InkWell(
                    onTap: ()=> Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => CampaignDetailsPage(campaignId: bloc.campaignLists[index].id,))),
                      child: CampaignListItem(campaignData: bloc.campaignLists[index],));
                }),
              )
            ],),),
          ),
        ),
      ),
    );
  }
}
