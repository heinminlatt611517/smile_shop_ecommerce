import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../utils/dimens.dart';

class QrDialogView extends StatelessWidget {
  final String qrCodeString;
  const QrDialogView({super.key,required this.qrCodeString});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:const EdgeInsets.all(10),
      surfaceTintColor: Colors.white,
      child: Container(
        padding:const EdgeInsets.all(kMarginMedium2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kMarginMedium2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            const SizedBox(height: 20,),
            const Text('To complete your purchase\nscan this QR code',
              textAlign: TextAlign.center,
              style:TextStyle(fontSize: kTextRegular,color: Colors.black,fontWeight: FontWeight.normal),),

            const SizedBox(height: 20,),

            QrImageView(
              data: qrCodeString,
              version: QrVersions.auto,
              size: 160.0,
            ),


            const SizedBox(height: 20,)
          ],),
      ),
    );
  }
}