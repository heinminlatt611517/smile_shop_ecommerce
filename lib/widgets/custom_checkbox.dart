import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color:  Colors.transparent,
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: value
            ? const Icon(
                Icons.check,
                size: 16,
                color: kPrimaryColor,
              )
            : null,
      ),
    );
  }
}
