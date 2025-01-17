import 'package:flutter/material.dart';

Future<bool?> showCommonDialog({
  required BuildContext context,
  Widget? dialogWidget,
  bool? isDismissible
}) async {
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible:isDismissible ?? true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration:const Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.center ,
        child: SizedBox.expand(child: dialogWidget),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0,  -1), end:const Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}