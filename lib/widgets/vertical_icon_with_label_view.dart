import 'package:flutter/material.dart';

class VerticalIconWithLabelView extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() onTap;

  const VerticalIconWithLabelView(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 20,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            textAlign: TextAlign.center,
            label,
            style: const TextStyle(color: Colors.black, fontSize: 12),
          )
        ],
      ),
    );
  }
}
