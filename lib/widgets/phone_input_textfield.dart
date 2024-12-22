import 'package:flutter/material.dart';

import '../data/dummy_data/country_code.dart';

Widget normalPhoneTextField(
    {required TextEditingController controller,
    required String hint,
    required String phoneCode,
    required BuildContext context,
    void Function(String)? onChangeTextField,
    required void Function(CountryCode?)? onChanged}) {
  return StatefulBuilder(
    builder: (_, setstate) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: 15,
          ),
          alignment: Alignment.center,
          height: 56,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              ),
          child: DropdownButton(
              dropdownColor: Colors.black,
              underline: const SizedBox.shrink(),
              hint: Text(
                phoneCode,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.black),
              ),
              items: countries
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        "${e.name} ${e.code}",
                        style: const TextStyle(color: Colors.white),
                      )))
                  .toList(),
              onChanged: onChanged),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              hintText: hint,
              fillColor: Colors.white,
              filled: true,
              hintStyle: const TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(0)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(0)),
            ),
            onChanged: (v){
              onChangeTextField!(v);
            },
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.phone,
          ),
        )
      ],
    ),
  );
}
