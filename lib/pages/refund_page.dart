import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/retund_bloc.dart';
import 'package:smile_shop/data/vos/refund_vo.dart';
import 'package:smile_shop/list_items/refund_list_item_view.dart';
import 'package:smile_shop/utils/colors.dart';

import '../utils/images.dart';
import '../widgets/loading_view.dart';
import '../widgets/svg_image_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RefundPage extends StatefulWidget {
  const RefundPage({super.key});

  @override
  State<RefundPage> createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RefundBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child:const SvgImageView(
              imageName: kBackSvgIcon,
              imageHeight: 26,
              imageWidth: 26,
            ),
          ),
              Text(AppLocalizations.of(context)?.refund ?? ''),
              const SizedBox()
          ],),
          bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 50),
              child: Consumer<RefundBloc>(
                builder: (context, bloc, child) => TabBar(
                    labelColor: kFillingFastColor,
                    dividerColor: Colors.transparent,
                    indicatorColor: kFillingFastColor,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.all(13),
                    indicatorPadding: const EdgeInsets.only(bottom: 5),
                    tabAlignment: TabAlignment.start,
                    controller: _tabController,
                    onTap: (index) {
                      if (index == 0) {
                        bloc.getRefundList();
                      }
                      if (index == 1) {
                        ///pending
                        bloc.getRefundListByStatus(0);
                      }
                      if (index == 2) {
                        ///approved
                        bloc.getRefundListByStatus(1);
                      }
                      if (index == 3) {
                        ///rejected
                        bloc.getRefundListByStatus(2);
                      }
                    },
                    tabs:  [
                      Text(AppLocalizations.of(context)?.all ?? ''),
                      Text(AppLocalizations.of(context)?.pending ?? ''),
                      Text(AppLocalizations.of(context)?.approved ?? ''),
                      Text(AppLocalizations.of(context)?.rejected ?? ''),
                    ]),
              )),
        ),
        body: Selector<RefundBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) =>
              Stack(
                children: [
                  ///body view
                  Selector<RefundBloc, List<RefundVO>>(
                              selector: (context, bloc) => bloc.refundList,
                              builder: (context, refunds, child) =>
                    TabBarView(controller: _tabController, children: [
                  _refundView(refundList: refunds),
                  _refundView(refundList: refunds),
                  _refundView(refundList: refunds),
                  _refundView(refundList: refunds),
                              ]),
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

  Widget _refundView({required List<RefundVO> refundList}) {
    return Container(
      color: kBackgroundColor,
      child: ListView.builder(
          itemCount: refundList.length,
          itemBuilder: (context, index) {
            return RefundListItemView(refundVO: refundList[index],);
          }),
    );
  }
}
