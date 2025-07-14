import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/smile_wallet_bloc.dart';
import 'package:smile_shop/data/vos/wallet_transaction_vo.dart';
import 'package:smile_shop/data/vos/wallet_vo.dart';
import 'package:smile_shop/pages/wallet_password_page.dart';
import 'package:smile_shop/pages/wallet_payment_method_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/extensions.dart';

import '../utils/images.dart';
import '../widgets/svg_image_view.dart';
import 'package:smile_shop/localization/app_localizations.dart';

class SmilePointPage extends StatelessWidget {
  const SmilePointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SmileWalletBloc(),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kSecondaryColor,
          surfaceTintColor: kSecondaryColor,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: kMarginMedium2),
            child: Row(
              children: [
                SizedBox(
                  width: 26,
                  height: 26,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const SvgImageView(
                      imageName: kBackSvgIcon,
                      imageHeight: 26,
                      imageWidth: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Row(
            children: [
              const Spacer(),
              Text(
                AppLocalizations.of(context)?.smilePoint ?? '',
                style: const TextStyle(
                    fontSize: kTextRegular3x,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              const Text(''),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: kMarginMedium),
              child: Align(
                alignment: Alignment.centerRight,
                child: IntrinsicWidth(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => const WalletPasswordPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: kMarginSmall, horizontal: kMarginMedium),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kMarginMedium),
                          border: Border.all(
                            color: Colors.white,
                          )),
                      child: const Center(
                        child: Column(
                          children: [
                            Icon(Icons.lock),
                            Text(
                              'Password',
                              style: TextStyle(fontSize: kTextSmall),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Selector<SmileWalletBloc, WalletVO?>(
              selector: (context, bloc) => bloc.walletVO,
              builder: (context, walletData, child) => Container(
                width: double.infinity,
                color: kSecondaryColor,
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
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
                                walletData?.amount?.formatWithCommas() ?? "0",
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          const Text(
                            'Smile Points',
                            style: TextStyle(
                                fontSize: kTextRegular,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) =>
                                      const WalletPaymentMethodPage()));
                            },
                            child: IntrinsicWidth(
                              child: Container(
                                // height: 28,
                                decoration: BoxDecoration(
                                    color: kFillingFastColor,
                                    borderRadius: BorderRadius.circular(4)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kMarginMedium2,
                                    vertical: kMarginMedium),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)?.recharge ??
                                        '',
                                    style: const TextStyle(
                                        color: kBackgroundColor,
                                        fontSize: kTextRegular),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Consumer<SmileWalletBloc>(
                      builder: (context, bloc, child) => Visibility(
                        visible: bloc.isShowSetPasswordText,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 60,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: kBackgroundColor)),
                          child: const Center(
                            child: Text(
                              'Please set password to secure your smile point.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    )
                  ],
                ),
              ),
            ),
            Consumer<SmileWalletBloc>(
              builder: (context, bloc, child) => Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
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
                        },
                      ),
                      Expanded(
                        child: Selector<SmileWalletBloc,
                            List<WalletTransactionVO>>(
                          selector: (context, bloc) => bloc.walletTransactions,
                          builder: (context, walletTransactions, child) =>
                              Selector<SmileWalletBloc, bool>(
                            selector: (context, bloc) => bloc.isLoading,
                            builder: (context, isLoading, child) => Stack(
                              children: [
                                bloc.selectedSegment == 0
                                    ? _buildIncomeAndOutcomePointListView(
                                        walletTransactions,
                                        AppLocalizations.of(context)
                                                ?.incomePoints ??
                                            '')
                                    : _buildIncomeAndOutcomePointListView(
                                        walletTransactions,
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildIncomeAndOutcomePointListView(
    List<WalletTransactionVO> walletTransactionList, String pointLabel) {
  return ListView.builder(
    shrinkWrap: true, // Ensures the list doesn't take up unnecessary space
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    itemCount: walletTransactionList.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          _pointItemView(pointLabel, walletTransactionList[index]),
          const Divider(),
        ],
      );
    },
  );
}

Widget _pointItemView(
    String pointLabel, WalletTransactionVO walletTransactionVO) {
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
                            ? '-${walletTransactionVO.points} Points'
                            : '+${walletTransactionVO.points} Points',
                        style: const TextStyle(
                            fontSize: kTextRegular2x, color: kSecondaryColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        walletTransactionVO.paymentType
                                ?.toTitleCaseFromSnakeCase() ??
                            "",
                        style: const TextStyle(fontSize: kTextRegular2x),
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy/HH').format(DateTime.parse(
                            walletTransactionVO.date.toString())),
                        style: const TextStyle(fontSize: kTextSmall),
                      ),
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
