import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/daily_check_in_bloc.dart';
import 'package:smile_shop/data/vos/checkIn_vo.dart';
import 'package:smile_shop/list_items/daily_checkin_list_item.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../utils/colors.dart';
import '../widgets/loading_view.dart';

class DailyCheckInPage extends StatelessWidget {
  const DailyCheckInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DailyCheckInBloc(),
      child: Scaffold(
        body: Selector<DailyCheckInBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) =>
              Stack(
                children: [

                  ///body view
                  Selector<DailyCheckInBloc, CheckInVO?>(
                    selector: (context, bloc) => bloc.checkInVO,
                    builder: (context, checkInVO, child) =>
                    checkInVO != null
                        ? Scaffold(
                      backgroundColor: const Color(0xffF7E1C5),
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        toolbarHeight:400,
                        surfaceTintColor: Colors.transparent,
                        flexibleSpace: Stack(children: [
                          SizedBox(
                              width: double.infinity,
                              child: Image.asset(
                                kDailyCheckInImage,
                                fit: BoxFit.fill,
                              )),
                          Column(
                            spacing: kMargin10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: kMarginMedium2),
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.pop(context),
                                        child: Image.asset(
                                          kBackIcon,
                                          fit: BoxFit.contain,
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                       Text(
                                        AppLocalizations.of(context)!.dailyCheckIn,
                                        style:const TextStyle(
                                            fontSize: kTextRegular2x,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      )
                                    ]),
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: kMargin25),
                                    height: kMargin25,
                                    width: kMargin50 + 5,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        color: kPrimaryColor),
                                    child: const Center(
                                      child: Text(
                                        'Rules',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                               Text(AppLocalizations.of(context)!.totalCount),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    checkInVO.currentCheckInDay.toString() ==
                                        "null" ? "0" : checkInVO
                                        .currentCheckInDay.toString(),
                                    style: const TextStyle(
                                        fontSize: kMarginXLarge,
                                        color: kPrimaryColor),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Days',
                                      style: TextStyle(fontSize: kTextSmall),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 180,
                                height: 170,
                                child:
                                Image.asset(kDailyCheckInCalendarImage),
                              ),
                              Consumer<DailyCheckInBloc>(
                                builder: (context, bloc, child) =>
                                    InkWell(
                                      onTap: () {
                                        bloc.onTapCheckIn(context);
                                      },
                                      child: Container(
                                        height: 36,
                                        width: 118,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            color: kPrimaryColor),
                                        child:  Center(
                                          child: Text(
                                            AppLocalizations.of(context)!.checkIn,
                                            style:const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                              )
                            ],
                          )
                        ]),
                      ),
                      body: Container(
                        decoration: const BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(kMarginLarge),
                                topRight: Radius.circular(kMarginLarge))),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: kMargin34,
                              ),
                               Padding(
                                padding:const EdgeInsets.symmetric(
                                    horizontal: kMargin25),
                                child: Text(AppLocalizations.of(context)!.checkInCount),
                              ),
                              const SizedBox(
                                height: kMargin34 - 4,
                              ),
                              Expanded(
                                child: GridView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kMargin25,
                                        vertical: kMargin25),
                                    itemCount: _getItemCount(checkInVO),
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5,
                                        mainAxisExtent: 80,
                                        mainAxisSpacing: 40,
                                        crossAxisSpacing: 10),
                                    itemBuilder: (context, index) {
                                      Color bgColor = checkInVO
                                          .currentCheckInDay.toString() ==
                                          "null"
                                          ? Colors.grey
                                          : (index < int.parse(
                                          checkInVO.currentCheckInDay
                                              .toString()))
                                          ? kPrimaryColor
                                          : Colors.grey;

                                      return DailyCheckInListItem(
                                        bgColor: bgColor,
                                        day: index + 1,
                                      );
                                    }),
                              ),
                            ]),
                      ),
                    )
                        : Container(
                      color: Colors.black12,
                      child: const Center(
                        child: LoadingView(
                          indicatorColor: kPrimaryColor,
                          indicator: Indicator.ballSpinFadeLoader,
                        ),
                      ),
                    ),
                  ),

                  ///loading view
                  if (isLoading)
                    Container(
                      color: Colors.black12,
                      child: const Center(
                        child: LoadingView(
                          indicatorColor: kPrimaryColor,
                          indicator: Indicator.ballSpinFadeLoader,
                        ),
                      ),
                    ),
                ],
              ),
        ),
      ),
    );
  }

  int _getItemCount(CheckInVO checkInVO) {
    int totalCheckIn = checkInVO.currentCheckInDay.toString() == "null" ||
        checkInVO.currentCheckInDay.toString() == "0"
        ? 0
        : int.parse(checkInVO.currentCheckInDay.toString());
    if (totalCheckIn <= 10) {
      return 10;
    }
    int itemsToShow = ((totalCheckIn ~/ 10) + 1) * 10;
    return itemsToShow > totalCheckIn ? totalCheckIn : itemsToShow;
  }
}
