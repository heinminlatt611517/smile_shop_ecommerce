import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/promotion_bloc.dart';
import 'package:smile_shop/data/vos/promotion_vo.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/extensions.dart';

import '../utils/images.dart';
import '../widgets/svg_image_view.dart';
import 'package:smile_shop/localization/app_localizations.dart';

class PromotionPointPage extends StatelessWidget {
  const PromotionPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PromotionBloc(),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kSecondaryColor,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const SvgImageView(
                  imageName: kBackSvgIcon,
                  imageHeight: 26,
                  imageWidth: 26,
                ),
              ),
              const Spacer(),
              Text(AppLocalizations.of(context)?.promotionPoint ?? ''),
              const Spacer(),
              const Text(''),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: kSecondaryColor,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // const Text(
                    //   'You have',
                    //   style: TextStyle(fontSize: kTextRegular, color: Colors.black),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Consumer<PromotionBloc>(
                    //   builder: (context, bloc, child) => Text(
                    //     bloc.promotionDataVO?.currentPoint?.formatWithCommas() ?? "0",
                    //     style: const TextStyle(fontSize: 32, color: kBackgroundColor, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    Consumer<PromotionBloc>(
                        builder: (context, bloc, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "You Have",
                                  style: TextStyle(
                                      fontSize: kTextRegular,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  bloc.promotionDataVO?.currentPoint
                                          ?.formatWithCommas() ??
                                      "0",
                                  style: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )),

                    Text(
                      AppLocalizations.of(context)?.promotionPoints ?? '',
                      style: const TextStyle(
                          fontSize: kTextSmall,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Consumer<PromotionBloc>(
              builder: (context, bloc, child) => Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    CupertinoSlidingSegmentedControl(
                        children: {
                          0: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                AppLocalizations.of(context)?.incomePoints ??
                                    ''),
                          ),
                          1: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                AppLocalizations.of(context)?.outcomePoints ??
                                    ''),
                          ),
                        },
                        thumbColor: kSecondaryColor,
                        groupValue: bloc.selectedSegment,
                        onValueChanged: (value) {
                          bloc.onChangedSegmentedControl(value ?? 0);
                        }),
                    Expanded(
                      child: Selector<PromotionBloc, List<PromotionVO>>(
                        selector: (context, bloc) => bloc.promotions,
                        builder: (context, promotions, child) =>
                            Selector<PromotionBloc, bool>(
                          selector: (context, bloc) => bloc.isLoading,
                          builder: (context, isLoading, child) => Stack(
                            children: [
                              bloc.selectedSegment == 0
                                  ? _buildIncomeAndOutcomePointListView(
                                      promotions,
                                      AppLocalizations.of(context)
                                              ?.incomePoints ??
                                          '')
                                  : _buildIncomeAndOutcomePointListView(
                                      promotions,
                                      AppLocalizations.of(context)
                                              ?.outcomePoints ??
                                          ''),
                              // Loading view
                              if (isLoading)
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: kPrimaryColor,
                                  )),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildIncomeAndOutcomePointListView(
    List<PromotionVO> promotionList, String pointLabel) {
  return ListView.builder(
    shrinkWrap: true, // Ensures the list doesn't take up unnecessary space
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    itemCount: promotionList.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          _pointItemView(pointLabel, promotionList[index]),
          const Divider(),
        ],
      );
    },
  );
}

Widget _pointItemView(String pointLabel, PromotionVO promotionVO) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Column(
      children: [
        Row(
          children: [
            const Icon(Icons.attach_money),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pointLabel,
                        style: const TextStyle(fontSize: kTextSmall),
                      ),
                      Text(
                        pointLabel == 'Outcome Points'
                            ? '-${promotionVO.amount} Points'
                            : '+${promotionVO.amount} Points',
                        style: const TextStyle(
                            fontSize: kTextRegular2x, color: kSecondaryColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pointLabel == 'Outcome Points'
                            ? 'Discharge'
                            : 'Recharge',
                        style: const TextStyle(fontSize: kTextRegular2x),
                      ),
                      // Text(
                      //   DateFormat('MMM dd, yyyy/HH')
                      //       .format(DateTime.parse(DateTime.now().toString())),
                      //   style: const TextStyle(fontSize: kTextSmall),
                      // ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
}
