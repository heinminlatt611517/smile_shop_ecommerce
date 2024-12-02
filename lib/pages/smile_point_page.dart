import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';

class SmilePointPage extends StatelessWidget {
  const SmilePointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kSecondaryColor,
        title: const Text('Smile Point'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: kSecondaryColor,
            height: 100,
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            color: kBackgroundColor,
          ))
        ],
      ),
    );
  }
}
