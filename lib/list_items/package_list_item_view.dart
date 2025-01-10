import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:smile_shop/data/vos/package_vo.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';

class PackageListItemView extends StatelessWidget {
  final PackageVO? packageVO;
  const PackageListItemView({super.key, required this.packageVO});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kMarginLarge),
      padding: const EdgeInsets.symmetric(
          vertical: kMarginXLarge, horizontal: kMarginLarge),
      decoration: BoxDecoration(
          color: kBackgroundColor,
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(kMarginMedium)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            packageVO?.name ?? "",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Ks ${packageVO?.packagePrice}',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Benefits',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          HtmlWidget(packageVO?.benefits ?? "")
        ],
      ),
    );
  }
}
