import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/product_refund_bloc.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/list_items/my_order_list_item_view.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/refund_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import 'package:smile_shop/widgets/common_dialog.dart';

import '../widgets/cached_network_image_view.dart';
import '../widgets/error_dialog_view.dart';
import '../widgets/loading_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProductRefundPage extends StatelessWidget {
  final OrderVO? orderVO;
  const ProductRefundPage({super.key,this.orderVO});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductRefundBloc((int.parse(orderVO?.orderNo.toString() ?? ""))),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          toolbarHeight: 60,
          title:  Text(AppLocalizations.of(context)!.productRefund),
        ),
        body: Selector<ProductRefundBloc,bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, child) =>
           Stack(
             children: [
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                         AppLocalizations.of(context)!.youNeedToSendYourRefundItem,
                        style:const TextStyle(fontSize: kTextRegular),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: kFillingFastColor,
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Smile Shop',
                                      style: TextStyle(fontSize: kTextRegular),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                        '09888888888',
                                        style: TextStyle(fontSize: kTextRegular),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'No 34, Baho Road, Hlaing Township',
                                  style: TextStyle(fontSize: kTextRegular),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      OrderProductView(orderVO: orderVO),
                      const SizedBox(
                        height: 20,
                      ),
                      //drop down
                      const RefundDropDown(),

                      // upload photo
                      const SizedBox(
                        height: 20,
                      ),
                      const UploadPhotoView(),

                      const SizedBox(
                        height: 50,
                      ),

                      Consumer<ProductRefundBloc>(
                        builder: (context,bloc,child)=>
                         GestureDetector(
                          onTap: () {
                            bloc.onTapDone().then((value) {
                              if (value.statusCode == 200) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => const RefundPage()));
                              }
                            }).catchError((error) {
                              showCommonDialog(
                                  context: context,
                                  dialogWidget: ErrorDialogView(
                                      errorMessage: error.toString()));
                            });
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(4)),
                            child:  Center(
                              child: Text(
                                AppLocalizations.of(context)!.done,
                                style:const TextStyle(color: kBackgroundColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                         ),

               ///loading view
               if (isLoading)
                 Container(
                   color: Colors.black12,
                   child: const Center(
                     child: LoadingView(
                       indicatorColor: kPrimaryColor,
                       indicator: Indicator.ballSpinFadeLoader,
                     ),
                   ),
                 ),
             ],
           ),
        ),
      ),
    );
  }
}

///dropdown
class RefundDropDown extends StatefulWidget {
  const RefundDropDown({super.key});

  @override
  @override
  State<RefundDropDown> createState() => _RefundDropDownState();
}

class _RefundDropDownState extends State<RefundDropDown> {
  String? _selectedValue; // Selected value, initially null.

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(AppLocalizations.of(context)!.chooseRefundReason,style:const TextStyle(fontSize: kTextRegular2x),),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: kHintSearchLocationColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<String>(
            underline: const SizedBox.shrink(),
            value: _selectedValue,
            isExpanded: true,
            hint: const Text('Choose One'),
            items: <String>['Option 1', 'Option 2', 'Option 3']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedValue = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}

///upload photo
class UploadPhotoView extends StatefulWidget {
  const UploadPhotoView({super.key});

  @override
  State<UploadPhotoView> createState() => _UploadPhotoViewState();
}

class _UploadPhotoViewState extends State<UploadPhotoView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductRefundBloc>(
      builder: (context,bloc,child)=>
      bloc.imgFile == null ?
       InkWell(
         onTap: (){
           bloc.uploadImage();
         },
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(AppLocalizations.of(context)!.uploadPhoto),
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Image.asset(kPhotoFrameImage),
                ),
                const Icon(Icons.add)
              ],
            )
          ],
               ),
       ) : ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          height: 100,
          width: double.infinity,
          bloc.imgFile ?? File(""),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class OrderProductView extends StatelessWidget {
  final OrderVO? orderVO;
  const OrderProductView({super.key,required this.orderVO});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                getStatusMessage(orderVO?.paymentStatus ?? ""),
                style: const TextStyle(color: kFillingFastColor),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImageView(
                  imageHeight: 80,
                  imageWidth: 80,
                  imageUrl: orderVO?.orderProducts?.first.product?.image ??
                      errorImageUrl,
                ),
              ),
              const SizedBox(
                width: kMarginMedium3,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderVO?.orderProducts?.first.product?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                          fontSize: kTextRegular2x,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: kMargin10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          'Ks ${orderVO?.orderProducts?.first.price ?? ''}',
                          style: const TextStyle(fontSize: kTextRegular2x),
                        ),
                        const SizedBox(
                          width: kMargin30,
                        ),
                        Text(
                          'Qty: ${orderVO?.orderProducts?.first.qty ?? ''}',
                          style: const TextStyle(fontSize: kTextSmall),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: kMargin10,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Total(${orderVO?.orderProducts?.first.qty ?? ''} item): Ks ${orderVO?.orderProducts?.first.subtotal ?? ''}',
                          style: const TextStyle(fontSize: kTextSmall),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

