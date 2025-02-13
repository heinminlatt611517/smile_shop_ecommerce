import 'package:flutter/material.dart';

import '../utils/dimens.dart';

class CommonButtonView extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color bgColor;
  final bool isShowBorder;
  final Function() onTapButton;

  const CommonButtonView({
    super.key,
    required this.label,
    required this.labelColor,
    required this.bgColor,
    required this.onTapButton,
    this.isShowBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapButton,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: (isShowBorder)
                ? Border.all(
                    color: Colors.black,
                    width: isShowBorder == true ? 1 : 0,
                  )
                : null,
            color: bgColor,
            borderRadius: BorderRadius.circular(kMarginSmall)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kMargin10),
            child: Text(
              label,
              style: TextStyle(color: labelColor, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
