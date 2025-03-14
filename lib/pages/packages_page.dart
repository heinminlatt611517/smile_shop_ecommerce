import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/package_bloc.dart';
import 'package:smile_shop/data/vos/package_vo.dart';
import 'package:smile_shop/list_items/package_list_item_view.dart';
import 'package:smile_shop/pages/package_details_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/dimens.dart';
import 'package:smile_shop/utils/images.dart';
import '../widgets/loading_view.dart';

class PackagePage extends StatelessWidget {
  const PackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PackageBloc(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(color: kBackgroundColor),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///app bar
                Container(
                  margin: const EdgeInsets.only(top: kMarginXXLarge),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(left: kMarginMedium2),
                            child: SvgPicture.asset(
                              kBackSvgIcon,
                              height: 26,
                              width: 26,
                            )
                            // Image.asset(
                            //   kBackIcon,
                            //   fit: BoxFit.contain,
                            //   height: 20,
                            //   width: 20,
                            // ),
                            ),
                      ),
                      const Expanded(
                        child: Text(
                          'Package',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: kTextRegular3x, color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: kMarginMedium2),
                        child: Container(width: 26,),
                      )
                    ],
                  ),
                ),

                ///package list view
                Expanded(
                  child: Selector<PackageBloc, bool>(
                    selector: (context, bloc) => bloc.isLoading,
                    builder: (context, isLoading, child) => Stack(
                      children: [
                        Selector<PackageBloc, bool>(
                          selector: (context, bloc) => bloc.isDealer,
                          builder: (context, isDealer, child) => Selector<PackageBloc, List<PackageVO>>(
                            selector: (context, bloc) => bloc.packages,
                            builder: (context, packages, child) => Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: kMarginMedium2),
                              margin: const EdgeInsets.only(left: kMarginMedium2, right: kMarginMedium2),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: packages.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: isDealer
                                            ? () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PackageDetailsPage(packageId: packages[index].id)));
                                              }
                                            : null,
                                        child: PackageListItemView(
                                          packageVO: packages[index],
                                        ));
                                  }),
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
