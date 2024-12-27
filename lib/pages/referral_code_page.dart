import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smile_shop/list_items/my_order_list_item_view.dart';
import 'package:smile_shop/pages/refund_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

class ReferralCodePage extends StatelessWidget {
  const ReferralCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration:const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFF8D4A0),
                  Color(0xFFF8E9B4),
                ],
              ),
            ),
          ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children:[
               ///app bar
               Container(
                 margin:const EdgeInsets.only(top: kMarginXXLarge),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                   InkWell(
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
                   const Text('Referral Code',style: TextStyle(fontSize: kTextRegular22,color: Colors.black,fontWeight: FontWeight.w600
                   ),),
                   Container()
                 ],),
               ),

               ///qr code view
               Container(
                 width: double.infinity,
                 padding:const EdgeInsets.symmetric(vertical: kMarginMedium2),
                 margin:const EdgeInsets.only(top: 146,left: kMarginMedium2,right: kMarginMedium2),
                 decoration: BoxDecoration(color: Colors.white,
               borderRadius: BorderRadius.circular(kMarginMedium2)),
               child:  Column(children: [
                 const Text('Your referral code is',style: TextStyle(fontSize: kTextSmall,color: Colors.black),),

                 const SizedBox(height: kMarginMedium2,),

                 const Text('7788999',style: TextStyle(fontSize: 32,color: kPrimaryColor,fontWeight: FontWeight.bold),),

                 const SizedBox(height: kMarginMedium2,),

                 Container(width: double.infinity,height: 2,color: Colors.black12,),

                 const SizedBox(height: kMarginMedium2,),

                 QrImageView(
                   data: 'https://smile.saxdihtan.asia/signup?referral_code=1234',
                   version: QrVersions.auto,
                   size: 220.0,
                 ),

                 const SizedBox(height: kMarginMedium2,),
                 
                 SizedBox(
                   width: 260,
                     child: CommonButtonView(label: 'Share Referral Code', labelColor: Colors.white, bgColor: kPrimaryColor, onTapButton: (){})),

                 const SizedBox(height: kMarginXXLarge,),

               ],),)
             ],
           ),
        ],
      ),
    );
  }
}
