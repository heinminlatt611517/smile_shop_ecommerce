import 'package:flutter/material.dart';

class DailyCheckInListItem extends StatelessWidget {
  const DailyCheckInListItem(
      {super.key, required this.day, required this.bgColor});

  final int day;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: bgColor.withValues(alpha: 0.2)),
          child: Center(
            child: Text('Day$day'),
          ),
        ),
        Positioned(
          top: -20,
          child: Container(
            padding: const EdgeInsets.all(5),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: bgColor.withValues(alpha: 0.5)),
            child: Container(
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: const Center(
                  child: Text(
                '10',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        )
      ],
    );
  }
}
