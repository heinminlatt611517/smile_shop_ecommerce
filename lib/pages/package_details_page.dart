import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/package_details_bloc.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';

import '../widgets/loading_view.dart';

class PackageDetailsPage extends StatelessWidget {
  final int? packageId;

  const PackageDetailsPage({super.key, required this.packageId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PackageDetailsBloc(packageId),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(color: kBackgroundColor),
            ),
            Selector<PackageDetailsBloc,bool>(
              selector: (context,bloc)=>bloc.isLoading,
              builder: (context,isLoading,child)=>
               Stack(
                 children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///app bar
                      Container(
                        margin: const EdgeInsets.only(top: kMarginXXLarge),
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
                            const Text(
                              '',
                              style: TextStyle(
                                  fontSize: kTextRegular22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container()
                          ],
                        ),
                      ),

                      ///gold package dealer
                       Consumer<PackageDetailsBloc>(
                         builder: (context, bloc, child) => Padding(
                           padding: const EdgeInsets.all(kMarginMedium2),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               ///gold package dealer
                               Container(
                                 padding: const EdgeInsets.all(kMarginMedium2),
                                 decoration: BoxDecoration(
                                     color: const Color(0xffF7E1C5),
                                     borderRadius:
                                     BorderRadius.circular(kMarginMedium2)),
                                 child: Column(
                                   children: [
                                     const Row(
                                       children: [
                                         Icon(Icons.title),
                                         Text(
                                           'Gold Package Dealer',
                                           style: TextStyle(
                                               fontSize: kTextRegular2x,
                                               fontWeight: FontWeight.bold,
                                               color: Colors.black),
                                         )
                                       ],
                                     ),

                                     const SizedBox(
                                       height: 20,
                                     ),

                                     ///progress view
                                     Row(
                                       children: [
                                         const Text(
                                           'Current Progress',
                                           style: TextStyle(
                                               fontSize: kTextSmall,
                                               color: Colors.black),
                                         ),
                                         const Spacer(),
                                         Text(
                                           '${bloc.packages?.packagePrice ?? 0}/1,000,000',
                                           style: const TextStyle(
                                               fontSize: kTextSmall,
                                               color: Colors.black),
                                         )
                                       ],
                                     ),
                                     const SizedBox(
                                       height: 10,
                                     ),

                                     ///linear progress
                                     if (bloc.packages?.packagePrice != null)
                                       LinearProgressIndicator(
                                         minHeight: 10,
                                         value: bloc.packages!.packagePrice! /
                                             1000000,
                                         backgroundColor: Colors.grey,
                                         valueColor:
                                         const AlwaysStoppedAnimation<Color>(
                                             kSecondaryColor),
                                       ),

                                     const SizedBox(
                                       height: 10,
                                     ),

                                     const Row(
                                       children: [
                                         Text(
                                           'Gold Package',
                                           style: TextStyle(
                                               fontSize: kTextSmall,
                                               color: Colors.black),
                                         ),
                                         Spacer(),
                                         Row(
                                           children: [
                                             Icon(
                                               Icons.diamond,
                                               size: 14,
                                             ),
                                             Text(
                                               'Diamond Package',
                                               style: TextStyle(
                                                   fontSize: kTextSmall,
                                                   color: Colors.black),
                                             ),
                                           ],
                                         )
                                       ],
                                     ),
                                   ],
                                 ),
                               ),

                               const SizedBox(
                                 height: 20,
                               ),

                               ///benefits view
                               const Text(
                                 'Benefits',
                                 style: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.normal,
                                     color: Colors.black),
                               ),
                               const SizedBox(
                                 height: 10,
                               ),
                               Container(
                                 padding: const EdgeInsets.all(kMarginMedium2),
                                 decoration: BoxDecoration(
                                     borderRadius:
                                     BorderRadius.circular(kMarginMedium2),
                                     border: Border.all(color: kPrimaryColor)),
                                 child:  HtmlWidget(bloc.packages?.benefits ?? ""),
                               )
                             ],
                           ),
                         ),
                       ),
                    ],
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
          ],
        ),
      ),
    );
  }
}
