import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';

class PromotionPointPage extends StatefulWidget {
  const PromotionPointPage({super.key});

  @override
  State<PromotionPointPage> createState() => _PromotionPointPageState();
}

int? _selectedSegment = 0;

class _PromotionPointPageState extends State<PromotionPointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kSecondaryColor,
        title: const Text('Promotion Point'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: kSecondaryColor,
            child: const Column(
              children: [
                Text(
                  'You have                 ',
                  style: TextStyle(
                      fontSize: kTextRegular, color: Colors.black),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  '500,000',
                  style: TextStyle(
                      fontSize: 32,
                      color: kBackgroundColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '        promotion points',
                  style: TextStyle(
                      fontSize: kTextSmall, color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
               
              
              ],
            ),
          ),
          Expanded(
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
                        child: const Text('Income Points'),
                      ),
                      1: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: const Text('Outcome Points'),
                      ),
                    },
                    thumbColor: kSecondaryColor,
                    groupValue: _selectedSegment,
                    onValueChanged: (value) {
                      setState(() {
                        _selectedSegment = value;
                      });
                    }),
                Expanded(
                    child: _selectedSegment == 0
                        ? _buildIncomePointListView()
                        : Container(
                            color: Colors.transparent,
                          ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}

Widget _buildIncomePointListView() {
  return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(children: [_pointItemView(), const Divider()]);
      });
}

Widget _pointItemView() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: const Column(
      children: [
        Row(
          children: [
            Icon(Icons.currency_bitcoin),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Income Points',
                        style: TextStyle(
                          fontSize: kTextSmall,
                        ),
                      ),
                      Text(
                        '+6000 Points',
                        style: TextStyle(
                            fontSize: kTextRegular2x, color: kSecondaryColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recharge',
                        style: TextStyle(fontSize: kTextRegular2x),
                      ),
                      Text(
                        'Nov 23,2024/10',
                        style: TextStyle(fontSize: kTextSmall),
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
