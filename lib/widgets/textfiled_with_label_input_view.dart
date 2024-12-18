import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';

import '../utils/dimens.dart';

class TextFieldWithLabelInputView extends StatelessWidget {
  final String hint;
  final String label;
  final Function(String) onChanged;
  final Function()? toggleObscured;
  final bool isSecure;
  final bool? isPasswordView;

  const TextFieldWithLabelInputView({
    super.key,
    required this.hint,
    required this.label,
    required this.onChanged,
    this.isSecure = false,
    this.toggleObscured,
    this.isPasswordView = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style:const TextStyle(fontSize: kTextRegular,color: Colors.black),),
        const SizedBox(height: kMarginSmall,),
        TextField(
          onChanged: (text) {
            onChanged(text);
          },
          obscureText: isSecure,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:const TextStyle(fontSize: kTextRegular),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            suffixIcon:isPasswordView == true ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: GestureDetector(
                onTap: toggleObscured,
                child: Icon(
                  isSecure
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  size: 24,
                  color: kPrimaryColor,
                ),
              ),
            ) : null,
            fillColor: kBackgroundColor.withOpacity(0.5),
            filled: true
          ),
        ),
      ],
    );
  }
}
