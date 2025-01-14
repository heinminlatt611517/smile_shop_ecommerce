import 'package:flutter/material.dart';

import '../utils/dimens.dart';

class InputViewLockIcon extends StatelessWidget {
  final Function(String) onChangeValue;
  final String hintLabel;
  final bool? isMailIcon;
  final Function()? toggleObscured;
  final bool isSecure;

  const InputViewLockIcon(
      {super.key,
      required this.onChangeValue,
      required this.hintLabel,
      this.isMailIcon,
      required this.isSecure,
      this.toggleObscured});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        color: Colors.white,
        height: 55,
        child: Row(
          children: [
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(left: kMarginMedium2),
              child: Row(
                children: [
                  isMailIcon == true
                      ? const Icon(
                          Icons.mail,
                          color: Colors.grey,
                          size: 20,
                        )
                      : const Icon(
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
                obscureText: isSecure,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    suffixIcon: isMailIcon == true
                        ? null
                        : GestureDetector(
                            onTap: toggleObscured,
                            child: Icon(
                              isSecure
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              size: 24,
                              color: Colors.black,
                            ),
                          ),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    contentPadding: isMailIcon == true
                        ? const EdgeInsets.only(left: kMarginMedium2)
                        : const EdgeInsets.only(
                            top: kMargin10, left: kMarginMedium2),
                    hintText: hintLabel,
                    hintStyle: const TextStyle(color: Colors.grey)),
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
