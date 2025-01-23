import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../utils/images.dart';
import 'dash_line_vertical_painter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DeliveryStepperView extends StatefulWidget {
  const DeliveryStepperView({super.key});

  @override
  State<DeliveryStepperView> createState() => _DeliveryStepperViewState();
}

class _DeliveryStepperViewState extends State<DeliveryStepperView> {
  bool isEditing = false;

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
      child: ListView.builder(
        itemCount: userInfoList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext content, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(kMarginMedium),
                          decoration: const BoxDecoration(
                              color: kPrimaryColor,
                              shape: BoxShape.circle),
                          child: Center(child: userInfoList[index]['icon']),
                        ),
                        if (index != userInfoList.length - 1)
                          SizedBox(
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: CustomPaint(
                                size: const Size(1, double.infinity),
                                painter: DashedLineVerticalPainter(),
                              ),
                            ),
                          ),
                      ],
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: kMarginMedium,left: kMarginMedium),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userInfoList[index]['title'],
                              maxLines: null,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'Nov 30, 2024',
                              maxLines: null,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
