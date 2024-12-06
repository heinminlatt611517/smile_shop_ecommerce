import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';

class SmilePointPage extends StatefulWidget {
  const SmilePointPage({super.key});

  @override
  State<SmilePointPage> createState() => _SmilePointPageState();
}

int? _selectedSegment = 0;

class _SmilePointPageState extends State<SmilePointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kSecondaryColor,
        surfaceTintColor: kSecondaryColor,
        title: const Text('Smile Point'),
      ),
      body: Column(
        children: [
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
                const Text(
                  '500,000',
                  style: TextStyle(
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
                    
                  },
                  child: Container(
                    height: 28,
                    width: 122,
                    decoration: BoxDecoration(
                        color: kFillingFastColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Center(
                      child: Text(
                        'Recharge Point',
                        style: TextStyle(color: kBackgroundColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
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
                const SizedBox(
                  height: 14,
                )
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
