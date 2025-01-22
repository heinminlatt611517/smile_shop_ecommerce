import 'package:flutter/material.dart';
import 'package:smile_shop/widgets/svg_image_view.dart';

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
      backgroundColor: Colors.white,
      title:  Row(children: [InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child:const SvgImageView(
          imageName: kBackSvgIcon,
          imageHeight: 20,
          imageWidth: 20,
        ),
      ),
        const Spacer(),
        Text(title ?? ""),
        const Spacer(),
        const Text(''),
      ],),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
