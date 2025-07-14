import 'package:flutter/material.dart';
import 'package:smile_shop/data/vos/delivery_history_vo.dart';
import 'package:smile_shop/utils/extensions.dart';

import '../utils/dimens.dart';

class DeliveryStepperView extends StatefulWidget {
  final List<DeliveryHistoryVO>? deliveryList;

  const DeliveryStepperView({super.key, required this.deliveryList});

  @override
  State<DeliveryStepperView> createState() => _DeliveryStepperViewState();
}

class _DeliveryStepperViewState extends State<DeliveryStepperView> {
  bool isEditing = false;

  // Map<String, Widget> getIconAccordingToDeliveryStatus = {
  //   'on going': const Icon(
  //     Icons.local_shipping,
  //     color: Colors.white,
  //     size: 40,
  //   ),
  //   'start delivery': Image.asset(
  //     kBoxIcon,
  //     fit: BoxFit.contain,
  //     height: 20,
  //     width: 20,
  //   ),
  //   'delivered': const Icon(
  //     Icons.store,
  //     size: 40,
  //     color: Colors.white,
  //   ),
  // };

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.deliveryList?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext content, int index) {
        DeliveryHistoryVO vo =
            widget.deliveryList?[index] ?? DeliveryHistoryVO();

        return Row(
          children: [
            const SizedBox(
              width: kMarginMedium,
            ),
            const Text("•", style: TextStyle(fontSize: kTextSmall),),
            const SizedBox(
              width: kMarginMedium,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vo.deliveryStatus ?? "",
                    style: const TextStyle(
                        fontSize: kTextRegular2x, fontWeight: FontWeight.w400),
                  ),
                  Visibility(
                    visible: (vo.comment != null) &&
                        (vo.comment?.isNotEmpty ?? false),
                    child: Text(
                      vo.comment ?? "",
                      style: const TextStyle(
                          fontSize: kTextSmall, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: kMarginMedium,
            ),
            Text(
              (DateTime.tryParse(vo.deliveryDate ?? '') ?? DateTime.now())
                  .format(formatType: "MMM d, yyyy")
                  .toString(),
              style: const TextStyle(
                  fontSize: kTextRegular2x,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: kMarginMedium2,
        );
      },
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