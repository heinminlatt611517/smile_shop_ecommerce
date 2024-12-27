import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smile_shop/list_items/my_order_list_item_view.dart';
import 'package:smile_shop/list_items/package_list_item_view.dart';
import 'package:smile_shop/pages/refund_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/common_button_view.dart';
import 'package:smile_shop/widgets/custom_app_bar_view.dart';

class PackagePage extends StatelessWidget {
  const PackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration:const BoxDecoration(
              color: kBackgroundColor
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
                   const Text('Package',style: TextStyle(fontSize: kTextRegular22,color: Colors.black,fontWeight: FontWeight.w600
                   ),),
                   Container()
                 ],),
               ),

               ///qr code view
               Expanded(
                 child: Container(
                   width: double.infinity,
                   padding:const EdgeInsets.symmetric(vertical: kMarginMedium2),
                   margin:const EdgeInsets.only(left: kMarginMedium2,right: kMarginMedium2),
                 child:  ListView.builder(
                     shrinkWrap: true,
                     itemCount: 4,
                     itemBuilder: (context,index){
                   return const PackageListItemView();
                 }),),
               )
             ],
           ),
        ],
      ),
    );
  }
}
