import 'package:flutter/material.dart';

import '../data/dummy_data/country_code.dart';

Widget normalPhoneTextField(
    {required TextEditingController controller,
    required String hint,
    required String phoneCode,
    required BuildContext context,
    required void Function(CountryCode?)? onChanged}) {
  return StatefulBuilder(
    builder: (_, setstate) => Container(
        // height: 55,
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                right: 15,
              ),
              alignment: Alignment.center,
              height: 55,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
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
                  hintStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.phone,
              ),
            )
          ],
        )),
  );
}