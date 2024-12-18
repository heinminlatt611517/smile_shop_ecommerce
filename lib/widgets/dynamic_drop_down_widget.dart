import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../utils/dimens.dart';
import '../utils/colors.dart';

/// * Area for stateProvider

class DynamicDropDownWidget<T> extends StatelessWidget {
  const DynamicDropDownWidget(
      {super.key,
      required this.items,
      required this.onSelect,
      required this.label,
      this.defaultBgColor = true,
      this.hintText,
      this.initValue});

  final List<dynamic> items;
  final void Function(dynamic) onSelect;
  final bool defaultBgColor;
  final dynamic initValue;
  final String? hintText;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style:const TextStyle(fontSize: kTextRegular,color: Colors.black),),
          const SizedBox(height: kMarginSmall,),
          DropdownButtonFormField2<dynamic>(
            value: initValue,
            hint: Text(
              hintText ?? '',
              style: const TextStyle(color: Colors.grey),
            ),
            isExpanded: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kMarginMedium),
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5)),
              filled: true,
              fillColor: kBackgroundColor.withOpacity(0.5),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: kMarginLarge),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kMarginSmall),
              ),
            ),
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((dynamic item) {
                return Text(
                  item.name,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16, // Set the text color for the selected item
                  ),
                );
              }).toList();
            },
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) => onSelect(value),
            validator: (value) {
              if (value == null) {
                return 'Please select';
              }
              return null;
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ],
      ),
    );
  }
}
