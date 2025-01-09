import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/blocs/order_bloc.dart';
import 'package:smile_shop/data/dummy_data/my_order_tab_bar_dummy_data.dart';
import 'package:smile_shop/data/vos/order_vo.dart';
import 'package:smile_shop/list_items/my_order_list_item_view.dart';
import 'package:smile_shop/network/api_constants.dart';
import 'package:smile_shop/pages/order_detail_page.dart';
import 'package:smile_shop/pages/payment_method_page.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/extensions.dart';

import '../widgets/loading_view.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key, this.tabIndex});

  final int? tabIndex;

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.animateTo(widget.tabIndex ?? 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderBloc(widget.tabIndex ?? 0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          toolbarHeight: 60,
          title: const Text('My Orders'),
          bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 50),
              child: Consumer<OrderBloc>(
                builder: (context, bloc, child) => TabBar(
                    labelColor: kFillingFastColor,
                    physics: const NeverScrollableScrollPhysics(),
                    dividerColor: Colors.transparent,
                    indicatorColor: kFillingFastColor,
                    isScrollable: false,
                    labelPadding: const EdgeInsets.all(13),
                    indicatorPadding: const EdgeInsets.only(bottom: 5),
                    tabAlignment: TabAlignment.center,
                    controller: _tabController,
                    onTap: (index) {
                      if (index == 0) {
                        bloc.getAllOrder();
                      }
                      if (index == 1) {
                        bloc.getOrdersByType(kTypeToPay);
                      }
                      if (index == 2) {
                        bloc.getOrdersByType(kTypeToShip);
                      }
                      if (index == 3) {
                        bloc.getOrdersByType(kTypeToReceive);
                      }
                      if (index == 4) {
                        bloc.getOrdersByType(kTypeToReview);
                      }
                    },
                    tabs: myOrderTabBarDummyData.map((value) {
                      return Text(value.toTitleCase);
                    }).toList()),
              )),
        ),
        body: Selector<OrderBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              Selector<OrderBloc, List<OrderVO>>(
                selector: (context, bloc) => bloc.orders,
                builder: (context, orders, child) => orders.isEmpty
                    ? const Center(
                        child: Text(''),
                      )
                    : TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                            _myOrderView(orders),
                            _myOrderView(orders),
                            _myOrderView(orders),
                            _myOrderView(orders),
                            _myOrderView(orders),
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

  Widget _myOrderView(List<OrderVO> orderList) {
    return Selector<OrderBloc, bool>(
      selector: (_, bloc) => bloc.isLoading,
      builder: (_, isLoading, child) => Container(
        color: kBackgroundColor,
        child: ListView.builder(
            itemCount: orderList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (orderList[index].paymentStatus != "not_pay") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => OrderDetailPage(
                              orderStatus: orderList[index].paymentStatus ?? "",
                              orderNumber: orderList[index].orderNo ?? '',
                            )));
                  }
                },
                child: MyOrderListItemView(
                  orderVO: orderList[index],
                  isRefundView: false,
                  onTapPayment: (orderId) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) =>  PaymentMethodPage(
                              isFromMyOrderPage: true,
                              orderNumber: orderList[index].orderNo ?? '',
                            )));
                  },
                  onTapCancel: (String orderId) {
                    var bloc = context.read<OrderBloc>();
                    bloc.onTapCancelOrder(orderId);
                  },
                ),
              );
            }),
      ),
    );
  }
}
