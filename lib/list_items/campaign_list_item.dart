import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_stack/image_stack.dart';
import 'package:smile_shop/data/vos/campaign_vo.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/cached_network_image_view.dart';

class CampaignListItem extends StatelessWidget {
  const CampaignListItem({super.key, this.campaignData});

  final CampaignVo? campaignData;

  @override
  Widget build(BuildContext context) {
    List<String> images = campaignData?.joinedUsers?.isNotEmpty ?? true
        ? campaignData?.joinedUsers
                ?.map((e) => e.profileImage ?? "")
                .toList() ??
            []
        : [];
    return Container(
      height: 170,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      margin: const EdgeInsets.symmetric(
          horizontal: kMargin25, vertical: kMarginMedium3 - 1),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(kMargin10)),
      child: Center(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(kMargin10),
              child: CachedNetworkImageView(
                  imageHeight: 100,
                  imageWidth: 100,
                  imageUrl: campaignData?.product?.image ?? ''),
            ),
            const SizedBox(
              width: 17,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaignData?.product?.name ?? '',
                  style: const TextStyle(
                      fontSize: kTextRegular2x, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: kMarginMedium3,
                ),
                Text(
                  '${campaignData?.price} Ks',
                  style: const TextStyle(
                      fontSize: kTextRegular3x,
                      fontWeight: FontWeight.w500,
                      color: kPrimaryColor),
                ),
                const SizedBox(
                  height: kMarginMedium3,
                ),
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 28,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(kMargin6 - 2)),
                      child: const Center(
                        child: Text(
                          'Join Now',
                          style: TextStyle(
                              fontSize: kTextRegular, color: kBackgroundColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: kMargin10,
                    ),
                    ImageStack(
                      imageList: images.length > 3 ? images.take(3).toList() : images,
                      imageRadius: 30,
                      imageCount: 3,
                      imageBorderWidth: 3,
                      totalCount: campaignData?.joinedUsers?.length ?? 0,
                      backgroundColor: Colors.transparent,
                      imageBorderColor: Colors.orangeAccent,
                      extraCountBorderColor: Colors.transparent,
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
