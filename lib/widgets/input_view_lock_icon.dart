import 'package:flutter/material.dart';

import '../utils/dimens.dart';

class InputViewLockIcon extends StatelessWidget {
  final Function(String) onChangeValue;
  final String hintLabel;
  final bool? isMailIcon;
  const InputViewLockIcon({super.key,required this.onChangeValue,required this.hintLabel,this.isMailIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        color: Colors.white,
        height: 55,
        child: Row(
          children: [
            Container(
              color : Colors.white,
              margin:
               const EdgeInsets.only(left: kMarginMedium2),
              child: Row(
                children: [
                  isMailIcon == true ? const Icon(
                    Icons.mail,
                    color: Colors.grey,
                    size: 20,
                  ) : const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 1,
                    height: 34,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            Expanded(
              child: TextField(
                cursorColor: Colors.black,
                decoration:  InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 21),
                    hintText: hintLabel,
                    hintStyle:const TextStyle(color: Colors.grey)),
                onChanged: (v) {
                  onChangeValue(v);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
