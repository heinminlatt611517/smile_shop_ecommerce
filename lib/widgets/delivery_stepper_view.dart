import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smile_shop/data/vos/delivery_history_vo.dart';
import 'package:smile_shop/utils/extensions.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../utils/images.dart';
import 'dash_line_vertical_painter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeliveryStepperView extends StatefulWidget {
  final List<DeliveryHistoryVO>? deliveryList;

  const DeliveryStepperView({super.key, required this.deliveryList});

  @override
  State<DeliveryStepperView> createState() => _DeliveryStepperViewState();
}

class _DeliveryStepperViewState extends State<DeliveryStepperView> {
  bool isEditing = false;

  Map<String, Widget> getIconAccordingToDeliveryStatus = {
    'on going': const Icon(
      Icons.local_shipping,
      color: Colors.white,
      size: 40,
    ),
    'start delivery': Image.asset(
      kBoxIcon,
      fit: BoxFit.contain,
      height: 20,
      width: 20,
    ),
    'delivered': const Icon(
      Icons.store,
      size: 40,
      color: Colors.white,
    ),
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> userInfoList = [
      {
        'icon': Image.asset(
          kBoxIcon,
          fit: BoxFit.contain,
          height: 20,
          width: 20,
        ),
        'title': AppLocalizations.of(context)!.startDelivery,
      },
      {
        'icon': Image.asset(
          kTransitIcon,
          fit: BoxFit.contain,
          height: 20,
          width: 20,
        ),
        'title': AppLocalizations.of(context)!.inTransit,
      },
      {
        'icon': Image.asset(
          kCarIcon,
          fit: BoxFit.contain,
          height: 20,
          width: 20,
        ),
        'title': AppLocalizations.of(context)!.toReceive,
      },
    ];
    return SingleChildScrollView(
      child: ListView.separated(
        itemCount: widget.deliveryList?.length ?? 0,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SizedBox(
              height: 50,
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomPaint(
                  size: const Size(1, double.infinity),
                  painter: DashedLineVerticalPainter(),
                ),
              ),
            ),
          );
        },
        itemBuilder: (BuildContext content, int index) {
          DeliveryHistoryVO vo = widget.deliveryList?[index] ?? DeliveryHistoryVO();
          print("STATUS ===============> ${vo.deliveryStatus}");
          Widget icon = getIconAccordingToDeliveryStatus[(vo.deliveryStatus ?? '').toLowerCase()] ??
              const Icon(
                Icons.local_shipping,
                color: Colors.white,
              );
          return Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                child: icon,
              ),
              const SizedBox(
                width: kMarginMedium,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vo.deliveryStatus ?? "",
                      style: const TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w400),
                    ),
                    Visibility(
                      visible: (vo.comment != null) && (vo.comment?.isNotEmpty ?? false),
                      child: Text(
                        vo.comment ?? "",
                        style: const TextStyle(fontSize: kTextSmall, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: kMarginMedium,
              ),
              Text(
                (DateTime.tryParse(vo.deliveryDate ?? '') ?? DateTime.now()).format(formatType: "MMM d, yyyy").toString(),
                style: const TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.w400, color: Colors.grey),
              ),
            ],
          );
        },
      ),
    );
  }
}


// SizedBox(
//                             height: 50,
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: CustomPaint(
//                                 size: const Size(1, double.infinity),
//                                 painter: DashedLineVerticalPainter(),
//                               ),
//                             ),
//                           ),