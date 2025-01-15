import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/campaign_participant_vo.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/utils/dimens.dart';

import '../widgets/cached_network_image_view.dart';

class ParticipantListItem extends StatelessWidget {
  const ParticipantListItem({super.key, required this.participantVo});

  final CampaignParticipantVo participantVo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kMarginMedium3),
      // padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kMargin6 - 2)),
      child: Stack(alignment: Alignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMarginMedium2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(kMarginXLarge),
                    child: CachedNetworkImageView(
                        imageHeight: 40,
                        imageWidth: 40,
                        imageUrl: participantVo.profileImage ?? errorImageUrl)),
              ),
              Text(participantVo.name ?? ''),
              Text(participantVo.phone?.replaceRange(3, 8, '****') ?? '')
            ],
          ),
        ),
        Positioned(
          left: 0,
          child: Container(
            width: 8,
            height: 70,
            decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4))),
          ),
        )
      ]),
    );
  }
}
