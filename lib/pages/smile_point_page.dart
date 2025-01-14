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

import '../utils/images.dart';
import '../widgets/svg_image_view.dart';

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
          title:  Row(children: [InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child:const SvgImageView(
              imageName: kBackSvgIcon,
              imageHeight: 26,
              imageWidth: 26,
            ),
          ),
            const Spacer(),
            const Text('Smile Point'),
            const Spacer(),
            const Text(''),
          ],),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: kMarginMedium),
              child: Align(
                alignment: Alignment.centerRight,
                child: IntrinsicWidth(
                  child: InkWell(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) =>const WalletPasswordPage()));
                    },
                    child: Container(
                      padding:const EdgeInsets.symmetric(vertical: kMarginSmall,horizontal: kMarginMedium),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kMarginMedium),
                          border: Border.all(
                            color: Colors.white,
                          )),
                      child: const Center(
                        child: Column(
                          children: [
                            Icon(Icons.lock),
                            Text('Password',style: TextStyle(fontSize: kTextSmall),),
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
           Selector<SmileWalletBloc,WalletVO?>(
             selector: (context,bloc)=>bloc.walletVO,
             builder: (context,walletData,child)=>
              Container(
               width: double.infinity,
               color: kSecondaryColor,
               child: Column(
                 children: [
                   const Text(
                     'You have                 ',
                     style: TextStyle(
                         fontSize: kTextRegular, color: kBackgroundColor),
                   ),
                   const SizedBox(
                     height: 7,
                   ),
                    Text(
                     walletData?.amount.toString() ?? "",
                     style:const TextStyle(
                         fontSize: 32,
                         color: Colors.black,
                         fontWeight: FontWeight.bold),
                   ),
                   const Text(
                     '                You have',
                     style: TextStyle(
                         fontSize: kTextRegular, color: kBackgroundColor),
                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   GestureDetector(
                     onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(
                           builder: (builder) =>const WalletPaymentMethodPage()));
                     },
                     child: Container(
                       height: 28,
                       width: 122,
                       decoration: BoxDecoration(
                           color: kFillingFastColor,
                           borderRadius: BorderRadius.circular(4)),
                       child: const Center(
                         child: Text(
                           'Recharge',
                           style: TextStyle(color: kBackgroundColor),
                         ),
                       ),
                     ),
                   ),
                   const SizedBox(
                     height: 18,
                   ),
                   Consumer<SmileWalletBloc>(
                     builder: (context,bloc,child)=>
                      Visibility(
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
                      child: const Text('Income Points'),
                    ),
                    1: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text('Outcome Points'),
                    ),
                  },
                  thumbColor: kSecondaryColor,
                  groupValue: bloc.selectedSegment,
                  onValueChanged: (value) {
                    bloc.onChangedSegmentedControl(value ?? 0);
                  },
                ),
                Expanded(
                  child: Selector<SmileWalletBloc, List<WalletTransactionVO>>(
                    selector: (context, bloc) => bloc.walletTransactions,
                    builder: (context, walletTransactions, child) =>
                        Selector<SmileWalletBloc, bool>(
                          selector: (context, bloc) => bloc.isLoading,
                          builder: (context, isLoading, child) => Stack(
                            children: [
                              bloc.selectedSegment == 0
                                  ? _buildIncomeAndOutcomePointListView(walletTransactions, 'Income Points')
                                  : _buildIncomeAndOutcomePointListView(walletTransactions, 'Outcome Points'),
                              // Loading view
                              if (isLoading)
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Center(
                                    child: CircularProgressIndicator(color: kPrimaryColor,)
                                  ),
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

Widget _buildIncomeAndOutcomePointListView(List<WalletTransactionVO> walletTransactionList, String pointLabel) {
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

Widget _pointItemView(String pointLabel, WalletTransactionVO walletTransactionVO) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Column(
      children: [
        Row(
          children: [
            const Icon(Icons.currency_bitcoin),
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
                        pointLabel == 'Outcome Points'? '-${walletTransactionVO.points} Points' : '+${walletTransactionVO.points} Points',
                        style: const TextStyle(fontSize: kTextRegular2x, color: kSecondaryColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        pointLabel == 'Outcome Points'? 'Discharge' :'Recharge',
                        style:const TextStyle(fontSize: kTextRegular2x),
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy/HH').format(DateTime.parse(walletTransactionVO.date.toString())),
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

