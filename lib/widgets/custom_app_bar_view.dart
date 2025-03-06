import 'package:flutter/material.dart';
import 'package:smile_shop/widgets/svg_image_view.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../utils/images.dart';

class CustomAppBarView extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? backgroundColor;
  const CustomAppBarView({super.key, required this.title, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      surfaceTintColor: backgroundColor ?? kBackgroundColor,
      automaticallyImplyLeading: false,
      leadingWidth: 40,
      backgroundColor: backgroundColor ?? kBackgroundColor,
      title: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: const SvgImageView(
              imageName: kBackSvgIcon,
              imageHeight: 26,
              imageWidth: 26,
            ),
          ),
          const Spacer(),
          Text(title ?? "" , style: const TextStyle(fontSize: kTextRegular2x, fontWeight: FontWeight.bold),),
          const Spacer(),
          const Text(''),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
