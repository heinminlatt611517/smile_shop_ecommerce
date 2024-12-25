import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../utils/images.dart';

class CustomAppBarView extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const CustomAppBarView({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      surfaceTintColor: kBackgroundColor,
      automaticallyImplyLeading: false,
      leadingWidth: 40,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: kMarginMedium2),
          child: Image.asset(
            kBackIcon,
            fit: BoxFit.contain,
            height: 20,
            width: 20,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      title: Text(
        title ?? "",
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
