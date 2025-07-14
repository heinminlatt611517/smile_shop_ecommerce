import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smile_shop/data/vos/campaign_history_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/extensions.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

class CampaignHistoryListItem extends StatelessWidget {
  final CampaignHistoryVo? campaignDataVO;
  const CampaignHistoryListItem({super.key, required this.campaignDataVO});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Banner(
        location: BannerLocation.topEnd,
        message: campaignDataVO?.isWinner ?? false ? "Winner" : "Joined",
        color:
            campaignDataVO?.isWinner ?? false ? kPrimaryColor : Colors.grey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: kMarginMedium2, vertical: kMarginMedium2),
          // margin: const EdgeInsets.symmetric(
          //     horizontal: kMarginMedium2, vertical: kMarginMedium),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kMargin10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(kMargin10),
                    child: CachedNetworkImageView(
                        imageHeight: 80,
                        imageWidth: 80,
                        imageUrl: campaignDataVO?.campaign?.product?.image ??
                            errorImageUrl),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaignDataVO?.campaign?.product?.name ?? "",
                        style: const TextStyle(
                            fontSize: kTextRegular2x,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: kMarginSmall,
                      ),
                      Text(
                        "Campaign ID ${campaignDataVO?.campaignId ?? ""} | Round ${campaignDataVO?.prizeRank ?? "1"}",
                        style: const TextStyle(
                            fontSize: kTextRegular,
                            fontWeight: FontWeight.w600),
                      ),
                      if (campaignDataVO?.isWinner ?? false)
                        Padding(
                          padding: const EdgeInsets.only(top: kMarginSmall),
                          child: Text(
                              'You won the price at ${DateTime.parse(campaignDataVO?.updatedAt ?? "").format(formatType: "dd MMMM yyyy")}',
                              style: const TextStyle(
                                fontSize: kTextRegular,
                              )),
                        ),
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: kMarginMedium,
              ),
              Text(
                campaignDataVO!.campaign?.description ?? "",
                style: const TextStyle(
                    fontSize: kTextRegular, fontWeight: FontWeight.w600),
              ),
              if (campaignDataVO?.address != null) const Divider(),
              if (campaignDataVO?.address != null)
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.location_solid,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
                      width: kMarginMedium3 + 3,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              campaignDataVO?.address?.name ?? "",
                              style: const TextStyle(fontSize: kTextRegular),
                            ),
                            Text(
                              campaignDataVO?.address?.phone ?? "",
                              style: const TextStyle(
                                  fontSize: kTextRegular, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: kMargin12 - 1,
                        ),
                        Text(
                          campaignDataVO?.address?.address ?? "",
                          style: const TextStyle(fontSize: kTextRegular),
                        ),
                      ],
                    ))
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
